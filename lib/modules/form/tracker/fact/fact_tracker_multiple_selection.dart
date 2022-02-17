import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactTrackerMultipleSelection extends StatefulWidget {
  const FactTrackerMultipleSelection(
      {required this.incrementCounterCallback,
      required this.decrementCounterCallback,
      required this.fact,
      required this.sendChangedFact});

  final Fact fact;
  final NotifyIncrementCounterHandler incrementCounterCallback;
  final NotifyDecrementCounterHandler decrementCounterCallback;
  final SendChangedFact sendChangedFact;

  @override
  _FactTrackerMultipleSelectionState createState() => _FactTrackerMultipleSelectionState();
}

class _FactTrackerMultipleSelectionState extends State<FactTrackerMultipleSelection> {
  List _selected = [];
  bool _isAlreadyNotify = false;

  @override
  Widget build(BuildContext context) {
    var selection = widget.fact.value.split(",");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: _selected.isEmpty
                    ? FlutterFlowTheme.tertiaryColor
                    : FlutterFlowTheme.primaryColor,
              ),
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
            return ListTile(
              title: Text(selection[index]),
              leading: Checkbox(
                value: _selected.contains(selection[index]),
                onChanged: (selected) {
                  _onCategorySelected(selected!, selection[index]);
                  print(_selected);
                  if (_selected.isEmpty) {
                    widget.decrementCounterCallback();
                    _isAlreadyNotify = false;
                  } else {
                    if (!_isAlreadyNotify) {
                      widget.incrementCounterCallback();
                      _isAlreadyNotify = true;
                    }
                  }

                  _sendValueToFormBloc();
                },
              ),
            );
          },
        )
      ],
    );
  }

  void _sendValueToFormBloc(){
    String value = "";
    for (var selectedValue in _selected){
      value += "$selectedValue,";
    }
    widget.fact.input = value.substring(0, value.length - 1);
    widget.sendChangedFact(widget.fact);
  }

  void _onCategorySelected(bool selected, String value) {
    if (selected == true) {
      setState(() {
        _selected.add(value);
      });
    } else {
      setState(() {
        _selected.remove(value);
      });
    }
  }
}
