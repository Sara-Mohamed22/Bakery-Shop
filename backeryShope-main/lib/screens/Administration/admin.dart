import 'package:flutter/material.dart';
import 'package:mill_10/backend/helper/firestorageHelper.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/screens/Administration/product.dart';
import 'package:mill_10/screens/User/customer_list.dart';
import 'package:mill_10/screens/User/employee_list.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';
import 'accp_Orders.dart';
import 'bakery.dart';
import 'supervisr.dart';
import 'driver.dart';

class Admin extends StatefulWidget {
  const Admin({Key key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  TextEditingController controllerNum = TextEditingController() ;
  var _formkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    AdminProvider  a  =  Provider.of<AdminProvider>(context );

    return Scaffold(
        appBar: AppBar(
          backgroundColor:const Color(0xFF3E2723),
           title:const Text("Admin",
              style: TextStyle(
              color: Color(0xFFFFF3E0),
              ),),
          centerTitle: true,
        ),
        backgroundColor:const Color(0xFF3E2723),
       
        body:  ListView(
            children: <Widget>[
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                   Expanded(
                      child: GestureDetector(
                     child: Container(
                      margin:const EdgeInsets.all(5.0),
                      padding:const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color:const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(15.0)),
                      child:Form(
                        key: _formkey,
                        child: TextFormField(
                          controller: controllerNum ,
                           validator: (value){ value.isEmpty ? 'This Field Required' : null ;},
                           decoration: const InputDecoration(
                                hintText: "divide number is :",
                                ),
                                keyboardType: TextInputType.number,
                          ),
                      ),
                    ),
                  )),
                  ElevatedButton(
                                 onPressed: ()  {
                                   if(_formkey.currentState.validate())
                                     {
                                        print('num===${controllerNum.text}');
                                            a.changeNum(int.tryParse(controllerNum.text) ??0);

                                     }

                                 },
                                 child:const Text(
                                   'Done',
                                   textScaleFactor: 2,
                                   style: TextStyle(
                                     fontSize: 10),
                                 ),
                               style: ElevatedButton.styleFrom(
                                primary: const Color(0xFFFFF3E0),
                                onPrimary: const Color(0xFF3E2723),
                                padding:const EdgeInsets.fromLTRB(15, 5, 15, 5)
                               ),),
                ],
              ),
              

              Row(
                children: <Widget>[
                   Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Employees() ));
                          },
                          child: Container(
                            margin:const EdgeInsets.all(5.0),
                            padding:const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color:const Color(0xFFFFF3E0),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              children:const <Widget>[
                                 Icon(
                                  Icons.person,
                                  size: 80.0,
                                  color: Color(0xFF3E2723),
                                ),
                                 Text(
                                  "Employee",
                                  style: TextStyle(fontSize: 18.0),
                                )
                              ],
                            ),
                          ))),
                 Expanded(
                  child: GestureDetector(
                     onTap: () {
                      AppRouter.router.pushToNewWidget(Customer());
                    },
                     child: Container(
                      margin:const EdgeInsets.all(5.0),
                      padding:const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color:const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(
                        children:const <Widget>[
                           Icon(
                            Icons.person,
                            size: 80.0,
                            color: Color(0xFF3E2723),
                          ),
                           Text(
                            "Customer",
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                   Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>Driver()));
                    },
                    child: Container(
                      margin:const EdgeInsets.all(5.0),
                      padding:const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color:const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(
                        children:const <Widget>[
                           Icon(
                            Icons.drive_eta_rounded,
                            size: 80.0,
                            color: Color(0xFF3E2723),
                          ),
                           Text(
                            "Driver",
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  )),
                   Expanded(
                     child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                         MaterialPageRoute(builder: (context) => const Acceptorder()));
                    },
                      child: Container(
                    margin:const EdgeInsets.all(5.0),
                    padding:const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color:const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children:const <Widget>[
                         Icon(
                          Icons.message,
                          size: 80.0,
                          color: Color(0xFF3E2723),
                        ),
                         Text(
                          "Order",
                          style: TextStyle(fontSize: 18.0),
                       )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                 

                   Expanded(
                     child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Product()));
                    },

                      child: Container(
                       
                    margin:const EdgeInsets.all(5.0),
                    padding:const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color:const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children:const <Widget>[
                         Icon(
                          Icons.fastfood,
                          size: 80.0,
                          color: Color(0xFF3E2723),
                        ),
                         Text(
                          "Product", 
                          style: TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  )),
                  ),

                   Expanded(
                     child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>const Maincalend()));
                    },
                      child: Container(
                    margin:const EdgeInsets.all(5.0),
                    padding:const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color:const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children:const <Widget>[
                         Icon(
                          Icons.message,
                          size: 80.0,
                          color: Color(0xFF3E2723),
                        ), 
                        Text(
                          "Supervisor",
                          style: TextStyle(fontSize: 18.0),
                       )
                        ],
                      ),
                    ),
                  )),
                ],
              ),

              
            ],
          ),
        );
  }
}