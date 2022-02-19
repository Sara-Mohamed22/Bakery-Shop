
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/model/constantsName.dart';
import 'package:mill_10/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {

  Future<void> createProduct({
    @required String productname,

    @required String image,
  }) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString("id");
      DocumentReference reff=firebaseFiretore.collection(ConstantProduct.COLLECTION).doc();
      reff.set({
        "${ConstantProduct.PRODUCTNAME}": productname,
        "${ConstantProduct.IDPRODUCT}": reff.id,
        "${ConstantProduct.IMAGE}": image,
      });
    }catch(e){
      print("exception create Product file=> services productservice :$e");
    }
  }
  void editProduct({
    @required String idproduct,
    @required String productname,

    @required String image,

  }) {
    try{
      firebaseFiretore.collection(ConstantProduct.COLLECTION).doc(idproduct).update(
          {
            "${ConstantProduct.PRODUCTNAME}": productname,
            "${ConstantProduct.IMAGE}": image,
          }
      );
    }catch(e){
      print("exception edit Product file=> services productservice :$e");

    }
  }
  removeproduct(String idProduct){
    firebaseFiretore.collection(ConstantProduct.COLLECTION).doc(idProduct).delete();
  }
  Future<List<ProductModel>> getProductbyid(idprof) async{
    try{
      List<ProductModel> a = [];
      await  firebaseFiretore.collection(ConstantProduct.COLLECTION).
      where(ConstantProduct.IDPROF,isEqualTo: idprof).get().then((doc) {
        final _docData = doc.docs.map((doc) => doc.data()).toList();
        for (int i = 0; i < _docData.length; i++){
          a.add(ProductModel.fromlist(_docData[i]));
        }
      });
      return a;
    }catch(e){
      print("exception get Product by id file=> services productservice :$e");
      return [];
    }

  }

  Future<List<ProductModel>> getProduct() async{
    try{
      List<ProductModel> a = [];
      await  firebaseFiretore.collection(ConstantProduct.COLLECTION).get().then((doc) {
        final _docData = doc.docs.map((doc) => doc.data()).toList();
        for (int i = 0; i < _docData.length; i++)
        {
          a.add(ProductModel.fromlist(_docData[i]));
        }
      });
      return a;
    }catch(e){
      print("exception get Product file=> services productservice :$e");
      return [];
    }
  }

}
