import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:mogawe/core/data/response/form/form_model.dart';
import 'package:mogawe/modules/form/bloc/form_event.dart';
import 'package:mogawe/modules/form/bloc/form_state.dart';
import 'package:mogawe/modules/form/standart/fact_widget_generator.dart';
import 'package:mogawe/modules/form/tracker/model/activity_tracker.dart';
import 'package:mogawe/utils/global/common_function.dart';

import 'bloc/form_bloc.dart';
import 'widget/activity_tracker_item.dart';

class FormLoadingScreen extends StatefulWidget {
  final String idTask;
  final int currentTimeInMillis;

  const FormLoadingScreen(
      {Key? key, required this.idTask, required this.currentTimeInMillis})
      : super(key: key);

  @override
  _FormLoadingScreenState createState() => _FormLoadingScreenState();
}

class _FormLoadingScreenState extends State<FormLoadingScreen> {
  late FormBloc bloc;
  var logger = Logger(printer: PrettyPrinter());
  int _currentIndex = 0;
  List<ActivityTracker> _activityTrackers = [];

  @override
  void initState() {
    super.initState();
    bloc = FormBloc();
    bloc.add(StartForm(widget.idTask, widget.currentTimeInMillis));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    bloc.close();
  }

  Widget blocListener(Widget child) {
    return BlocListener(
      bloc: bloc,
      listener: (ctx, state) => print("$state"),
      child: child,
    );
  }

  Widget blocBuilder() {
    return BlocBuilder(
      bloc: bloc,
      builder: (ctx, state) {
        if (state is ShowLoadingForm) {
          print("State : $state");
          return _buildLoadingForm();
        }
        if (state is ShowTrackerActivityForm) {
          logger.d("State : $state");
          _convertSectionsToTrackers(state.forms);
          return _buildTrackerForm(state.forms);
        }
        if (state is ShowContinuousForm) {
          logger.d("State : $state");
          return _buildContinuousForm(state.forms);
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(blocBuilder());
  }

  Widget _buildContinuousForm(List<FormModel> forms) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
            child: _buildFormSection(
                forms[_currentIndex], _currentIndex, forms.length - 1)),
      ),
    );
  }

  Widget _buildTrackerForm(List<FormModel> forms) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
            child: ListView.builder(
          itemCount: forms.length,
          itemBuilder: (context, index) {
            return FormActivityTrackerItem(
                forms: forms,
                changeTrackerStatus: (tracker) => _changeSectionTrackerState(tracker),
                activityTracker: _activityTrackers[index]);
          },
        )),
      ),
    );
  }

  Widget _buildFormSection(FormModel form, int currentIndex, int lastIndex) {
      AppBar appBar = AppBar(
        title: Text(form.name),
      );
    return BlocProvider(
      create: (context) => bloc,
      child: Flexible(
        child: Column(
          children: [
            appBar,
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: StandardFactWidgetGenerator(
                  currentIndex: currentIndex,
                  lastIndex: lastIndex,
                  nextFormSection: (index) {
                    bloc.add(ResetCounter());
                    setState(() {
                      _currentIndex = index + 1;
                    });
                  },
                  facts: form.facts),
            ),
            SizedBox(
              height: 12,
            ),
            _buildFormFooter(form.facts.length, 50)
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingForm() {
    String loadingAssetPath =
        'assets/lottie_animations/lottie_loading_form.json';
    return Scaffold(body: Center(child: Lottie.asset(loadingAssetPath)));
  }

  Widget _buildFormFooter(int factTotal, double footerHeight) {
    return Container(
      height: footerHeight,
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54, blurRadius: 10.0, offset: Offset(0.0, 1.2))
      ], color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: bloc.currentProgress,
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                print("ContinuousForm with data is ${snapshot.data}");
                return Column(
                  children: [
                    SizedBox(height: 6),
                    Text("${snapshot.data ?? 0} / $factTotal"),
                    SizedBox(height: 6),
                    LinearProgressIndicator(
                      color: Color.fromARGB(255, 231, 81, 59),
                      backgroundColor: Colors.black38,
                      value: mogaweCalculatePercentage(
                          current: snapshot.data ?? 0, total: factTotal),
                    ),
                  ],
                );
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_up_rounded),
            color: Colors.black,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget blocBuilderDialog() {
    return BlocBuilder(
      bloc: bloc,
      builder: (ctx, state) {
        
        return Container();
      },
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Keluar Dari Gawean'),
            content: new Text(
                'Semua data yang telah kamu isikan akan hilang, yakin untuk keluar dari gawean?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Tidak'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Iya'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _changeSectionTrackerState(ActivityTracker tracker){
    _activityTrackers[tracker.sequence - 1] = tracker;
  }

  void _convertSectionsToTrackers(List<FormModel> sections) {
    int sequence = 1;
    for (var section in sections) {
      ActivityTracker tracker = new ActivityTracker(
          sectionName: section.name,
          uuidSection: section.uuid,
          status: sequence == 1 ? "ready" : "",
          startTime: "",
          sequence: sequence,
          trackerTotal: sections.length);
      _activityTrackers.add(tracker);
      sequence++;
    }
  }
}
