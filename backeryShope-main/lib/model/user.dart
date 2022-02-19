
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mill_10/model/constantsName.dart';

class UserModel{
  String name,password;
  String role;
  String type;
  String userid;
  String phone;
  String email;
  String description;
  String group;
  String ytunus;
  String address;

  UserModel({this.name, this.role, this.type, this.userid, this.phone,this.password,
    this.email, this.description, this.group,  this.address,this.ytunus});


  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> documentSnapshot){

    userid = documentSnapshot.id;
    email = documentSnapshot.data()['email'];
    password = documentSnapshot.data()['password'];
    name = documentSnapshot.data()['name'];
    phone = documentSnapshot.data()['phone'];
    description = documentSnapshot.data()['description'];
    type=documentSnapshot.data()['type'];
    role=documentSnapshot.data()['role'];
    address=documentSnapshot.data()['address'];
    ytunus=documentSnapshot.data()['ytunus'];
    group=documentSnapshot.data()['group'];

  }
  UserModel.from(Map<String, dynamic> snapshot){
    // _group=snapshot[constantuser.group];
    userid=snapshot[Constantuser.id];
    name=snapshot[Constantuser.name];
    password=snapshot['password'];
    email=snapshot[Constantuser.email];
    phone=snapshot[Constantuser.phone];
    description=snapshot[Constantuser.description];
    type=snapshot[Constantuser.type];
    role=snapshot[Constantuser.role];
    address=snapshot[Constantuser.address];
    ytunus=snapshot[Constantuser.ytunus];
    group=snapshot['group'];


  }

  UserModel.toMap(DocumentSnapshot<Object> snapshot) {

   Map map = snapshot.data();
    this.name=map["name"];
    this.password=map["password"];
    this.phone=map["phone"];
    this.email=map["email"];
    this.address=map["address"];
    this.type=map["type"];
    this.description=map["description"];
    this.role=map['role'];
    this.ytunus=map[ytunus];
    this.group=map['group'];
    }

  }

