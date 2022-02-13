import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactDate extends StatefulWidget {
  const FactDate(
      {required this.fact,
      required this.incrementCounterCallback,
      required this.sendChangedFact});

  final Fact fact;
  final NotifyIncrementCounterHandler incrementCounterCallback;
  final SendChangedFact sendChangedFact;

  @override
  _FactDateState createState() => _FactDateState();
}

class _FactDateState extends State<FactDate> {
  String _date = "";
  DateTime selectedDate = DateTime.now();

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
                color: _date == ""
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
                text: "Pilih Tanggal",
                icon: Icon(Icons.date_range_outlined),
                onPressed: () async {
                  print(widget.fact.hintName);
                  final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    setState(() {
                      print(pickedDate.day);
                      selectedDate = pickedDate;
                      _date = dateFormatter(pickedDate);
                    });
                    widget.incrementCounterCallback();

                    widget.fact.input = _date;
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
          Text(_date)
        ],
      ),
    );
  }

  String dateFormatter(DateTime date) {
    final formatter = new DateFormat('dd MMMM yyyy');
    return formatter.format(date);
  }

}
