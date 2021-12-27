import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/home_content/gawean_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_util.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/gawean_repository.dart';
import 'package:mogawe/modules/home/gawean/gawean_detail.dart';
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

  // Gawean scheduling time
  String _selectedDate = DateTime.now().toString();
  String _selectedTime = TimeOfDay.now().toString();
  late String _gaweanSchedulingTime;

  var token;

  final GaweanRepository _gaweanRepository = GaweanRepository.instance;

  void getToken() async {
    token = await AuthRepository().getToken();

    print("OUT >> hey");
    print(token);
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

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
                  widget.gaweanModel.jobPicture,
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
                          _gaweanActionMenu(),
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
                              child: Text(
                                stringtoRupiah(
                                    (widget.gaweanModel.fee ?? 0.0).toInt()),
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
                                      widget.gaweanModel.locationAddress ?? "",
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

  Widget _gaweanActionMenu() {
    return PopupMenuButton<int>(
      child: FaIcon(
        FontAwesomeIcons.ellipsisV,
        color: Colors.black,
        size: 16,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("Info Gawean"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Scheduling"),
        ),
        PopupMenuItem(
          value: 3,
          child: Text("Bagikan Gawean"),
        ),
        PopupMenuItem(
          value: 4,
          child: Text("Cancel Gawean"),
        ),
      ],
      onSelected: (value) => selectedMenuItem(value, widget.gaweanModel),
    );
  }

  void datePicker() async {
    var datetime = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2023),
        initialDate: DateTime.now());
    if (datetime != null) {
      setState(() {
        _selectedDate = DateFormat("yyyy-MM-dd").format(datetime);
      });
      timePicker();
    }
  }

  void timePicker() async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, childWidget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: childWidget!,
        );
      },
    );
    setState(() {
      _selectedTime = "${time?.hour}:${time?.minute}:00";
      _gaweanSchedulingTime = "$_selectedDate $_selectedTime";
      _handleUpdateGaweanReminder(token);
    });
  }

  void selectedMenuItem(int value, Gawean data) async {
    switch (value) {
      case 1:
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GaweanDetailScreen(
              gaweanModel: data,
            ),
          ),
        );
        break;
      case 2:
        datePicker();
    }
  }

  Future<void> _handleUpdateGaweanReminder(String token) async {
    var body = {
      "uuid": widget.gaweanModel.uuid,
      "reminderDate": _gaweanSchedulingTime
    };
    print(body);
    try {
      var response = await _gaweanRepository.updateGaweanReminder(
        token,
        body,
      );
      if (response.returnValue == "000") {
        showSnackbar(context, response.message.toString());
        print(response);
        setState(() {
          widget.gaweanModel.reminderDate = _gaweanSchedulingTime;
        });
      } else if (response.returnValue == "001") {
        showSnackbar(context, response.message.toString());
        print(response);
      }
    } catch (ex) {
      print("$ex");
    }
  }
}
