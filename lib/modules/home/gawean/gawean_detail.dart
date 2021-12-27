import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mogawe/core/data/response/home_content/gawean_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class GaweanDetailScreen extends StatefulWidget {
  const GaweanDetailScreen({required this.gaweanModel});

  final Gawean gaweanModel;

  @override
  _GaweanDetailScreenState createState() => _GaweanDetailScreenState();
}

class _GaweanDetailScreenState extends State<GaweanDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Informasi Gawean',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.share,
              color: FlutterFlowTheme.primaryColor,
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _buildContent();
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.network(
              widget.gaweanModel.jobPicture,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.gaweanModel.jobName}",
                  style: FlutterFlowTheme.title1.copyWith(fontFamily: "Roboto"),
                ),
                SizedBox(height: 24),
                _detailGaweanSection(),
                SizedBox(height: 24),
                _deskripsiGaweanSection(),
                SizedBox(height: 24),
                _mapSection()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailGaweanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DETAIL GAWEAN",
          style: FlutterFlowTheme.subtitle1,
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
              color: FlutterFlowTheme.fieldColor,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icon/ic_time_grey.svg",
                      height: 32,
                    ),
                    SizedBox(width: 12),
                    Text(
                      widget.gaweanModel.reminderDate.toString() == "null"
                          ? "--"
                          : widget.gaweanModel.reminderDate
                          .toString()
                          .split(" ")
                          .first,
                      style: FlutterFlowTheme.subtitle3
                          .copyWith(color: Colors.black, fontFamily: 'Roboto'),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icon/ic_money_grey.svg",
                      height: 32,
                    ),
                    SizedBox(width: 12),
                    Text(
                      widget.gaweanModel.fee.toString() == "null"
                          ? "--"
                          : "Rp ${widget.gaweanModel.fee}",
                      style: FlutterFlowTheme.subtitle3
                          .copyWith(color: Colors.black, fontFamily: 'Roboto'),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icon/ic_location_circle_grey.svg",
                      height: 32,
                    ),
                    SizedBox(width: 12),
                    Text(
                      "${widget.gaweanModel.locationName} - ${widget.gaweanModel.locationAddress}",
                      style: FlutterFlowTheme.subtitle3
                          .copyWith(color: Colors.black, fontFamily: 'Roboto'),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _deskripsiGaweanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DESKRIPSI",
          style: FlutterFlowTheme.subtitle1,
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: FlutterFlowTheme.fieldColor,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.gaweanModel.jobDescription ??
                      "Deksripsi tidak tersedia",
                  style: FlutterFlowTheme.subtitle3.copyWith(
                      color: FlutterFlowTheme.tertiaryColor,
                      fontFamily: 'Roboto'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition gaweanLocation(double lat, double lng) {
    return CameraPosition(
        target: LatLng(37.43296265331129, -122.08832357078792));
  }

  Widget _mapSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "MAP",
          style: FlutterFlowTheme.subtitle1,
        ),
        SizedBox(
          height: 12,
        ),
        Stack(
          children: [
            Container(
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(16)),
              height: 300,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                mapType: MapType.normal,
                initialCameraPosition: gaweanLocation(
                  double.parse("${widget.gaweanModel.latitude}"),
                  double.parse("${widget.gaweanModel.longitude}"),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: FlutterFlowTheme.primaryColor
                    ),
                    child: SvgPicture.asset(
                        "assets/icon/ic_location_red.svg",
                        height: 24,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(width: 16,),
                  Text(
                    "${widget.gaweanModel.locationName} - ${widget.gaweanModel.locationAddress}",
                    style: FlutterFlowTheme.subtitle3
                        .copyWith(color: Colors.black, fontFamily: 'Roboto'),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
