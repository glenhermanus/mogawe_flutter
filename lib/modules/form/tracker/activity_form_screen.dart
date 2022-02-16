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
      body: WillPopScope(
        onWillPop: () => _onWillPop(bloc),
        child: Column(
          children: [
            _buildFormCounter(widget.form.facts.length, 50, bloc),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: FormActivityTrackerFactGenerator(
                facts: widget.form.facts,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCounter(int factTotal, double footerHeight, FormBloc bloc) {
    return Container(
      height: footerHeight,
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

  Future<bool> _onWillPop(FormBloc bloc) async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Keluar Dari Section ini?'),
            content: new Text(
                'Kamu akan kembali ke halaman tracker, yakin untuk keluar?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Tidak'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);

                },
                child: new Text('Iya'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
