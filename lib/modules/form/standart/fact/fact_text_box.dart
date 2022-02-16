import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/data/response/form/result/fact_input.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactTextField extends StatefulWidget {
  const FactTextField({required this.incrementCounterCallback,
    required this.decrementCounterCallback,
    required this.sendChangedFact,
    required this.textInputType,
    required this.fact});


  final NotifyIncrementCounterHandler incrementCounterCallback;
  final NotifyDecrementCounterHandler decrementCounterCallback;
  final SendChangedFact sendChangedFact;
  final TextInputType textInputType;
  final Fact fact;

  @override
  _FactTextFieldState createState() => _FactTextFieldState();
}

class _FactTextFieldState extends State<FactTextField> {
  bool isInputNull = true;
  bool _isAlreadyNotify = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.fact.input ?? "");
    setState(() {
      if(widget.fact.input?.isEmpty ?? true){
        isInputNull = true;
        _isAlreadyNotify = false;
      } else {
        isInputNull = false;
        _isAlreadyNotify = true;
      }
    });
    _controller.addListener(_listenTextFieldValue);
  }

  void _listenTextFieldValue() {
    if (_controller.text.isEmpty) {
      if(_isAlreadyNotify){
        setState(() {
          isInputNull = true;
          _isAlreadyNotify = false;
          widget.decrementCounterCallback();
        });
      }
    } else {
      if (!_isAlreadyNotify) {
        setState(() {
          isInputNull = false;
          _isAlreadyNotify = true;
          widget.incrementCounterCallback();
        });
      }
    }
    widget.fact.input = _controller.text;
    // widget.sendChangedFact(_setFactInput(widget.fact, _controller.text));
    widget.sendChangedFact(widget.fact);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal : 6.0),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: isInputNull
                    ? FlutterFlowTheme.tertiaryColor
                    : FlutterFlowTheme.primaryColor,
              ),
              SizedBox(width: 12),
              Flexible(child: Text(widget.fact.label, maxLines: 3, overflow: TextOverflow.visible,))
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: TextFormField(
            keyboardType: widget.textInputType,
            // onEditingComplete: () => widget.sendChangedFact(widget.fact),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
