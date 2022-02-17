import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactTrackerSlider extends StatefulWidget {
  const FactTrackerSlider(
      {required this.incrementCounterCallback,
      required this.decrementCounterCallback,
      required this.fact});

  final Fact fact;
  final NotifyIncrementCounterHandler incrementCounterCallback;
  final NotifyDecrementCounterHandler decrementCounterCallback;

  @override
  _FactTrackerSliderState createState() => _FactTrackerSliderState();
}

class _FactTrackerSliderState extends State<FactTrackerSlider> {
  late double _value;
  bool _isAlreadyNotify = false;

  @override
  void initState() {
    super.initState();
    _value = widget.fact.minValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 16, 6, 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: _value == widget.fact.minValue.toDouble()
                        ? FlutterFlowTheme.tertiaryColor
                        : FlutterFlowTheme.primaryColor,
                  ),
                  SizedBox(width: 8),
                  Text(widget.fact.factName),
                ],
              ),
            ],
          ),
          Center(child: Text("${_value.toInt()} / ${widget.fact.maxValue}")),
          Slider(
            min: widget.fact.minValue.toDouble(),
            max: widget.fact.maxValue.toDouble(),
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });

              if(_value == widget.fact.minValue.toDouble){
                widget.decrementCounterCallback();
                _isAlreadyNotify = false;
              } else {
                if(!_isAlreadyNotify){
                  widget.incrementCounterCallback();
                  _isAlreadyNotify = true;
                }
              }
            },
          )
        ],
      ),
    );
  }
}
