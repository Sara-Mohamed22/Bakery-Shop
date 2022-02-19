
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/model/user.dart';
import 'package:mill_10/service/user.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';

class EditCustomerDetail extends StatefulWidget {
  final  String userId;
   EditCustomerDetail({Key key,this.userId}) : super(key: key);

  @override
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<EditCustomerDetail> {

  bool isLoading = false;
  User user;int value;
  String _typeSelected = '';
  UserServices  selectedGroup;

  Widget _buildCustomerType({String title, Function press}) {
    return InkWell(
        child: Container(
            height: 40,
            width: 90,
            decoration: BoxDecoration(
              color: _typeSelected== title ? Colors.green : const Color(0xFF3E2723),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                title,
                style:  TextStyle(
                  fontSize: 18,
                  color: Color(0xFFFFF3E0),

                ),
              ),
            )),
        onTap:press
    );
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<UserProvider>(context,listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor:const Color(0xFF3E2723),
          title: const Text(
            "Edit Customer Details ",
            style: TextStyle(
              color: Color(0xFFFFF3E0),
            ),
          ),
          leading: IconButton(
            color:const Color(0xFFFFF3E0),
            icon:const Icon(Icons.arrow_back),
            onPressed: () {
              AppRouter.router.popPage();
            },
          ),
          centerTitle: true,
        ),


        body:  SingleChildScrollView(
          child: SafeArea(
            child:
            FutureBuilder<UserModel>(
                 future: provider.getUser(widget.userId),
                  builder: (context,snapshot) {
                   print("lllll${widget.userId}");


             return
                  Container(
                        margin:EdgeInsets.all(15),
                        child: Form(key:provider.scaffoldKey,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller:provider.name,
                                decoration: InputDecoration(
                                    labelText: "Customer Name :",
                                    prefixIcon:const Icon(
                                      Icons.account_circle,
                                      color: Color(0xFF3E2723),
                                      size: 30,
                                    ),
                                    contentPadding:const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                              ),

                              const SizedBox(height: 15),
                              TextFormField(
                               controller: provider.phone,
                                decoration: InputDecoration(
                                    labelText: "Phone number :",
                                    prefixIcon:const Icon(
                                      Icons.phone_iphone,
                                      color: Color(0xFF3E2723),
                                      size: 30,
                                    ),
                                    contentPadding:const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                               controller: provider.description,
                                decoration: InputDecoration(
                                    labelText: "Description :",
                                    prefixIcon:const Icon(
                                      Icons.description,
                                      color: Color(0xFF3E2723),
                                      size: 30,
                                    ),
                                    contentPadding:const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                               validator:(value)=>provider.emailValidation(value),
                               controller: provider.email,
                                decoration: InputDecoration(
                                    labelText: "Email :",
                                    prefixIcon:const Icon(
                                      Icons.email,
                                      color: Color(0xFF3E2723),
                                      size: 30,
                                    ),
                                    contentPadding:const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                validator: (v)=>(v.isEmpty)?"Enter Required Field":null,
                              controller:provider.password,
                                decoration: InputDecoration(
                                    labelText: "Password :",
                                    prefixIcon:const Icon(
                                      Icons.padding,
                                      color: Color(0xFF3E2723),
                                      size: 30,
                                    ),
                                    contentPadding:const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                               controller: provider.address,
                                decoration: InputDecoration(
                                    labelText: "Address :",
                                    prefixIcon:const Icon(
                                      Icons.store,
                                      color: Color(0xFF3E2723),
                                      size: 30,
                                    ),
                                    contentPadding:const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                               controller: provider.ytunus,
                                decoration: InputDecoration(
                                    labelText: "Y-tunus :",
                                    prefixIcon:const Icon(
                                      Icons.fact_check,
                                      color: Color(0xFF3E2723),
                                      size: 30,
                                    ),
                                    contentPadding:const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // SizedBox(
                              //   height: 40,
                              //   child: ListView(
                              //     scrollDirection: Axis.horizontal,
                              //     children: [
                              // _buildCustomerType(
                              // title: 'Group A', press:() {
                              //   setState(() {
                              //     _typeSelected=provider.group.text;
                              //   });
                              // }),
                              Selector<UserProvider, int>(builder: (context, value, widget) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child:
                                      RadioListTile(
                                          title: Text('A'),
                                          value: 0,
                                          groupValue:value ,
                                          onChanged: (v) {
                                             provider.toggleGroup(v);
                                          }),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                          title: Text('B'),
                                          value: 1,
                                          groupValue:value ,
                                          onChanged: (v) {
                                             provider.toggleGroup(v);
                                          }),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                          title: Text('C'),
                                          value: 2,
                                          groupValue:value ,
                                          onChanged: (v) {
                                            provider.toggleGroup(v);
                                          }),
                                    )
                                  ],
                                );
                              }, selector: (context, provider) {
                                return provider.typeGroup;
                              }),


                              // const  SizedBox(width: 10),
                              //   _buildCustomerType(title:'Group B',press:() {
                              //  setState(() {
                              //     _typeSelected=provider.group.text;
                              //       });
                              //   }),
                              //  const SizedBox(width: 10),
                              //   _buildCustomerType(title:'Group C',press:() {
                              //  setState(() {
                              //
                              //      _typeSelected=provider.group.text;
                              //  });
                              // }),
                              //     ],
                              //   ),
                              // ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Container(
                                  height: 50,
                                  padding:const EdgeInsets.symmetric(horizontal: 10),
                                  child: ElevatedButton(
                                    onPressed: ()  {
                                     provider.updateUserData(userID:widget.userId);
                                    },
                                    child:const Text(
                                      'Update Customer Details',
                                      textScaleFactor: 2,
                                      style: TextStyle(
                                          fontSize: 10),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xFF3E2723),
                                        onPrimary: const Color(0xFFFFF3E0),
                                        padding:const EdgeInsets.fromLTRB(15, 5, 15, 5)
                                    ),),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ;}
  // }
  ),
          ),
        ));
  }
}
