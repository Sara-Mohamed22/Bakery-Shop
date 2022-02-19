import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart'as path;
import 'package:shared_preferences/shared_preferences.dart';
// uploadImageToFirebase(File imageFile,String linkimage) async{
//   try{
//     String fileName = path.basename(imageFile.path);
//     FirebaseStorage storage = FirebaseStorage.instance;
//     //   Reference ref = storage.ref().child('products/$fileName');
//     //   UploadTask uploadTask = ref.putFile(_imageFile);
//     await   storage.ref().child('activitie/$fileName').putFile(imageFile).then((res) {
//       res.ref.getDownloadURL().then((value) {
//         linkimage = value;
//       });
//     });
//   return linkimage;
//         }catch(e){
//     print("exception add image :$e");
//   }
// }

class UploadImageService {



  Future<String> uploadImageToFirebase(
      {
        @required File imageFile,
        @required String nameDirectory,
        @required String namefield,
      }
      )
  async {
    String  linkimage="";

    try{


      String fileName = path.basename(imageFile.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      //   Reference ref = storage.ref().child('products/$fileName');
      //   UploadTask uploadTask = ref.putFile(_imageFile);
      await   storage.ref().child('$nameDirectory/$fileName').putFile(imageFile).then((res) async {
      await  res.ref.getDownloadURL().then((value)  {


          linkimage = value.toString();
          print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$linkimage");
          return linkimage;
        });
      });
      return linkimage;
    }catch(e){
      print("exception UploadImageService file=>sevices addimagetostorage :$e");
      return "";
    }
  }
  removeimage(String linkimage){
    String filePath = linkimage
        .replaceAll(new
    RegExp(r'https://firebasestorage.googleapis.com/v0/b/styleme-78972.appspot.com/o/'), '');

    filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');

    filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');
    print("filePathfilePathfilePath:$filePath");
    FirebaseStorage.instance.ref().child(filePath).delete().then((_) => print('Successfully deleted $filePath storage item' ));

  }
  Future<String> uploadImageProductToFirebase(
      {
        @required File imageFile,
        @required String nameDirectory,
      }
      )
  async {
    String  linkimage="";

    try{

      String fileName = path.basename(imageFile.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      //   Reference ref = storage.ref().child('products/$fileName');
      //   UploadTask uploadTask = ref.putFile(_imageFile);
      TaskSnapshot res=    await   storage.ref().child('$nameDirectory/$fileName').putFile(imageFile);
      //.then((res) {
      linkimage= await res.ref.getDownloadURL();
      // .then((value)  {
      //     linkimage = value.toString();
      //     print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$linkimage");
      //   });
      //  });
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1$linkimage");

      return linkimage;
    }catch(e){
      print("exception UploadImageService file=>sevices addimagetostorage :$e");
      return "";
    }
  }
}
