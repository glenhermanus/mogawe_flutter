import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class CardReceived extends StatelessWidget {
  dynamic? pesan;
  UserProfileResponse? userProfileResponse;
  CardReceived({this.pesan, this.userProfileResponse});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: this.pesan?.results.comments.length,
      itemBuilder: (context, snapshot){
        int reverse = this.pesan?.results.comments.length - 1 -snapshot;
        final list = this.pesan?.results.comments[reverse];
        print(list?.user.userId);
        print(this.userProfileResponse?.email);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            list?.user.userId != this.userProfileResponse?.email ?  Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 12, 0, 0),
            child: Text(
              'Admin MoGawe',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
              ),
            ),
          ) : Container(),
            Row(
              mainAxisAlignment: list?.user.userId == this.userProfileResponse?.email ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                list?.user.userId == this.userProfileResponse?.email ? Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: Text(
                    '12:45',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                    ),
                  ),
                ) : Container(),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: list?.user.userId == this.userProfileResponse?.email? Color(0xFFFFE0E0) : FlutterFlowTheme.secondaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        16, 8, 16, 8),
                    child: Text(
                      '${list?.message}',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                list?.user.userId != this.userProfileResponse?.email ? Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: Text(
                    '12:45',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                    ),
                  ),
                ) : Container(),
              ],
            ),

          ],
        );
      },

    );
  }
}
