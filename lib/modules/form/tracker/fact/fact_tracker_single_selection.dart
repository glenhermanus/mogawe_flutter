import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactTrackerSingleSelection extends StatefulWidget {
  const FactTrackerSingleSelection({
    required this.fact,
    required this.incrementCounterCallback,
    required this.decrementCounterCallback,
    required this.sendChangedFact
  });

  final Fact fact;
  final NotifyIncrementCounterHandler incrementCounterCallback;
  final NotifyDecrementCounterHandler decrementCounterCallback;
  final SendChangedFact sendChangedFact;


  @override
  _FactTrackerSingleSelectionState createState() => _FactTrackerSingleSelectionState();
}

class _FactTrackerSingleSelectionState extends State<FactTrackerSingleSelection> {

  int _radioIndex = -1;
  bool _isAlreadyNotify = false;
  List<String> _selection = [];
  List<String> _scores = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selection = widget.fact.value.split(",");
      _scores = widget.fact.valueScore?.split(",") ?? [];
      print("received Fact input is ${widget.fact.input}");

      _radioIndex = _selection.indexWhere((element) => (widget.fact.input ?? "") == element);
      print("radioIndex is $_radioIndex");
      if(_radioIndex != -1){
        _isAlreadyNotify = true;
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    var _selection = widget.fact.value.split(",");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal : 6.0),
          child: Row(
            children: [
              Icon(Icons.check_circle, color:
              _radioIndex == -1 ? FlutterFlowTheme.tertiaryColor:
              FlutterFlowTheme.primaryColor,),
              SizedBox(width: 8),
              Flexible(child: Text(widget.fact.label, maxLines: 3, overflow: TextOverflow.visible,))
            ],
          ),
        ),
        ListView.builder(
          itemCount: _selection.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {

          return RadioListTile(
            value: index,
            groupValue: _radioIndex,
            title: Text(_selection[index]),
            onChanged: (value) {
              setState(() {
                _radioIndex = index;
              });
              widget.fact.input = _selection[index];
              print("sent Fact input is ${_selection[index]}");
              widget.sendChangedFact(widget.fact);

              if(!_isAlreadyNotify){
                widget.incrementCounterCallback();
                _isAlreadyNotify = true;
              }

              if(widget.fact.valueScore != null){
                String? score = _scores[index];
                widget.fact.finalScore = score;
              }

            },
          );
        }),
      ],
    );
  }
}
