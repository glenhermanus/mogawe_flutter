import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';

class AcreditationPage extends StatefulWidget {
  const AcreditationPage({Key? key}) : super(key: key);

  @override
  _AcreditationPageState createState() => _AcreditationPageState();
}

class _AcreditationPageState extends State<AcreditationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,

        title: Text(
          'SKIP',
          style: FlutterFlowTheme.bodyText2.override(
            fontFamily: 'Poppins',
            color: FlutterFlowTheme.secondaryColor,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Asset',
                          style: FlutterFlowTheme.subtitle1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.secondaryColor,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 9, bottom: 9, right: 10),
                            child: Row(

                              children: [
                                Container(
                                  width: 23,
                                  height: 23,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.moGaweGreen,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Color(0x8F515151),
                                        offset: Offset(0, 2),
                                        spreadRadius: 0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: FlutterFlowTheme.secondaryColor,
                                    size: 14,
                                  ),
                                ),
                                SizedBox(width: 7,),
                                Text('Terverifikasi : 3/15',  style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Lato',
                                  color: FlutterFlowTheme.secondaryColor,
                                ),),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  minHeight: 400,
                  maxHeight: MediaQuery.of(context).size.height - 200
                ),
                child: ListView.builder(
                    itemCount: 7,
                    itemBuilder: (context, snap){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: Offset(1,1)
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xffbfbfbf),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: FlutterFlowTheme.secondaryColor,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: 14,),
                                Text('Menghitung', style: FlutterFlowTheme.subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                ),),
                              ],
                            ),

                            Text('Belum Terverifikasi', style: FlutterFlowTheme.bodyText3.override(
                              fontFamily: 'Poppins',
                              color: Colors.black12,
                            ),),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
