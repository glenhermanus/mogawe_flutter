import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactTrackerRating extends StatefulWidget {
  final Fact fact;
  final NotifyIncrementCounterHandler incrementCounterCallback;
  final SendChangedFact sendChangedFact;

  const FactTrackerRating({
    required this.incrementCounterCallback,
    required this.fact,
    required this.sendChangedFact,
  });

  @override
  State<FactTrackerRating> createState() => _FactTrackerRatingState();
}

class _FactTrackerRatingState extends State<FactTrackerRating> {

  bool _isAlreadyNotify = false;
  int starCount = 5;
  double rating = 0;

  @override
  void initState() {
    super.initState();
    if(widget.fact.input != ""){
      rating = double.parse(widget.fact.input!);
      _isAlreadyNotify = true;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: rating == 0 ? FlutterFlowTheme.tertiaryColor : FlutterFlowTheme.primaryColor,
                  ),
                  SizedBox(width: 8),
                  Text(widget.fact.factName),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: new List.generate(
                starCount,
                (index) => buildStar(context, index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star,
        color: Colors.grey,
        size: 48,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: FlutterFlowTheme.primaryColor,
        size: 48,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: FlutterFlowTheme.primaryColor,
        size: 48,
      );
    }
    return new InkResponse(
      onTap: (){
        setState(() {
          rating = index + 1;
        });
        if (!_isAlreadyNotify) {
          widget.incrementCounterCallback();
          _isAlreadyNotify = true;
        }
        widget.fact.input = rating.toString();
        widget.sendChangedFact(widget.fact);
      },
      child: icon,
    );
  }
}
