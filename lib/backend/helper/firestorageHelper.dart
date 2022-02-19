// ignore_for_file: file_names

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


class FirestorageHelper {
  FirestorageHelper._();
  static FirestorageHelper firestorageHelper = FirestorageHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;


  Future<String> uploadImage(File file, [String directoryName]) async {
    String imageName = file.path.split('/').last;
    // 1 make a refrence for uploading image
    try {
      Reference reference = firebaseStorage.ref(directoryName == null
          ? 'users/imageName'
          : '$directoryName/$imageName');
      //2 uplad the image
      await  reference.putFile(file);
      String imageUrl = await reference.getDownloadURL();
      return imageUrl;
    } on Exception catch (e) {
      print(e);
    }}







// Future<String> uploadImage(File _image1) async {
//   FirebaseStorage storage = FirebaseStorage.instance;
//   String url;
//   Reference ref = storage.ref().child("image1" + DateTime.now().toString());
//   UploadTask uploadTask =  ref.putFile(_image1);
//   uploadTask.whenComplete(() {
//     Future<String> url =   ref.getDownloadURL();})
//       .catchError((onError) {
//     print(onError);
//   });
//   return url;
// }











// Future<List<String>> uploadImage(List<File> images) async {
//   if (images.length < 1) return null;
//
//   List<String> _downloadUrls = [];
//
//   await Future.forEach(images, (image) async {
//     Reference ref = FirebaseStorage.instance
//         .ref()
//         .child('jobPost')
//         .child(getFileName(path: image));
//     final UploadTask uploadTask = ref.putFile(image);
//     final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
//     final url = await taskSnapshot.ref.getDownloadURL();
//     _downloadUrls.add(url);
//   });
//
//   return _downloadUrls;
// }






}
