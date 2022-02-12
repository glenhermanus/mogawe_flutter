import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactSingleSelection extends StatefulWidget {
  const FactSingleSelection({
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
  _FactSingleSelectionState createState() => _FactSingleSelectionState();
}

class _FactSingleSelectionState extends State<FactSingleSelection> {

  int _radioIndex = 100;
  bool _isAlreadyNotify = false;


  @override
  Widget build(BuildContext context) {
    var selection = widget.fact.value.split(","); 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal : 6.0),
          child: Row(
            children: [
              Icon(Icons.check_circle, color:
              _radioIndex == 100 ? FlutterFlowTheme.tertiaryColor:
              FlutterFlowTheme.primaryColor,),
              SizedBox(width: 8),
              Flexible(child: Text(widget.fact.label, maxLines: 3, overflow: TextOverflow.visible,))
            ],
          ),
        ),
        ListView.builder(
          itemCount: selection.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
          var selection = widget.fact.value.split(",");
          var scores = widget.fact.valueScore?.split(",");
          return RadioListTile(
            value: index,
            groupValue: _radioIndex,
            title: Text(selection[index]),
            onChanged: (value) {
              setState(() {
                _radioIndex = index;
              });
              if(widget.fact.valueScore != null){
                String? score = scores?[index];
                widget.fact.finalScore = score;
              }

              if(!_isAlreadyNotify){
                widget.incrementCounterCallback();
                _isAlreadyNotify = true;
              }
              widget.fact.input = selection[index];
              widget.sendChangedFact(widget.fact);
            },
          );
        }),
      ],
    );
  }
}
