import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/form/form_model.dart';
import 'package:mogawe/modules/form/bloc/form_bloc.dart';
import 'package:mogawe/modules/form/tracker/form_tracker_fact_generator.dart';
import 'package:mogawe/utils/global/common_function.dart';

class ActivityFormScreen extends StatefulWidget {
  const ActivityFormScreen({required this.form, Key? key}) : super(key: key);
  final FormModel form;

  @override
  _ActivityFormScreenState createState() => _ActivityFormScreenState();
}

class _ActivityFormScreenState extends State<ActivityFormScreen> {

  @override
  Widget build(BuildContext context) {
    FormBloc bloc = context.read<FormBloc>();
    AppBar appBar = AppBar(
      title: Text(widget.form.name),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Expanded(
            child: FormActivityTrackerFactGenerator(
              facts: widget.form.facts,
            ),
          ),
          _buildFormCounter(widget.form.facts.length, 50, bloc),
        ],
      ),
    );
  }

  Widget _buildFormCounter(int factTotal, double footerHeight, FormBloc bloc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      height: footerHeight,
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54, blurRadius: 10.0, offset: Offset(0.0, 1.2))
      ], color: Colors.white),
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
