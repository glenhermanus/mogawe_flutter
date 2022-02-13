import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactPhoneNumber extends StatefulWidget {
  const FactPhoneNumber(
      {required this.textInputType, required this.fact,
        required this.incrementCounterCallback,
        required this.decrementCounterCallback,
        required this.sendChangedFact
      });

  final TextInputType textInputType;
  final Fact fact;
  final NotifyIncrementCounterHandler incrementCounterCallback;
  final NotifyDecrementCounterHandler decrementCounterCallback;
  final SendChangedFact sendChangedFact;


  @override
  _FactPhoneNumberState createState() => _FactPhoneNumberState();
}

class _FactPhoneNumberState extends State<FactPhoneNumber> {

  bool isInputNull = true;
  bool isAlreadyNotify = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_listenTextFieldValue);
  }

  void _listenTextFieldValue() {
    if (_controller.text.isEmpty) {
      if(isAlreadyNotify){
        setState(() {
          isInputNull = true;
          isAlreadyNotify = false;
          widget.decrementCounterCallback();
        });
      }
    } else {
      if (!isAlreadyNotify) {
        setState(() {
          isInputNull = false;
          isAlreadyNotify = true;
          widget.incrementCounterCallback();
        });
      }
    }

    widget.fact.input = _controller.text;
    widget.sendChangedFact(widget.fact);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: isInputNull
                    ? FlutterFlowTheme.tertiaryColor
                    : FlutterFlowTheme.primaryColor,
              ),
              SizedBox(width: 8),
              Text(widget.fact.factName),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text("+62"),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: TextFormField(
                      controller: _controller,
                      // onEditingComplete: () {
                      //   widget.fact.input = _controller.text;
                      //   widget.sendChangedFact(widget.fact);
                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      keyboardType: widget.textInputType,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
