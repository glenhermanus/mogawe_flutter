import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/hire_me/instant/project.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/hire_me/instant/widgets/gawean_instant_item.dart';

class HireMeInstantPage extends StatefulWidget {
  HireMeInstantPage({Key? key}) : super(key: key);

  @override
  _HireMeInstantPageState createState() => _HireMeInstantPageState();
}

class _HireMeInstantPageState extends State<HireMeInstantPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Project> list = [];

  @override
  void initState() {
    super.initState();
    _mockProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Gawean Instan',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: SafeArea(
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return GaweanInstantItem(project: list[index]);
          },
        ),
      ),
    );
  }

  List<Project> _mockProjects() {
    Project project = new Project(
        uuid: "c82e8cda-880e-4013-b55f-c54e03f7dc87",
        name: "Komando KW Super",
        description: "Survey supermarket",
        targetParticipants: 100,
        uuidQuestionnaire: null,
        startDate: DateTime.parse("2021-12-01 00:00:00"),
        endDate: DateTime.parse("2022-02-28 00:00:00"),
        iconUrl:
            "https://ddtc-cdn1.sgp1.digitaloceanspaces.com/view/200121045329WhatsAppImage2020-01-21at4.50.48PM.jpeg",
        certificates: []);

    list.add(project);

    return list;
  }

}
