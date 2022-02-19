import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Constantuser{
  static const password="passowrd";
  static const name="name";
  static const email="email";
  static const phone="phone";
  static const id="userid";
  static const description="description";
  static const type="type";
  static const role="role";
  static const ytunus="ytunus";
  static const address="address";
  static const group="group";
}
class ConstantProduct{
  static const COLLECTION = "product";



  static const IDPROF = "idprof";
  static const PRODUCTNAME = "productname";
  static const PRICE = "price";
  static const OFFER = "offer";
  static const DESCRIPTION = "description";
  static const FEATURES = "features";
  static const QUANTITY = "totalequantity";
  static const DETAIL = "detail";
  static const IDPRODUCT = 'idproduct';
  static const IMAGE = "image";
}
final Future<FirebaseApp> initialization = Firebase.initializeApp();

FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
