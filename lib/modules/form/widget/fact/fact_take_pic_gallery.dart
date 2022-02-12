import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as imgPicker;
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/data/response/form/result/file_path.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';

class FactTakeGalleryPic extends StatefulWidget {
  const FactTakeGalleryPic({
    required this.fact,
    required this.incrementCounterCallback,
    required this.sendChangedFact
  });

  final Fact fact;
  final NotifyIncrementCounterHandler incrementCounterCallback;
  final SendChangedFact sendChangedFact;

  @override
  _FactTakeGalleryPicState createState() => _FactTakeGalleryPicState();
}

class _FactTakeGalleryPicState extends State<FactTakeGalleryPic> {
  final picker = imgPicker.ImagePicker();
  late File photo;
  String path = "";
  List<Map<String, File>> files = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: path == "" ? FlutterFlowTheme.tertiaryColor : FlutterFlowTheme.primaryColor,
              ),
              SizedBox(width: 8),
              Text(widget.fact.factName),
            ],
          ),
          Text(widget.fact.hintName),
          Padding(
            padding: EdgeInsets.symmetric(horizontal : 16.0),
            child: InkWell(
              onTap: () async => _getImageGallery(),
              child: path == "" ? _buildDottedPlaceHolder() : _buildImageFromFile(photo)
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImageFromFile(File file){
    return Image.file(file);
  }

  Widget _buildDottedPlaceHolder(){
    return DottedBorder(
      strokeWidth: 2,
      dashPattern: [10, 10],
      borderType: BorderType.RRect,
      color: Colors.grey,
      radius: Radius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Icon(
          Icons.camera_alt_outlined,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }

  Future _getImageGallery() async {
    final pickedFile = await picker.pickImage(source: imgPicker.ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        photo = File(pickedFile.path);
        path = photo.path.split('/').last;
        var map = {
          "path": photo
        };

        files.add(map);
        widget.fact.files = files;
        widget.fact.input = files.length.toString();

        widget.sendChangedFact(widget.fact);
      });
      widget.incrementCounterCallback();
    }
  }
}
