

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
  DateTime dateDelivered;

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

  OrderModel.fromJson(DocumentSnapshot<Object> snapshot) {
    Map map = snapshot.data();
    idProduct=map['idProduct'];
    backeryFinish=map['backeryFinish'];
    groupCount=map['groupCount'];
    groupName=map['groupName'];
    orderId=map['orderId'];
    orderType=map['orderType'];
    description=map["description"];
    id = map['id'];
    productname = map["productname"];
    image = map["image"];
    quantity = map["quantity"];
    userId=map['userID'];
    dateDelivered = DateTime.parse(map['dateCreated']);
  }

  Map<String, dynamic> toMap([String status]) {

    return {
      'idProduct':idProduct,
      'bakeryFinish':backeryFinish,
      'groupCount':groupCount,
      'groupName':groupName,
      'orderId':orderId,
      'orderType':orderType,
      "description":description,
      'productname': productname,
      'image': image,
      'quantity': quantity,
      'userID':userId,
      if(status != null)'status': status,
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