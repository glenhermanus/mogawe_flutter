import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/profile_repository.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class AjakTemanPage extends StatefulWidget {
  const AjakTemanPage({Key? key}) : super(key: key);

  @override
  _AjakTemanPageState createState() => _AjakTemanPageState();
}

class _AjakTemanPageState extends State<AjakTemanPage> {
  Result? currentResult;

  kirimcode(mogawersCode)async{
    try{
      await ProfileRepository().scanQR(mogawersCode);
      Navigator.pop(context);
    }catch(e){

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          QRCodeDartScanView(
            scanInvertedQRCode: true,
            onCapture: (Result result) {
              setState(() {
                currentResult = result;
                kirimcode(currentResult);
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 40,  ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.clear, color: Colors.white, size: 24,)),
                Text('Ajak Teman', style: FlutterFlowTheme.title3.copyWith(color: Colors.white),),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 84, right: 84),
                  child: DottedBorder(
                    dashPattern: [22,40],
                    borderType: BorderType.RRect,
                    strokeWidth: 3,
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height:  MediaQuery.of(context).size.height * 0.3 ,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 40,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              //  Text('Pastikan QR Code berada di tengah kotak', style: FlutterFlowTheme.bodyText3.copyWith(color: Colors.white),)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
