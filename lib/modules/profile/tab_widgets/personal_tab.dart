import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/core/repositories/profile_repository.dart';
import 'package:mogawe/utils/ui/widgets/app_util.dart';

class PersonalTab extends StatefulWidget {

  final ObjectData? data;
  final Function(Map<String, String> map)? updateProfile;
  final Function(Map<String, dynamic> map)? updateTarget;
  final Function(Map<String, dynamic> map)? updateSelfReminder;
  final TextEditingController? targetCtrl;
  final TextEditingController? namaCtrl;
  final TextEditingController? emailCtrl;
  final TextEditingController? phoneCtrl;
  final String? reminder;
  final String? phone;
  final String? birthday;
  final int? dataReminder;

  const PersonalTab({Key? key, required this.data, this.updateProfile,
    this.updateTarget, this.updateSelfReminder, this.targetCtrl, this.namaCtrl,
    this.emailCtrl, this.phoneCtrl, this.dataReminder, this.phone, this.birthday, this.reminder}) : super(key: key);

  @override
  _PersonalTabState createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {

  String? targetHarian;
  String? nama;
  String? email;
  String? phone;
  String? birthdate;
  String? gender;
  List<String> genders = ["Laki-laki", "Perempuan"];
  bool loading = false;
  Map<String, String> map = Map();
  Map<String, dynamic> revenueMap = Map();
  Map<String, dynamic> reminderMap = Map();
  List selfReminder = [];
  int? statusselect;
  ProfileResponse? profileResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.data == null ? loading = true :loading = false;
    selfReminder.addAll([
     {
       'menit' : 15,
     },
      {
        'menit' : 30,

      },
      {
        'menit' : 60,
      }
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              16, 24, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preferensi',
                style:
                FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Akreditasi',
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Text(
                      ' ',
                      style: FlutterFlowTheme.bodyText1
                          .override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: 24,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: InkWell(
                  onTap: () => showEditDialog(context,
                      title: "Masukkan Target Harian: ",
                    type: TextInputType.number,
                    field: "targetRevenue",
                    value: targetHarian,
                    ctrl: widget.targetCtrl
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Target Harian',
                          style: FlutterFlowTheme.bodyText1
                              .override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Text(
                        widget.data == null? "":
                        " "+AppUtil.toIDR(widget.data!.config!.targetRevenue!),
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: InkWell(
                  onTap: (){
                    print(selfReminder);
                    openAlertBox();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Self Reminder',
                          style: FlutterFlowTheme.bodyText1
                              .override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                       statusselect == null ?  Text(
                        widget.data?.config!.taskReminderDefault != null? widget.data!.config!.taskReminderDefault.toString()!= '60'? '${widget.data!.config!.taskReminderDefault.toString()} Menit sebelum dimulai' : "1 Jam sebelum dimulai" : "",
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ) : Text(
                       selfReminder[statusselect as int]['menit'].toString()!= '60'? '${ selfReminder[statusselect as int]['menit'].toString()} Menit sebelum dimulai' : "1 Jam sebelum dimulai",
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              16, 24, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Info',
                style:
                FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: InkWell(
                  onTap: () => showEditDialog(
                    context,
                    title: "Masukkan Nama Lengkap : ",
                    value: nama,
                    field: "fullName",
                    ctrl: widget.namaCtrl,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Nama',
                          style: FlutterFlowTheme.bodyText1
                              .override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Text(
                        widget.data != null? ' ${widget.data!.fullName}': "",
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: InkWell(
                  // onTap: () => showEditDialog(
                  //   context,
                  //   title: "Masukkan Email :",
                  //   value: email,
                  //   field: "email",
                  //   ctrl: widget.emailCtrl,
                  //   type: TextInputType.emailAddress,
                  // ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Email',
                          style: FlutterFlowTheme.bodyText1
                              .override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Text(
                        widget.data != null? '${widget.data!.email}': "",
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: InkWell(
                  onTap: () => showEditDialog(
                    context,
                    title: "Masukkan No Handphone : ",
                    type: TextInputType.number,
                    value: phone,
                    field: "phone",
                    ctrl: widget.phoneCtrl,
                    onChanged: (v) {
                      phone = v;
                      if (v.isEmpty) phone = null;
                      setState(() {});
                    }
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'No Handphone',
                          style: FlutterFlowTheme.bodyText1
                              .override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                       Text(
                         widget.data?.phone != null? '${widget.data!.phone}': "",
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: InkWell(
                  onTap: () => datePicker(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Tanggal Lahir',
                          style: FlutterFlowTheme.bodyText1
                              .override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                       widget.data?.birthdate != 0 ? Text(
                        widget.data != null ? AppUtil.formatDateTime(
                            dateTime: DateTime.fromMillisecondsSinceEpoch(widget.data!.birthdate!),
                            dateFormat: "yyyy-MM-dd"
                        ) : "" ,
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ) : Text(''),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 16, 0, 0),
                child: InkWell(
                  onTap: () => showEditDialog(
                    context,
                    title: "Pilih Jenis Kelamin : ",
                    isGender: true
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Jenis Kelamin',
                          style: FlutterFlowTheme.bodyText1
                              .override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Text(
                        widget.data != null?
                        widget.data!.gender == "F"? 'Perempuan': 'Laki - laki': "",
                        style: FlutterFlowTheme.bodyText1
                            .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 24,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void showEditDialog(BuildContext ctx,
      {String? title, Function(String v)? onChanged, TextInputType? type,
        String? value, bool isGender = false, String? field, TextEditingController? ctrl}) {
    showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? "", style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              )),
              SizedBox(height: 12),
              isGender? Container(
                height: 72,
                width: 200,
                child: ListView.separated(
                  itemCount: genders.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (ctx, _) => Container(height: 1, color: Colors.black12),
                  itemBuilder: (ctx, pos) => InkWell(
                    onTap: () {
                      gender = genders[pos];
                      map["gender"] = gender == "Laki-laki"? "M": "F";
                      widget.updateProfile!(map);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(genders[pos]),
                    ),
                  ),
                ),
              ): Container(
                height: 32,
                child: TextFormField(
                  onChanged: (v) {
                    value = v;
                    if (v.isEmpty) value = null;
                    setState(() {});
                  },
                  keyboardType: type ?? TextInputType.text,
                  controller: ctrl,
                ),
              )
            ],
          ),
          actions: !isGender? [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("Simpan"),
              onPressed: () {
                if (value != null) {
                  save(value!, field!);
                  Navigator.pop(context);
                }
                else Fluttertoast.showToast(msg: "Harus diisi");
              },
            ),
          ]: [],
        )
    );
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                content: Container(
                  width: 300.0,
                  height: 180,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Pilih Durasi pengingat gawean :", style: FlutterFlowTheme.bodyText1.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: selfReminder.length,
                                    itemBuilder:
                                        (BuildContext context,
                                        int position) {
                                      var nameReminder = selfReminder[position]['menit'];
                                      return InkWell(
                                        onTap: () {
                                          stateSetter(() {

                                            statusselect = position;
                                            save(selfReminder[statusselect as int]['menit'].toString(), "taskReminderDefault");
                                            print(selfReminder[statusselect as int]['menit']);
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 16),
                                          child: ClipRRect(
                                            child: nameReminder !=60 ? Text(
                                              '${nameReminder} Menit',
                                              textAlign:
                                              TextAlign.left,
                                            ):Text(
                                              '1 Jam',
                                              textAlign:
                                              TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }


  void datePicker() async{
    var datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: DateTime(DateTime.now().year-17),
      initialDate: DateTime(DateTime.now().year-17),
    );
    if (datetime != null) {
      map.clear();
      birthdate = AppUtil.formatDateTime(dateFormat: "yyyy-MM-dd",
          dateTime: datetime);
      map["birthdate"] = birthdate!;
      widget.updateProfile!(map);
    } else {
      Fluttertoast.showToast(msg: "No selected date");
    }
  }

  void save(String value, String field) {
    revenueMap.clear();
    reminderMap.clear();
    map.clear();
    if (field == "targetRevenue") {
      revenueMap["targetRevenue"] = int.parse(value);
      widget.updateTarget!(revenueMap);
    }  if (field == "taskReminderDefault") {
      reminderMap["taskReminderDefault"] = int.parse(value);
      widget.updateSelfReminder!(reminderMap);
    } else {
      if (field == "fullName") {
        map["fullName"] = value;
      } if (field == "gender") {
        map["gender"] = gender == "Laki-laki"? "M": "F";
      } if (field == "email") {
        map["email"] = value;
      }
      widget.updateProfile!(map);
    }
  }
}

