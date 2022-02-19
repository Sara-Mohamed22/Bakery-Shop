

// ignore_for_file: file_names

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel {
  bool backeryFinish=false;
  String id,orderId,idProduct;
  String productname;
  String image;
  String quantity,groupName,groupCount;
  String description,userId;
  String orderType = "begin" ;

  OrderModel({
    this.id,
    this.idProduct,
    this.backeryFinish = false,
  @required this.orderId,
    @required this.groupName,
  @required this.groupCount,
    @required this.orderType,
    @required this.productname,
    @required this.quantity,
    @required this.image,
    @required this.description,
    @required this.userId
  });

  OrderModel.toMap(DocumentSnapshot<Object> snapshot) {
    Map map = snapshot.data();
    this.idProduct=map['idProduct'];
    this.backeryFinish=map['backeryFinish'];
    this.groupCount=map['groupCount'];
    this.groupName=map['groupName'];
    this.orderId=map['orderId'];
    this.orderType=map['orderType'];
    this.description=map["description"];
    this.id = map['id'];
    this.productname = map["productname"];
    this.image = map["image"];
    this.quantity = map["quantity"];
    this.userId=map['userID'];
  }

  Map<String, dynamic> toMap() {

    return {
      'idProduct':idProduct,
      'backeryFinish':backeryFinish,
      'groupCount':groupCount,
      'groupName':groupName,
      'orderId':orderId,
      'orderType':orderType,
     " id":id,
      "description":description,
      'productname': productname,
      'image': image,
      'quantity': quantity,
      'userID':userId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
        idProduct:map['idProduct'],
      backeryFinish: map['backeryFinish'],
      groupCount: map['groupCount'],
      groupName: map['groupName'],
      orderId: map['orderId'],
      id: map['id'],
      orderType: map['orderType'],
      productname: map['productname'],
      quantity: map['quantity'],
      image: map['image'],
      description:map["description"],
      userId: map['userID']
    );
  }

 OrderModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> documentSnapshot){
   idProduct=documentSnapshot.data()['idProduct'];
   backeryFinish=documentSnapshot.data()['backeryFinish'];
groupCount=documentSnapshot.data()['groupCount'];
groupName=documentSnapshot.data()['groupName'];
    id = documentSnapshot.id;
    orderId = documentSnapshot.data()['orderId'];
    productname = documentSnapshot.data()['productname'];
    quantity = documentSnapshot.data()[' quantity'];
    description = documentSnapshot.data()['description'];
    userId = documentSnapshot.data()['userId'];
    orderType=documentSnapshot.data()['orderType'];}
}