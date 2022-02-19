import 'package:flutter/material.dart';
import 'package:mill_10/screens/Administration/product.dart';
import 'package:mill_10/screens/User/customer_list.dart';
import 'package:mill_10/screens/User/employee_list.dart';
import 'package:mill_10/utilities/router.dart';
import 'accp_Orders.dart';
import 'supervisr.dart';
import 'driver.dart';

class Admin extends StatefulWidget {
  const Admin({Key key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
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