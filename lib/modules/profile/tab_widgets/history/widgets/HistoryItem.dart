import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/profile/profile_history_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/utils/ui/widgets/app_util.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    required this.historyData,
    Key? key}) : super(key: key);
  final ProfileHistoryData historyData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior:
        Clip.antiAliasWithSaveLayer,
        color: Color(0xFFF5F5F5),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(16),
        ),
        child: Padding(
          padding:
          EdgeInsetsDirectional.fromSTEB(
              16, 16, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                '${historyData.jobName}',
                style: FlutterFlowTheme
                    .subtitle2
                    .override(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional
                    .fromSTEB(0, 8, 0, 0),
                child: Row(
                  mainAxisSize:
                  MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                      EdgeInsetsDirectional
                          .fromSTEB(
                          0, 0, 8, 0),
                      child: _buildCategoryHistoryStatus(historyData.status ?? ""),
                    ),
                    Padding(
                      padding:
                      EdgeInsetsDirectional
                          .fromSTEB(
                          0, 0, 8, 0),
                      child: Container(
                        decoration:
                        BoxDecoration(
                          color:
                          Color(0xFFC0C0C0),
                          borderRadius:
                          BorderRadius
                              .circular(4),
                        ),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional
                              .fromSTEB(8,
                              2, 8, 2),
                          child: Text(
                            'Incentive',
                            style:
                            FlutterFlowTheme
                                .bodyText2
                                .override(
                              fontFamily:
                              'Poppins',
                              color: FlutterFlowTheme
                                  .tertiaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize:
                        MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment
                            .end,
                        children: [
                          _buildTextTotal(historyData.status ?? "")
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 16,
                thickness: 1,
                color: Color(0xFFE7E7E7),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  Text(
                    AppUtil.formatDateTime(
                        dateFormat: "MMM dd, yyyy - HH:mm",
                        dateTime: DateTime.fromMillisecondsSinceEpoch(historyData.createdDate!)
                    ),
                    style:
                    FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    'Saldo berjalan: ${AppUtil.toIDR(historyData.fee?.toDouble() ?? 0.0)}',
                    style: FlutterFlowTheme
                        .bodyText1
                        .override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF8B8B8B),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryHistoryStatus(String status){
    return Container(
      decoration:
      BoxDecoration(
        color: _categoryHistoryColor(status),
        borderRadius:
        BorderRadius
            .circular(4),
      ),
      child: Padding(
        padding:
        EdgeInsetsDirectional
            .fromSTEB(8,
            2, 8, 2),
        child: Text(status,
          style:
          FlutterFlowTheme
              .bodyText2
              .override(
            fontFamily:
            'Poppins',
            color: FlutterFlowTheme
                .secondaryColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTextTotal(String status){
    String symbol = '';
    if(status == "transfer in" || status == "credit"){
      symbol = '+';
    } else if (status == "transfer out"){
      symbol = '-';
    } else {
      symbol = '';
    }
    String text = '$symbol${AppUtil.toIDR(historyData.total ?? 0.0)}';

   return Text(
      text,
      style:
      FlutterFlowTheme
          .subtitle1
          .override(
        fontFamily:
        'Poppins',
        color: _categoryHistoryColor(status),
      ),
    );
  }

  Color _categoryHistoryColor(String statusHistory){
    Color colour = FlutterFlowTheme.tertiaryDarkerColor;
    String status = statusHistory.toLowerCase();
    if(status == "transfer in" || status == "approved"){
      colour = FlutterFlowTheme.moGaweGreen;
    } else if (status == "completed" || status == "received"){
      colour = FlutterFlowTheme.moGaweYellow;
    } else if (status == "transfer out"){
      colour = FlutterFlowTheme.primaryColor;
    } else if (status == "rejected" || status == "canceled"){
      colour = FlutterFlowTheme.tertiaryColor;
    } else {
      colour = FlutterFlowTheme.tertiaryBlackColor;
    }

    return colour;
  }
}
