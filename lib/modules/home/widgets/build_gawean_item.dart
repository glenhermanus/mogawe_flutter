import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mogawe/core/data/response/home_content/gawean_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/utils/services/currency_formatter.dart';

class BuildGaweanItem extends StatefulWidget {
  const BuildGaweanItem({
    required this.gaweanModel,
    Key? key,
  }) : super(key: key);

  final Gawean gaweanModel;

  @override
  State<BuildGaweanItem> createState() => _BuildGaweanItemState();
}

class _BuildGaweanItemState extends State<BuildGaweanItem> {
  bool _loadingButtonMulai = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: FlutterFlowTheme.secondaryColor,
        elevation: 2,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://picsum.photos/seed/879/600',
                  width: 92,
                  height: 114,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.gaweanModel.jobName ?? "",
                              style: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.ellipsisV,
                            color: Colors.black,
                            size: 16,
                          ),
                          // _gaweanActionMenu(),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.calendarAlt,
                              color: Colors.black,
                              size: 12,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                              child: Text(
                                'Expired in 3 days',
                                style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF8C8C8C),
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.money,
                              color: Colors.black,
                              size: 12,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                              child: Text( stringtoRupiah((widget.gaweanModel.fee ?? 0.0).toInt()),
                                style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF8C8C8C),
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                    size: 12,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 0),
                                    child: Text(
                                      'Cilandak ...',
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF8C8C8C),
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Mulai',
                            options: FFButtonOptions(
                              width: 80,
                              height: 32,
                              color: FlutterFlowTheme.secondaryColor,
                              textStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.primaryColor,
                                fontSize: 12,
                              ),
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.primaryColor,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                            loading: _loadingButtonMulai,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _gaweanActionMenu() {
  //   return PopupMenuButton<int>(
  //     child: FaIcon(
  //       FontAwesomeIcons.ellipsisV,
  //       color: Colors.black,
  //       size: 16,
  //     ),
  //     itemBuilder: (context) => [
  //       PopupMenuItem(
  //         value: 1,
  //         child: Text("Info Gawean"),
  //       ),
  //       PopupMenuItem(
  //         value: 2,
  //         child: Text("Scheduling"),
  //       ),
  //       PopupMenuItem(
  //         value: 3,
  //         child: Text("Bagikan Gawean"),
  //       ),
  //       PopupMenuItem(
  //         value: 4,
  //         child: Text("Cancel Gawean"),
  //       ),
  //     ],
  //     onSelected: (value) => selectedMenuItem(value),
  //   );
  // }

  // void selectedMenuItem(int value) async {
  //   switch (value) {
  //     case 1:
  //       await Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => GaweanDetailScreen(),
  //         ),
  //       );
  //       break;
  //   }
  // }
}
