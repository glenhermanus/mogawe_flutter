import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/notification/notification_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class CardNotification extends StatelessWidget {
  final NotificationResponse? notificationResponse;

  CardNotification({this.notificationResponse});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: this.notificationResponse?.object.length,
        itemBuilder: (context, snap) {
          final list = notificationResponse?.object[snap];
          DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(list?.createdDate??'');
        String dateFinal = new DateFormat("MMMM d, HH:mm").format(tempDate);
          return  Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        '${list?.title}',
                        maxLines: 1,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 13
                        ),
                      ),
                    ),
                    Text(
                      '$dateFinal',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF777777),
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Text(
                    '${list?.message}',
                    maxLines: 2,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF7E7E7E),
                      fontSize: 12,
                    ),
                  ),
                ),
                Divider()
              ],
            ),
          );
        });
  }
}
