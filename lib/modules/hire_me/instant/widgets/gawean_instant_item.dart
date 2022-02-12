import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/hire_me/instant/project.dart';
import 'package:mogawe/core/data/response/hire_me/instant/task_instant.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/hire_me/instant/screens/hire_me_instant_detail_page.dart';

class GaweanInstantItem extends StatefulWidget {
  const GaweanInstantItem({required this.project, Key? key}) : super(key: key);
  final Project project;

  @override
  _GaweanInstantItemState createState() => _GaweanInstantItemState();
}

class _GaweanInstantItemState extends State<GaweanInstantItem> {
  int clickPhase = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional(0, 1),
      children: [
        Align(
          alignment: AlignmentDirectional(0, 0),
          child: Image.network(
            '${widget.project.iconUrl}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 48),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Color(0x00EEEEEE),
            ),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: FlutterFlowTheme.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.project.name}',
                      style: FlutterFlowTheme.subtitle1.override(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Text(
                        '${widget.project.description}',
                        style: FlutterFlowTheme.bodyText2.override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 28),
          child: FFButtonWidget(
            onPressed: () {
              if(clickPhase != 2){
                setState(() {
                  clickPhase = 1;
                });
              }
              Future.delayed(const Duration(milliseconds: 2000), () {
                setState(() {
                  clickPhase = 2;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HireMeInstantDetailPage(
                      taskInstant: _mockGawean(), timerSeconds: 5,
                    ),
                  ),
                );
              });
            },
            text: clickPhase == 0
                ? 'Sign Me Up!'
                : clickPhase == 1
                    ? 'Waiting..'
                    : 'Start',
            options: FFButtonOptions(
              width: 130,
              height: 48,
              color: clickPhase == 0
                  ? FlutterFlowTheme.primaryColor
                  : clickPhase == 1
                      ? FlutterFlowTheme.moGaweYellow
                      : FlutterFlowTheme.moGaweGreen,
              textStyle: FlutterFlowTheme.subtitle2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: 12,
            ),
          ),
        )
      ],
    );
  }

  TaskInstant _mockGawean() {
    TaskInstant task = new TaskInstant(
        id: 799691,
        uuid: "5945de39-40fc-11ec-a9de-755c917b66f3",
        uuidMogawers: null,
        idMogawers: 0,
        uuidQueue: "376343cc-a8a8-4d29-a1af-5a72728f0f2f",
        statusTask: null,
        statusNotes: null,
        groupTask: null,
        sequence: null,
        limit: null,
        isPinned: null,
        isStarting: null,
        startDate: null,
        receivedDate: null,
        expiredDate: null,
        assignmentType: null,
        uuidJob: "5945de39-40fc-11ec-a9de-755c917b66f3",
        jobName: "RAJA SUSU KAMAL",
        jobDescription: null,
        uuidJobType: "e6d88855-76e3-4139-98aa-b98c1a1fd010",
        uuidLocationType: "2d144ea3-4322-11e9-b2bb-42010a940029",
        uuidLocation: "f3214387-4ec7-49ab-90b6-d10c43c8d999",
        uuidLocationLevel: null,
        uuidProject: "c82e8cda-880e-4013-b55f-c54e03f7dc87",
        projectName: null,
        projectDescription: null,
        uuidBatch: null,
        batchName: null,
        latitude: "-6.132553",
        longitude: "106.729324",
        name: "RAJA SUSU KAMAL",
        locationName: "RAJA SUSU KAMAL",
        locationAddress:
            "Jl. Kamal Raya No.26 RT.1/RW.8 Cengkareng Bar. Kecamatan Cengkareng Kota Jakarta Barat Daerah Khusus Ibukota Jakarta 11730 Indonesia Kecamatan Cengkareng 11730",
        locationLevel: "7",
        jobTypeName: "Observation",
        tutorial: "https://www.youtube.com/watch?v=G1IbRujko-A",
        code: null,
        description: "Survey minimarket",
        brief: null,
        howTo: null,
        minimumLevel: 1,
        jobLimit: null,
        fee: 0,
        type: null,
        isScreening: null,
        isDirect: false,
        target: 1,
        points: 0,
        duration: "0",
        schedule: null,
        isPublished: false,
        isAutoApproved: false,
        locationDescription: "",
        isQcNeeded: true,
        isHaveArea: null,
        jobPicture: null,
        jobBanner: null,
        jobColor: null,
        jobTextColor: null,
        radius: 100,
        defaulLimit: null,
        postMessage: null,
        resultCount: null,
        mogawersCode: null,
        fullName: null,
        email: null,
        jobId: "799691",
        category: null,
        isDisplayable: false,
        isAssigned: false,
        jobActions: null,
        certificates: null,
        jobTimes: null,
        endDate: null,
        uuidOrder: null,
        uuidTaskOrder: null,
        uuidTaskOrderJob: null,
        idTask: "5945de39-40fc-11ec-a9de-755c917b66f3");

    return task;
  }
}
