// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/model/product.dart';
import 'package:provider/provider.dart';

class MessageList extends StatefulWidget {
  MessageList({this.firestore});

  final FirebaseFirestore firestore;

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  // ignore: unused_field
  var _mySelection;
bool dropDown;
var _category;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProvider>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('product').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(
            child: const CircularProgressIndicator(),
          );
          var length = snapshot.data.docs.length;
          DocumentSnapshot ds = snapshot.data.docs[length - 1];
        var  _queryCat = snapshot.data.docs;
          return Container(

                    child:  InputDecorator(
                      decoration: const InputDecoration(
                        //labelText: 'Activity',
                        hintText: 'Choose an Product',
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      isEmpty: _category == null,
                      child:DropdownButtonHideUnderline(
                        child: DropdownButton(
                        value: _category,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            _category = newValue;
                            dropDown = false;
                            print(_category);

                          });
                          provider.dropdownValue=_category;
                         //  print(newValue.productname);
                         // dropdownValue = newValue.productname;
                         // provider.idProduct =snapshot.data.docs[''];
                        },
                        items: snapshot.data.docs.map((DocumentSnapshot document) {
                          ProductModel model = ProductModel.toMap(document);
                          provider.idProduct =model.idproduct;
                          // provider.dropdownValue=model.productname;
                          return new DropdownMenuItem<String>(
                              value: model.productname,
                              child: new Container(
                                decoration: new BoxDecoration(

                                    borderRadius: new BorderRadius.circular(5.0)
                                ),
                                height: 100.0,
                                padding: EdgeInsets.fromLTRB(
                                    10.0, 2.0, 10.0, 0.0),
                                //color: primaryColor,
                                child: new Text(
                                    model.productname),
                              )
                          );
                        }).toList(),
                      ),
                    ),
                  ));


        }
    );
  }}