import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:mogawe/core/data/response/home_content/gawean_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_util.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/gawean_repository.dart';
import 'package:mogawe/modules/form/form_loading_screen.dart';
import 'package:mogawe/modules/home/gawean/gawean_detail.dart';
import 'package:mogawe/utils/extension/date_ext.dart';
import 'package:mogawe/utils/extension/time_ext.dart';
import 'package:mogawe/utils/services/currency_formatter.dart';
import 'package:mogawe/utils/ui/widgets/MogaweImageHandler.dart';

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
  bool _loadingButtonScheduling = false;

  var logger = Logger(printer: PrettyPrinter());

  // Gawean scheduling time
  String _selectedDate = "";
  late String _gaweanSchedulingTime;

  var token;

  final GaweanRepository _gaweanRepository = GaweanRepository.instance;

  void getToken() async {
    token = await AuthRepository().readSecureData('token');

    print("OUT >> hey");
    print(token);
  }

  @override
  void initState() {
    super.initState();
    if(widget.gaweanModel.reminderDate != null){
      setState(() {
        _selectedDate = _formatReminderDate(widget.gaweanModel.reminderDate!);
      });
    }
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
          padding: EdgeInsetsDirectional.fromSTEB(8, 16, 16, 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: mogaweImageHandler(
                      url: widget.gaweanModel.jobPicture,
                      height: 145,
                      width: 115,
                      fit: BoxFit.cover,
                      isProfile: false)),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              widget.gaweanModel.jobName ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                                DateTime.now().getGaweanTimeLeft(
                                    widget.gaweanModel.endDate ?? 0),
                                style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF8C8C8C),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Spacer(),
                            _buildReminderText(_selectedDate)
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
                                      widget.gaweanModel.locationAddress ??
                                          "",
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormLoadingScreen(idTask: widget.gaweanModel.uuid ?? "", currentTimeInMillis: DateTime.now().millisecondsSinceEpoch, isPersona: false,)
                                ),
                              );
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

  Widget _schedulingTimePicker() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              onDateTimeChanged: (value) {
                String rawSelectedDate =
                    DateFormat("yyyy-MM-dd HH:mm:ss").format(value);
                setState(() {
                  _selectedDate = _formatReminderDate(rawSelectedDate);
                  _gaweanSchedulingTime = rawSelectedDate;
                });

                print(value);
              },
              use24hFormat: true,
              initialDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(
                  widget.gaweanModel.reminderDate ?? DateTime.now().toString()),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: FFButtonWidget(
              text: "Konfirmasi",
              onPressed: () {
                try {
                  _handleUpdateGaweanReminder(token);
                } finally {
                  Navigator.pop(context);
                }
              },
              options: FFButtonOptions(
                width: double.infinity,
                height: 40,
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
              loading: _loadingButtonScheduling,
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
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
        showDialog(
          context: context,
          builder: (ctx) {
            return _schedulingTimePicker();
          },
        );
        break;
      case 3:
        break;
      case 4:
        _showConfirmDialog(data.idTask  ?? "");
        break;
    }
  }

  Widget _buildReminderText(String date) {
    logger.d("Received $date}");
    return Text(
      date,
      style: FlutterFlowTheme.bodyText2.override(
        fontFamily: 'Poppins',
        color: Colors.red,
        fontSize: 12,
      ),
    );
  }

  String _formatReminderDate(String date) {
    final DateFormat formatterWithDate = DateFormat('yyyy-MM-dd');
    final DateFormat formatterWithoutDate = DateFormat('HH:mm');
    String formattedDate = "";

    DateTime parsedDate = DateTime.parse(date);
    DateTime currentDate = DateTime.now();

    if (currentDate.isSameDate(parsedDate)) {
      formattedDate = "Today, ${formatterWithoutDate.format(parsedDate)}";
    } else if (currentDate.isTomorrowDate(parsedDate)) {
      formattedDate = "Tomorrow, ${formatterWithoutDate.format(parsedDate)}";
    } else {
      formattedDate = formatterWithDate.format(parsedDate);
    }

    parsedDate.millisecondsSinceEpoch;

    return formattedDate;
  }

  Future<void> _handleCancelGawean(String idTask) async {
    var response = await _gaweanRepository.cancelGawean(realToken: token, idTask: idTask);
    if (response.returnValue == "000"){

    }
  }

  void _showConfirmDialog(String idTask){
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Cancel Gawean'),
        content: new Text(
            'Yakin untuk cancel gawean? Gawean ini akan hilang dari penugasan kamu'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              _handleCancelGawean(idTask);
              Navigator.of(context).pop(true);
            },
            child: new Text('Iya'),
          ),
        ],
      ),
    );
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
