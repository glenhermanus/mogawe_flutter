import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mogawe/core/data/response/profile/profile_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/utils/ui/widgets/app_util.dart';
import 'package:qr_flutter/qr_flutter.dart';

class IdCardProfile extends StatefulWidget {

  final ObjectData? data;

  const IdCardProfile({Key? key, this.data}) : super(key: key);

  @override
  _IdCardProfileState createState() => _IdCardProfileState();
}

class _IdCardProfileState extends State<IdCardProfile> {

  String mogawe = "MoGawe (Your Data Your Control";
  String address = "Jl. M Kavling No.8, Kebon Baru, Tebet, Jakarta Timur";
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.data == null ? loading = true :loading = false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ID CARD", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16
        )),
        centerTitle: true,
        backgroundColor: FlutterFlowTheme.primaryColor,
        toolbarHeight: 48,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 24,
                    width: double.infinity,
                    color: Color(0xffBBBDBB),
                    child: Center(
                      child: Text("Data Collector", style: TextStyle(
                       color: Colors.white,
                        fontWeight: FontWeight.w600
                      )),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: widget.data?.profilePicture == null ? Image.asset('assets/images/im_ambar_good_bgwhite.jpg').image : NetworkImage(widget.data?.profilePicture ?? ""),
                      radius: 48,
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(widget.data!.fullName!, style: TextStyle(
                      fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600
                    )),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text("ID:${widget.data!.mogawersCode}", style: TextStyle(
                        fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600
                    )),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 1.5, color: Colors.black),
                        SizedBox(height: 8),
                        rowItem("Tanggal Lahir", Text(
                          AppUtil.formatDateTime(
                            dateTime: DateTime.fromMillisecondsSinceEpoch(widget.data!.birthdate!),
                            dateFormat: "EEE, dd MMMM yyyy"
                          )
                        )),
                        rowItem("Email", Text(widget.data!.email!)),
                        rowItem("Skill", Row(
                          children: [
                            RatingBar(
                              ratingWidget: RatingWidget(
                                full: Icon(Icons.star, size: 12),
                                half: Icon(Icons.star_half, size: 12),
                                empty: Icon(Icons.star_border, size: 12)
                              ),
                              unratedColor: Color(0xff999999),
                              itemCount: 5,
                              itemSize: 12,
                              initialRating: widget.data!.level!.toDouble(),
                              ignoreGestures: true,
                              onRatingUpdate: (v) {

                              },
                            ),
                            SizedBox(width: 8),
                            Text("- Pemula", style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: 12
                            ))
                          ],
                        )),
                       rowItem("Telepon",   Text (loading ? '' : widget.data?.phone ?? '-')),
                        rowItem("Jenis Kelamin", Text(
                          widget.data!.gender == "M"? "Laki-laki": "Perempuan"
                        )),
                        widget.data!.edu! != null ? rowItem("Edukasi", Text( widget.data?.edu ?? '-')) :
                        rowItem("Edukasi", Text( ''))
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: QrImage(
                      data: widget.data!.mogawersCode!,
                      size: 150,
                      version: QrVersions.auto,
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: 12,
                width: double.infinity,
                color: FlutterFlowTheme.primaryColor,
                child: Center(
                  child: Text(
                    "https://mogawe.com/",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset("assets/images/img.png", height: 48),
                SizedBox(width: 16),
                Column(children: [
                  Text(mogawe, style: TextStyle(
                      color: Color(0xff999999),
                      fontWeight: FontWeight.w700,
                    fontSize: 12
                  )),
                  SizedBox(height: 4),
                  Text(address, style: TextStyle(
                      color: Color(0xff999999),
                      fontWeight: FontWeight.w600,
                      fontSize: 10
                  )),
                ])
              ]),
              SizedBox(height: 16)
            ],
          )
        ],
      ),
    );
  }

  Widget rowItem(String title, Widget child) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            child
          ],
        ),
        SizedBox(height: 12)
      ],
    );
  }
}
