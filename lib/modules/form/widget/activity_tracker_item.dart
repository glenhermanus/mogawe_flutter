import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/form/form_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';
import 'package:mogawe/modules/form/tracker/activity_form_screen.dart';
import 'package:mogawe/modules/form/tracker/model/activity_tracker.dart';
import 'package:mogawe/utils/ui/widgets/app_util.dart';

import '../bloc/form_bloc.dart';

class FormActivityTrackerItem extends StatefulWidget {
  const FormActivityTrackerItem({
    required this.forms,
    required this.activityTracker,
    required this.changeTrackerStatus,
    Key? key})
      : super(key: key);
  final List<FormModel> forms;
  final ActivityTracker activityTracker;
  final ChangeTrackerStatus changeTrackerStatus;

  @override
  _FormActivityTrackerItemState createState() =>
      _FormActivityTrackerItemState();
}

class _FormActivityTrackerItemState extends State<FormActivityTrackerItem> {
  @override
  Widget build(BuildContext context) {
    FormBloc bloc = context.read<FormBloc>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            decoration: new BoxDecoration(
              color: _convertStatusToColourCircle(widget.activityTracker.status),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.activityTracker.sectionName),
              Visibility(
                visible: widget.activityTracker.startTime != "",
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                    size: 16,
                    color: Colors.grey,),
                    SizedBox(width: 4),
                    Text(
                      widget.activityTracker.startTime,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          ),
          Spacer(),
          FFButtonWidget(
            text: _convertStatusToText(widget.activityTracker.status),
            onPressed: ()  {
              _handleButtonClick(widget.activityTracker.status, context, bloc);
            },
            options: FFButtonOptions(
              height: 40,
              color: _convertStatusToColourButton(widget.activityTracker.status),
              textStyle: FlutterFlowTheme.subtitle2.override(
                fontFamily: 'Poppins',
                color: widget.activityTracker.status == "started" ? FlutterFlowTheme.blackColor:
                FlutterFlowTheme.secondaryColor,
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
    );
  }

  void _handleButtonClick(
      String status, BuildContext context, FormBloc formBloc) {
    if (status == "started") {
      Navigator.of(context).push(MaterialPageRoute<ActivityFormScreen>(
          builder: (context) => BlocProvider.value(
            value: formBloc,
            child: ActivityFormScreen(
                form: widget.forms[widget.activityTracker.sequence - 1]),
          )));
    } else if (status == "ready") {
      widget.activityTracker.status = "started";
      String startTime = AppUtil.formatDateTime(
          dateFormat: "MMM dd, yyyy - HH:mm", dateTime: DateTime.now());
      widget.activityTracker.startTime = startTime;
      widget.changeTrackerStatus(widget.activityTracker);

      Navigator.of(context).push(MaterialPageRoute<ActivityFormScreen>(
          builder: (context) => BlocProvider.value(
                value: formBloc,
                child: ActivityFormScreen(
                    form: widget.forms[widget.activityTracker.sequence - 1]),
              )));

    } else {

    }
  }

  String _convertStatusToText(status) {
    String text = "Kerjakan";
    if (status == "done") {
      text = "Selesai";
    } else if (status == "started") {
      text = "Mengerjakan";
    } else {
      text = "Kerjakan";
    }
    return text;
  }

  Color _convertStatusToColourCircle(status) {
    Color colour = FlutterFlowTheme.tertiaryDarkerColor;
    if (status == "done") {
      colour = FlutterFlowTheme.moGaweGreen;
    } else if (status == "started") {
      colour = FlutterFlowTheme.moGaweYellow;
    } else {
      colour = FlutterFlowTheme.primaryColor;
    }

    return colour;
  }

  Color _convertStatusToColourButton(status) {
    Color colour = FlutterFlowTheme.tertiaryDarkerColor;
    if (status == "done") {
      colour = FlutterFlowTheme.moGaweGreen;
    } else if (status == "started") {
      colour = FlutterFlowTheme.moGaweYellow;
    } else if (status == "ready") {
      colour = FlutterFlowTheme.primaryColor;
    } else {
      colour = FlutterFlowTheme.tertiaryColor;
    }

    return colour;
  }
}
