

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mill_10/service/imageupload.dart';

class UploadImageProvider extends ChangeNotifier {


  UploadImageService _uploadservice = UploadImageService();
  String _linkimage="";
  bool loading=false;
  String get linkimage => _linkimage;

  set linkimage(String value) {
    _linkimage = value;
  }



  UploadImageProvider.nodata(){}


  uploadimageandgetlinkimage(File imageFile,String nameDirectory,String namefield) async {
    _linkimage = (await _uploadservice.uploadImageToFirebase(
        imageFile: imageFile,
        nameDirectory: nameDirectory,
        namefield: "f"
    ));
    loading=true;
    notifyListeners();


  }

  remove(String linkimage){
    _uploadservice.removeimage(linkimage);
    linkimage="";
    notifyListeners();
  }

  uploadImageProductToFirebase(File imageFile,String nameDirectory) async {
    linkimage = await _uploadservice.uploadImageProductToFirebase(
      imageFile: imageFile,
      nameDirectory: nameDirectory,
    );
    loading=true;
    notifyListeners();


  }


}
