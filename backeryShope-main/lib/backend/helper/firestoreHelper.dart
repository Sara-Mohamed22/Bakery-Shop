
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mill_10/backend/provider/eventsProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/model/meeting.dart';
import 'package:mill_10/model/orderModel.dart';
import 'package:mill_10/model/product.dart';
import 'package:mill_10/model/user.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';

enum orderStatus {begin, preparing, confirmed,delivered ,ready , complete}

class FirestoreHelper {
  FirestoreHelper._();
  DateTime datePicked;
  DateTime calendarDate;
 static String userId;
 String userGroup;
  DocumentReference<Map<String, dynamic>>  doce;
  DocumentReference<Map<String, dynamic>> preparID;
  DocumentReference<Map<String, dynamic>> calenderID;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirestoreHelper firestoreHelper = FirestoreHelper._();



  exitApp() async {
    Globals.globals.userModel = null;
  }
  addEvent(Meeting meet,context)async{
    // List<Appointment> appoint = <Appointment>[];
    final provider=Provider.of<EventsProvider>(context,listen:false);
    // appoint.add(Appointment(
    //     subject: provider.nameController.text,
    //     notes: provider.noteController.text ,
    //     isAllDay: false,
    //     startTime:provider.fromDate, endTime:provider.toDate));


    calenderID= await firestore.collection('calender').add(meet.tooMap());
    await  firestore.collection('calender').doc(calenderID.id).update({"id": calenderID.id});

    Fluttertoast.showToast(msg: "Save to Calender", textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo,
    );
  }

 //  Future<List<Meeting>> getAllMeeting() async{
 // QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore.collection('calender').get();
 //
 // List<Meeting> events = querySnapshot.docs.map((e) {
 //   Map map = e.data();
 //   map['id'] = e.id;
 //   return Meeting.fromMap(map);
 //  }).toList();
 //
 //    return events;
 //  }

  // addOrder(OrderModel orderModel,context)async{
  //   var useId =  Provider.of<UserProvider>(context,listen: false).currentUser.uid;
  //
  //   OrderModel model =OrderModel(
  //     productname: orderModel.productname,description: orderModel.description,image: orderModel.image,
  //       userId:useId, quantity: orderModel.quantity,orderType: orderModel.orderType);
  //   doce =  await firestore.collection('orders').add(model.toMap());
  //   firestore
  //       .collection('orders').doc(doce.id)
  //       .update({"id":doce.id,'orderId':doce.id,"orderType":"begin"});
  //
  //   Fluttertoast.showToast(msg: "Orderd Successfully", textColor: Colors.white,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo,
  //   );
  // }

  makeOrders(OrderModel orderModel) async{

    // orID=orderModel.orderId;
    await firestore.collection('orders').doc(orderModel.id)
        .update({'id':orderModel.id,"orderType":"onPrepaer",
      'quantity':orderModel.quantity,'description':orderModel.description,});

    Fluttertoast.showToast(msg: "Orderd Successfully", textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo);

  }


  createOrder(OrderModel orderModel,context) async{
     userId =  Provider.of<UserProvider>(context,listen: false).currentUser.uid;
     DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore.collection('users').doc(userId).get();
     UserModel userModel = UserModel.fromDocumentSnapshot(documentSnapshot);

     orderModel.groupName = userModel.group;

     final data = orderModel.toMap(orderStatus.begin.name);
     data['isReceived'] = false;
   final res = await firestore.collection('orders').add(data);

   if(res.id != null) {
     Fluttertoast.showToast(msg: "Order Created Successfully", textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo);
    AppRouter.router.popPage();
   }
   else{
     Fluttertoast.showToast(msg: "Something went wrong :(", textColor: Colors.white,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM, backgroundColor: Colors.red);
   }
  }

  Future<void> changeOrderState(orderStatus state , String orderId, [String dateDelivered]) async{
    final res = await firestore.collection('orders').doc(orderId).update(
        {'status': state.name, if(dateDelivered != null) 'dateDelivered': dateDelivered});
  }



  Future<void> receivedOrder(bool isReceived , String orderId) async{
    final res = await firestore.collection('orders').doc(orderId).update(
        {'isReceived':isReceived});
  }



  addProduct(ProductModel productModel) async {
    DocumentReference<Map<String, dynamic>> doce = await firestore.collection('product').add(productModel.toMap());
  await  firestore
        .collection('product')
        .doc(doce.id)
        .update({"idproduct":doce.id});

    Fluttertoast.showToast(msg: "Product is Added Successfully",
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.indigo,
    );

  }

  Future<UserModel> getUser(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore.collection('users').doc(userId).get();
    UserModel userModel = UserModel.fromDocumentSnapshot(documentSnapshot);
    Globals.globals.userModel = userModel;
    // userGroup= userModel.group;
    return userModel;
  }



  Future<OrderModel> getOrderByID(String userId) async{
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore.collection('orders').doc(userId).get();
    OrderModel oderModel=OrderModel.fromDocumentSnapshot(documentSnapshot);
    Globals.globals.orderModel=oderModel;
    return oderModel;
  }

  Future<List<ProductModel>> getAllProducts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore.collection('product').get();
    List<ProductModel> cat = querySnapshot.docs.map((e) {
      Map map = e.data();
      map['id'] = e.id;
      return ProductModel.fromlist(map);
    }).toList();
    return cat;
  }

  Future<List<OrderModel>> getAllCategories() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firestore.collection('orders').where('orderType',isEqualTo: "onDriven").get();
    List<OrderModel> categories = querySnapshot.docs.map((e) {
      Map map = e.data();
      map['id'] = e.id;
      return OrderModel.fromMap(map);
    }).toList();
    return categories;
  }

  addPrepareOrderToDriver(OrderModel orderModel,context,String userID)async{

  await  firestore
        .collection('orders')
        .doc(orderModel.id)
        .update({'orderType':"onDriven",'userID':userID,'orderId':orderModel.id});

   Fluttertoast.showToast(msg: "Order is delivered to Driver Successfully", textColor: Colors.white,
     toastLength: Toast.LENGTH_SHORT,
     gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo);

    // firestore
    //     .collection('orders').doc(orderModel.orderId)
    //     // .collection('preparbingOrder').doc(preparID.id)
    //     // .collection('DriverOrder').doc(driverID.id)
    //     .update({'orderType':"onDriven"});

  // Fluttertoast.showToast(msg: "Order is delivered to Driver Successfully", textColor: Colors.white,
  // toastLength: Toast.LENGTH_SHORT,
  // gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo,
  // );
}

  User getCurrentUserId() {
    return firebaseAuth.currentUser;
  }


}
