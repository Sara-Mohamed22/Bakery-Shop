// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mill_10/backend/helper/firestorageHelper.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/model/constantsName.dart';
import 'package:mill_10/model/orderModel.dart';
import 'package:mill_10/model/product.dart';
import 'package:mill_10/model/user.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AdminProvider extends ChangeNotifier {
  File file;
  int total;
  var docs;
  dynamic idProduct;
  var dropdownValue;
  int typeGroup=0;
  String idOrder,iduser,orderIDD,groupOrder;
  static SharedPreferences prefs;
  String productName;
  String count,description;
  ProductModel productModel,model,products;
  ProductModel selectProduct;
  OrderModel selectID,mod;
  ProductModel selectedCategoryModel;
  String gruopName = 'A';
List<ProductModel> cat=[];
  UserModel selectEmployname,userModel,selectedEmploye;
  TextEditingController nameE = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController noteProductController = TextEditingController();
  GlobalKey<FormState> productKey = GlobalKey<FormState>();
  GlobalKey<FormState> notekey = GlobalKey<FormState>();
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>> doceDriver;
  DocumentReference<Map<String, dynamic>> finishedID;
  DocumentReference<Map<String, dynamic>> docBackery;
  List<OrderModel> categories;

   getCategories() async {
    List<OrderModel> categories = await FirestoreHelper.firestoreHelper.getAllCategories();
    this.categories = categories;
     // getCategoryProducts(categories.first.id);
    notifyListeners();
  }

int group;
  toggleGroup(int i) {
    this.typeGroup = i;
    notifyListeners();
  }


  selectCategory(ProductModel categoryModel) {
    selectProduct = categoryModel;
    notifyListeners();
  }

  startBackery(OrderModel productModel) async{
    
 docBackery=  await firestore.collection('productBackery').add(productModel.toMap());
 await firestore
        .collection("productBackery")
        .doc(docBackery.id)
        .update({"id":docBackery.id,"idproduct":docBackery.id,"isFinished": false,});

    Fluttertoast.showToast(msg: "start Preparing order", textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo,
    );
    notifyListeners();

  }
  stopBackery(OrderModel productModel) async{

   await firestore
        .collection("productBackery")
        .doc(docBackery.id)
     //   .update({"id":docBackery.id,"idproduct":docBackery.id,"isFinished": true,});
        .update({"id":docBackery.id,"idproduct":docBackery.id," isReceived": true,});



    Fluttertoast.showToast(msg: "ordered is Finished", textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo,
    );

   for(int i=0; i<docs.length;i++){
  await   firestore
         .collection("orders")
         .doc(docs[i]['id'])
         .update({'backeryFinish':true});
        }

    notifyListeners();
  }







  sendPreparedOrderToDriver(QueryDocumentSnapshot<Object>  driverOrder,context,String userID)async{
    // OrderModel model=OrderModel(
    //   productname: orderModel.productname,
    //   image:orderModel.image,
    //   quantity: orderModel.quantity,
    //   description: orderModel.description,
    // );
    await FirestoreHelper.firestoreHelper.addPrepareOrderToDriver(OrderModel.fromJson(driverOrder),context,userID);
    notifyListeners();
  }

  startDriver(DriverModel orderModel,String userID,String orderId,String note)async{

    DriverModel modelDeliver= DriverModel (
      userID: userID,
         orderId:orderId,
         image: orderModel.image,
         quantity: orderModel.quantity,
         idproduct:orderModel.idproduct,
         productname: orderModel.productname,


         isFinished: false,
         group: typeGroup == 0 ? "A" : typeGroup == 1 ? "B" : "C",
      );
    doceDriver =  await firestore.collection('orderedFinished').add(modelDeliver.toMap());
   firestore
       .collection('orderedFinished')
       .doc(doceDriver.id)
       .update({"idproduct":doceDriver.id,"isFinished": false,'userID':userID,'orderId':orderId,'description':note});

   Fluttertoast.showToast(msg: "start Delivary now", textColor: Colors.white,
     toastLength: Toast.LENGTH_SHORT,
     gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo,
   );
   notifyListeners();
   return modelDeliver;
  }

  //TODO: remove this
  stopDriver(DriverModel orderModel,String orderID)async{

    // DriverModel modelDeliver= DriverModel (
    //   orderId: idOrder,
    //   quantity: orderModel.quantity,
    //   idproduct:orderModel.idproduct,
    //   productname: orderModel.productname,
    //   isFinished: true,
    //   group: typeGroup == 0 ? "A" : typeGroup == 1 ? "B" : "C",
    // );
   // finishedID =  await firestore.collection('orderedFinished').doc(doceDriver.id).collection('Finished').add(modelDeliver.toMap());
   await firestore
        .collection('orderedFinished')
        .doc(doceDriver.id)
        .update({"idproduct":doceDriver.id,"isFinished":true});

    Fluttertoast.showToast(msg: "Delivary is done ", textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo,
    );
   // var deletId=
 ///  await firestore.collection('orders').doc(orderID).delete();
   // categories.removeWhere((item) => item.id == deletId);
    notifyListeners();
    // return modelDeliver;



  }

   makeProductOrderP(OrderModel orderModel,context) async {

    await FirestoreHelper.firestoreHelper.createOrder(orderModel,context);
    clearVariablesOrder();
    // notifyListeners();

  }


  makeOrder(QueryDocumentSnapshot<Object> orderModel) async {

    await FirestoreHelper.firestoreHelper.makeOrders(OrderModel.fromJson(orderModel));
    notifyListeners();

  }


  deleteCategory(String id) async {
    await firestore.collection('orders').doc(id).delete();
  }


  selectImage() async {
    PickedFile pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);
    this.file = File(pickedFile.path);
    notifyListeners();
  }


  Future<String> uploadImage(String path) async {
    String imageUrl = await FirestorageHelper.firestorageHelper.uploadImage(file, path);
    return imageUrl;
  }


  selectemploye(UserModel employe) {
    this.selectedEmploye = employe;
    notifyListeners();
  }



  nullValidation(String value) {
    if (value.length == 0) {
      return 'Required field';
    }
    notifyListeners();
  }



   addProduct() async {
    if (productKey.currentState.validate()) {
      String imageUrl = await uploadImage('product');
      ProductModel productModel = ProductModel(
        productname: productNameController .text,
        image: imageUrl,);
      await FirestoreHelper.firestoreHelper.addProduct(productModel);
      AppRouter.router.popPage();
    }
    else {
      return;
    }
    notifyListeners();
  }


  clearVariablesOrder() {
    noteProductController.clear();
    notifyListeners();
  }


getproduct() async{
  List<ProductModel> categories = await FirestoreHelper.firestoreHelper.getAllProducts();
  this.cat = categories;
  // getCategoryProducts(categories.first.id);
  notifyListeners();
}


///////////////////////////
int  _num = 0;
  void changeNum(int number)
  {
    _num =number ;
    notifyListeners();
  }

  int get num => _num;

  dynamic driveTime ;
  getTime(dynamic t)
  {
    driveTime =t ;
    notifyListeners();
  }

}

