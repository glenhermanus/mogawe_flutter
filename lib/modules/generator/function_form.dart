import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:mime/mime.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/generator/webview_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FunctionForm extends StatefulWidget {
  const FunctionForm({Key? key}) : super(key: key);

  @override
  _FunctionFormState createState() => _FunctionFormState();
}

class _FunctionFormState extends State<FunctionForm> {

  late File filer;
  final FileType pickingType = FileType.any;
  List<File> files =[];
  var fileType;
  bool _loadingButton = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;


  Widget munculingambar(BuildContext context){
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return ListView.builder(
        itemCount: files!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index){

          filer = files![index];
          String? mimeStr = lookupMimeType(filer.path);
          fileType = mimeStr!.split('/');
          print('file type ${fileType}');
          if (fileType[0] == 'image'){
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  FullScreenWidget(
                    child: SafeArea(
                      child: Image.file(File(filer.path), height: 150, fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 3.0,
                    child: InkWell(
                      child: Icon(
                        Icons.remove_circle_rounded,
                        size: 20,
                        color: Colors.red,
                      ),
                      // This is where the _image value sets to null on tap of the red circle icon
                      onTap: () {
                        setState(
                              () {
                            files!.removeAt(index);
                          },
                        );
                      },
                    ),
                  ),

                ],
              ),
            );
          }
          else if (fileType[0] == 'video')
          {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset('assets/mp4.png', width: 80, height: 50, fit: BoxFit.fill,),

                ),
                Positioned(
                  right: 3.0,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle_rounded,
                      size: 20,
                      color: Colors.red,
                    ),
                    // This is where the _image value sets to null on tap of the red circle icon
                    onTap: () {
                      setState(
                            () {
                          files!.removeAt(index);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
                children: [
                  Image.asset(
                    'assets/file.png', width: 80,  height: 50, fit: BoxFit.fill,),
                  Positioned(
                    right: 3.0,
                    child: InkWell(
                      child: Icon(
                        Icons.remove_circle_rounded,
                        size: 20,
                        color: Colors.red,
                      ),
                      // This is where the _image value sets to null on tap of the red circle icon
                      onTap: () {
                        setState(
                              () {
                            files!.removeAt(index);
                          },
                        );
                      },
                    ),
                  ),
                ]),
          );

        });

  }

  Future<void> openfilemanager() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: pickingType);

    if(result != null) {
      files = result.paths.map((path) => File(path!)).toList();
    } else {
      // User canceled the picker
    }
    if (!mounted) return;
    var data = files!.length;
    print('data: $data');
    setState(() {
      files != null ? files!.map((e) => e.toString()).toString() : 'error';

    });
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                SizedBox(height: 40,),
                Text('upload from galery'),
                GestureDetector(
                  onTap: (){openfilemanager();},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xffbfbfbf)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Browse',
                          ),
                          Icon(
                            Icons.open_in_browser,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                files!= null ? Container(
                  width: 300, height: 150,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: munculingambar(context)),
                    ],
                  ),
                ) : Container(),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 28),
                  child: FFButtonWidget(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebviewFlutter(),
                        ),
                      );
                    },
                    text: 'webview',
                    options: FFButtonOptions(
                      width: 130,
                      height: 48,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: FlutterFlowTheme.title3.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                    loading: _loadingButton,
                  ),
                ),
                Text('Qr'),
                Container(
                  height: 300,
                  child: Expanded(
                    flex: 5,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
