import 'package:flutter/material.dart';
import 'package:mogawe/constant/const.dart';
import 'package:mogawe/core/data/response/profile/profile_history_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/utils/ui/widgets/app_util.dart';

class HistoryTab extends StatefulWidget {

  final List<ProfileHistoryData>? histories;
  final Function(String q)? searchListen;
  final Function(int p, String q)? historyPageListen;
  final Function(String f, String q)? filter;

  const HistoryTab({Key? key, this.histories, this.historyPageListen,
  this.filter, this.searchListen}) : super(key: key);

  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {

  TextEditingController? textController1;
  TextEditingController? textController2;
  ScrollController scrollController = ScrollController();
  int page = 0;
  String currValue = Const.historyFilter.first;
  String? filter;
  String? q;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      page = page+1;
      widget.historyPageListen!(page, q ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              16, 16, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: textController1,
                  obscureText: false,
                  onFieldSubmitted: (v) {
                    q = v;
                    if (v.isEmpty) q = null;
                    widget.searchListen!(q ?? "");
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: FlutterFlowTheme.bodyText1
                        .override(
                      fontFamily: 'Poppins',
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor:
                    FlutterFlowTheme.fieldColor,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 16,
                    ),
                  ),
                  style:
                  FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(width: 16),
              DropdownButton(
                items: Const.historyFilter.map((e) {
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e.split(",")[0]),
                  );
                }).toList(),
                value: currValue,
                onChanged: (v) {
                  currValue = v.toString();
                  filter = currValue.split(",")[1];
                  setState(() {});
                  widget.filter!(filter ?? "", q ?? "");
                },
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding:
            EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.histories!.length,
              controller: scrollController,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              physics: AlwaysScrollableScrollPhysics(),
              separatorBuilder: (ctx, _) => SizedBox(height: 8),
              itemBuilder: (ctx, pos) => historyData(
                widget.histories![pos]
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget historyData(ProfileHistoryData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              24, 0, 0, 0),
          child: Text(
            AppUtil.formatDateTime(
              dateFormat: "dd MMMM yyyy",
              dateTime: DateTime.fromMillisecondsSinceEpoch(data.createdDate!)
            ),
            style:
            FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Card(
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
                  '${data.jobName}',
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
                        child: Container(
                          decoration:
                          BoxDecoration(
                            color:
                            data.status! == "rejected"?
                            FlutterFlowTheme.primaryColor: FlutterFlowTheme
                                .moGaweGreen,
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
                              data.status == "rejected"? "Rejected": "Approved",
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
                        ),
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
                            Text(
                              '+${AppUtil.toIDR(data.points!.toDouble())}',
                              style:
                              FlutterFlowTheme
                                  .subtitle1
                                  .override(
                                fontFamily:
                                'Poppins',
                                color: FlutterFlowTheme
                                    .moGaweGreen,
                              ),
                            )
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
                      'Saldo berjalan:',
                      style: FlutterFlowTheme
                          .bodyText1
                          .override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF8B8B8B),
                      ),
                    ),
                    Text(
                      '${AppUtil.toIDR(data.fee!.toDouble())}',
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
      ],
    );
  }
}
