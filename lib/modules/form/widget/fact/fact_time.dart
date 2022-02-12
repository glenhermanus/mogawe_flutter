import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactTime extends StatefulWidget {
  const FactTime(
      {required this.fact,
      required this.incrementCounterCallback,
      required this.sendChangedFact});

  final Fact fact;
  final NotifyIncrementCounterHandler incrementCounterCallback;
  final SendChangedFact sendChangedFact;

  @override
  _FactTimeState createState() => _FactTimeState();
}

class _FactTimeState extends State<FactTime> {

  String _time = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 16, 6, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle,
                color: _time == ""
                    ? FlutterFlowTheme.tertiaryColor
                    : FlutterFlowTheme.primaryColor,
              ),
              SizedBox(width: 8),
              Flexible(
                  child: Text(
                widget.fact.label,
                maxLines: 3,
                overflow: TextOverflow.visible,
              )),
              Spacer(),
              FFButtonWidget(
                text: "Pilih Waktu",
                icon: Icon(Icons.access_time),
                onPressed: () async {
                  print(widget.fact.hintName);
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    initialEntryMode: TimePickerEntryMode.dial,
                    builder: (context, childWidget) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: childWidget!,
                      );
                    },
                  );
                  if (pickedTime != null){
                    setState(() {
                      _time = timeFormatter(pickedTime);
                    });
                    widget.incrementCounterCallback();

                    widget.fact.input = _time;
                    widget.sendChangedFact(widget.fact);
                  }
                },
                options: FFButtonOptions(
                  height: 40,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.secondaryColor,
                    fontSize: 14,
                  ),
                  elevation: 0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12,
                ),
              ),
            ],
          ),
          Text(widget.fact.hintName),
          SizedBox(height: 8),
          Text(_time)
        ],
      ),
    );
  }

  String timeFormatter(TimeOfDay time) {
    return "${time.hour} : ${time.minute}";
  }

}
