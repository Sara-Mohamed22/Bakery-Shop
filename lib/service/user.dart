
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mill_10/model/constantsName.dart';
import 'package:mill_10/model/user.dart';
import 'package:mill_10/utilities/router.dart';

class UserServices {



  void createCustomer({

    @required String id,
    @required String name,
    @required String password,
    @required String phone,
    @required String email,
    @required String address,
    @required String ytunus,
    @required String description,
    @required String group,}) {
    try {
      DocumentReference ref = firebaseFiretore.collection('users').doc(id);
      ref.set({
        Constantuser.type:"costumer",

        Constantuser.id:id,
        "passowrd":password,
        Constantuser.name: name,
        Constantuser.phone:phone,
        Constantuser.email:email,
        Constantuser.address:address,
        Constantuser.ytunus:ytunus,
        Constantuser.description:description,
        Constantuser.group: group,

      });

      AppRouter.router.popPage();
    } catch (e) {
      print("exception create User file=>service user : $e ");
    }
  }
   createemploye({
    @required String role,
    @required String id,
    @required String name,
    @required String phone,
    @required String email,
    @required String description,
     @required String password

  }) {
    try {
      DocumentReference ref = firebaseFiretore.collection('users').doc(id);
      ref.set({
        Constantuser.type:"employee",
        Constantuser.id:id,
        Constantuser.name: name,
        Constantuser.phone:phone,
        Constantuser.description:description,
        Constantuser.email:email,
        Constantuser.role: role,
        Constantuser.password:password,
      });

      AppRouter.router.popPage();
    } catch (e) {
      print("exception create User file=>service user : $e ");
    }
  }

  createAdmin({

    @required String id,
    @required String name,
    @required String email,
    @required String password,
    @required String description,

  }) {
    try {
      DocumentReference ref = firebaseFiretore.collection('users').doc(id);
      ref.set({
        Constantuser.type:"admin",
        Constantuser.id:id,
        Constantuser.email:email,
        Constantuser.password:password
      });
    } catch (e) {
      print("exception create User file=>service user : $e ");
    }
  }

  void updateUserProfile({
    @required String id,
    @required String password,
    @required String name,
    @required String phone,
    @required String email,
    @required String address,
    @required String ytunus,
    @required String description,
    @required String group,}) {
    try {
      firebaseFiretore.collection('users').doc(id).update({
        "passowrd":password,
        Constantuser.name: name,
        Constantuser.phone:phone,
        Constantuser.email:email,
        Constantuser.address:address,
        Constantuser.ytunus:ytunus,
        Constantuser.description:description,
        Constantuser.group: group,
      });
      Fluttertoast.showToast(msg: "customer is Updated successfully", textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo,
      );
      AppRouter.router.popPage();

    } catch (e) {
      print("exception  update User Profile file=>service user: $e ");
    }
  }




  void updateEmployeeProfile({
    @required String role,
    @required String id,
    @required String pass,
    @required String name,
    @required String phone,
    @required String email,
    @required String description,
  }) {
    try {
      firebaseFiretore.collection('users').doc(id).update({
        Constantuser.password:pass,
        Constantuser.name:name,
        Constantuser.phone:phone,
        Constantuser.email:email,
        Constantuser.role:role,
        Constantuser.description:description,

      });
      Fluttertoast.showToast(msg: "Employee is Updated successfully", textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo,
      );
      AppRouter.router.popPage();

    } catch (e) {
      print("exception  update User Profile file=>service user: $e ");
    }
  }










  void updateUserData(Map<String, dynamic> values) {

    firebaseFiretore.collection('users').doc(values['userid']).update(values);
  }

  void uploadimage(String linkimage, String id) {
    firebaseFiretore.collection('users').doc(id).update({
      "imageprofile": linkimage
    });
  }

     getUserById(String id) async {
    await firebaseFiretore.collection('users').doc(id).get().then((doc) {
      //  print("role eole from snapshot ${doc.get("role")}");
      return UserModel.fromDocumentSnapshot(doc);
    });
  }

  Future<List<UserModel>> getUsers() async {
    List<UserModel>a=[];
      await firebaseFiretore.collection('users').get().then((doc) {

        final _docData = doc.docs.map((doc) => doc.data()).toList();
        print(_docData);
        for (int i = 0; i < _docData.length; i++)
        a.add(UserModel.from(_docData[i]));
        });
      return a;
      }



}