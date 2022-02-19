

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mill_10/model/constantsName.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ProductModel {


  String productname,id,userid;
  String idproduct,groupcount;
  String description,groupName;
  String image;
  String quantity,orderType,userID;

  ProductModel({this.groupName,this.groupcount,this.userid,this.productname, this.idproduct, this.image,this.userID,this.quantity,this.description,this.id,this.orderType});

  Map<String, dynamic> toMap() {
    return {
      'groupName':groupName,
      'groupCount':groupcount,
      'userid':userid,
      'orderType':orderType,
      'quantity':quantity,
      ConstantProduct.PRODUCTNAME: productname,
      ConstantProduct.IDPRODUCT: idproduct,
      ConstantProduct.IMAGE: image,
      Constantuser.description:description,
      'id':id,'userID':userID
    };
  }
  ProductModel.fromlist(Map<String, dynamic> snapshot) {
    groupName=snapshot['groupName'];
    groupcount=snapshot["groupCount"];
    userid=snapshot['userid'];
    productname = snapshot[ConstantProduct.PRODUCTNAME];
    idproduct =snapshot[ConstantProduct.IDPRODUCT];
    image =snapshot[ConstantProduct.IMAGE];
    quantity=snapshot['quantity'];
    description=snapshot[Constantuser.description];
    id=snapshot['id'];
    orderType=snapshot['orderType'];
    userID=snapshot['userID'];

  }
  ProductModel.toMap(DocumentSnapshot<Object> snapshot, ) {
    Map map = snapshot.data();
    this.groupName=map['groupName'];
    this.groupcount=map['groupCount'];
    this.userid=map['userid'];
    this.userID=snapshot['userID'];
    this.id=map['id'];
    this.productname=map['productname'];
    this.idproduct= map['idproduct'];
    this.image=map["image"] ;
  this.quantity=map['quantity'];
    this.description=map["description"];
    this.orderType=map['orderType'];
  }
}







class DriverModel {


  String productname,image,description;
  String idproduct;
  String quantity;
  String group,orderId,userID;
  bool isFinished=false;

  DriverModel({this.orderId, this.userID,this.productname, this.idproduct,this.quantity,this.group,this.isFinished,this.image});

  Map<String, dynamic> toMap() {
    return {
      'orderId':orderId,
      'userID':userID,
      'description':description,
      'image':image,
      "isFinished":isFinished,
      'quantity':quantity,
      ConstantProduct.PRODUCTNAME: productname,
      ConstantProduct.IDPRODUCT: idproduct,
      Constantuser.group: group,

    };
  }
  DriverModel.fromlist(Map<String, dynamic> snapshot) {
    orderId=snapshot['orderId'];
    userID=snapshot['userID'];
    description=snapshot['description'];
    image=snapshot['image'];
    isFinished=snapshot['isFinished'];

    productname = snapshot[ConstantProduct.PRODUCTNAME];
    idproduct =snapshot[ConstantProduct.IDPRODUCT];
    quantity=snapshot['quantity'];
    group=snapshot[Constantuser.group];

  }
  DriverModel.toMap(DocumentSnapshot<Object> snapshot, ) {

    Map map = snapshot.data();
    this.orderId=map['orderId'];
this.userID=map['userID'];
    this.description=map['description'];
    this.image=map['image'];
    this.isFinished=map['isFinished'];
    this.productname=map['productname'];
    this.idproduct= map['idproduct'];
    this.quantity=map['quantity'];
    this.group=map["group"];
  }
}

