import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:mogawe/core/data/response/form/form_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/form/bloc/form_event.dart';
import 'package:mogawe/modules/form/bloc/form_state.dart';
import 'package:mogawe/modules/form/standart/fact_widget_generator.dart';
import 'package:mogawe/modules/form/tracker/model/activity_tracker.dart';
import 'package:mogawe/modules/form/widget/build_loading_submit_form.dart';
import 'package:mogawe/modules/form/widget/build_submit_tracker_form_button.dart';
import 'package:mogawe/utils/global/common_function.dart';

import 'bloc/form_bloc.dart';
import 'widget/activity_tracker_item.dart';

class FormLoadingScreen extends StatefulWidget {
  final String? idTask;
  final int currentTimeInMillis;
  final bool isPersona;

  const FormLoadingScreen(
      {Key? key, required this.idTask, required this.currentTimeInMillis, required this.isPersona})
      : super(key: key);

  @override
  _FormLoadingScreenState createState() => _FormLoadingScreenState();
}

class _FormLoadingScreenState extends State<FormLoadingScreen> {
  late FormBloc bloc;
  var logger = Logger(printer: PrettyPrinter());
  int _currentIndex = 0;
  List<ActivityTracker> _activityTrackers = [];
  int _totalTracker = 0;
  int _currentTracker = 0;

  @override
  void initState() {
    super.initState();
    bloc = FormBloc();
    if (widget.isPersona){
      bloc.add(StartPesona(widget.idTask));

    }else {
      bloc.add(StartForm(widget.idTask, widget.currentTimeInMillis));

    }
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
        if (state is ShowPesonaForm) {
          print("State : $state");
          return _buildContinuousForm(state.forms);
        }

        if (state is ShowTrackerActivityForm) {
          logger.d("State : $state");
          if (_activityTrackers.length == 0) {
            _convertSectionsToTrackers(state.forms);
          }

          return _buildTrackerForm(state.forms);
        }
        if (state is ShowContinuousForm) {
          logger.d("State : $state");
          return _buildContinuousForm(state.forms);
        }

        if (state is ShowDialogLoadingSubmitFacts){
          return BlocProvider(
              create: (context) => bloc,
              child: BuildLoadingSubmitForm());
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
        child: BlocProvider(
          create: (context) => bloc,
          child: SafeArea(
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: forms.length,
                    itemBuilder: (context, index) {
                      return FormActivityTrackerItem(
                          forms: forms,
                          changeTrackerStatus: (tracker) =>
                              _changeSectionTrackerState(tracker),
                          activityTracker: _activityTrackers[index]);
                    },
                  ),
                ),
                buildSubmitTrackerFormButton(
                    onPressed: () {
                      if (_currentTracker == _activityTrackers.length) {
                        bloc.add(SubmitResult());
                      } else {}
                    },
                    color: _currentTracker == _activityTrackers.length
                        ? FlutterFlowTheme.primaryColor
                        : FlutterFlowTheme.tertiaryColorLighter)
              ],
            ),
          ),
        ),
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
                onPressed: () {
                  bloc.add(ResetCounter());
                  Navigator.of(context).pop(true);
                },
                child: new Text('Iya'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<void> _showUploadingFactsDialog() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Sedang Mengupload'),
        content: new Text('Sedang mengupload jawaban, jangan tutup aplikasi..'),
      ),
    );
  }

  void _changeSectionTrackerState(ActivityTracker tracker) {
    setState(() {
      if (tracker.status == "done") {
        _currentTracker = _currentTracker + 1;
      }
      print("current tracker status is ${tracker.status}");
      print(
          "current tracker counter is $_currentTracker and total is ${_activityTrackers.length}");
      for (var tracker in _activityTrackers) {
        print(
            "current tracker status is ${tracker.uuidSection} and name is ${tracker.sectionName}");
      }

      _activityTrackers[tracker.sequence - 1] = tracker;
    });
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
