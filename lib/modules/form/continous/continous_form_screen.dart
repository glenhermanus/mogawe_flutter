import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/form/form_model.dart';
import 'package:mogawe/modules/form/continous/bloc/continous_form_bloc.dart';
import 'package:mogawe/modules/form/continous/bloc/continous_form_event.dart';
import 'package:mogawe/modules/form/continous/widget/continuous_fact_list_builder.dart';
import 'package:mogawe/utils/global/common_function.dart';

import 'bloc/continous_form_state.dart';

class ContinuousFormScreen extends StatefulWidget {
  final FormModel form;

  const ContinuousFormScreen({Key? key, required this.form}) : super(key: key);

  @override
  _ContinuousFormScreenState createState() => _ContinuousFormScreenState();
}

class _ContinuousFormScreenState extends State<ContinuousFormScreen> {
  late ContinuousFormBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ContinuousFormBloc();
    bloc.add(ShowContinuousFormEvent(widget.form));
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
        if (state is ShowContinuousFormState) {
          print("State : $state");
          return _buildFormBody(state.form);
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(blocBuilder());
  }

  Widget _buildFormBody(FormModel form) {
    AppBar appBar = AppBar(
      title: Text(form.name),
    );
    return Scaffold(
      appBar: appBar,
      body: BlocProvider(
        create: (context) => bloc,
        child: Column(
          children: [
            Expanded(
              child: BuildContinuousFactListBuilder(facts: form.facts),
            ),
            _buildFormFooter(form.facts.length, appBar.preferredSize.height)
          ],
        ),
      ),
    );
  }

  Widget _buildFormFooter(int factTotal, double footerHeight) {
    return Container(
      height: footerHeight,
      child: Row(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: bloc.currentProgress,
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                print("ContinuousForm with data is ${snapshot.data}");
                return Column(
                  children: [
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
          ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.keyboard_arrow_up_rounded),
              label: Text("Up")),
          ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.keyboard_arrow_down_rounded),
              label: Text("Down"))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    bloc.close();
  }
}
