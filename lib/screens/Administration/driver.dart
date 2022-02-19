// ignore_for_file: missing_return, avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/model/orderModel.dart';
import 'package:mill_10/model/product.dart';
import 'package:mill_10/model/user.dart';
import 'package:mill_10/screens/Administration/admin.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';





class Driver extends StatefulWidget {


  @override
  _DriverState createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  var result;
  String typeSelected;
  OrderModel selected;
  ProductModel count;
  String note;
  var selectedDoc;

  ProductModel selectedProduct = ProductModel();


  @override
  void initState() {
    Provider.of<AdminProvider>(context, listen: false).getCategories();
    super.initState();
  }

  Widget _buildCustomerType(String title, {Function onChanged}) {
    return InkWell(

        child:
        Container(

          height: 100,
          width: 110,
          decoration: BoxDecoration(
            color: typeSelected == title ? Colors.green : const Color(
                0xFF3E2723),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFFFFF3E0),
              ),
            ),
          ),
        ),
        onTap: onChanged


    );
  }



  OrderModel model;
  String quantity;
  String userIDD;
  static String orderId = '';

  // Future getCount({String group}) async =>
  //     FirebaseFirestore.instance.collection('users').where('group',isEqualTo: group).get()
  //     .then((value) {
  //   var count = 0;
  //   count = value.docs.length;
  //
  //   return count;
  // });


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProvider>(context, listen: false);
    final auth = Provider.of<UserProvider>(context, listen: false);

    return SafeArea(child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: const Color(0xFF3E2723),
          title: const Text(
            "Driver",
            style: TextStyle(
              color: Color(0xFFFFF3E0),
            ),
          ),
          leading: IconButton(
            color: const Color(0xFFFFF3E0),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AppRouter.router.popPage();
            },
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    children: [
                      Selector<AdminProvider, int>(
                          builder: (context, value, widget) {
                            return Row(children: [Expanded(
                              child: Container(margin: EdgeInsets.all(10),
                                width: 40, decoration: BoxDecoration(
                                    color: Colors.brown.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(
                                        50))
                                , child: RadioListTile(
                                    title: Text('A', style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),),
                                    value: 0,
                                    groupValue: value,
                                    onChanged: (v) {
                                      setState(() {
                                        provider.toggleGroup(v);
                                        provider.group = value;
                                        provider.gruopName = 'A';
                                      });
                                      print('A is ${value}');
                                    }),
                              ),
                            ),
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(10), width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.brown.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(50))
                                    , child: RadioListTile(
                                      title: Text('B'),
                                      value: 1,
                                      groupValue: value,
                                      onChanged: (v) {
                                        setState(() {
                                          provider.toggleGroup(v);
                                          provider.group = value;
                                          provider.gruopName = 'B';
                                        });

                                        print('B is ${value}');
                                      }),
                                  )),
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(10), width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.brown.withOpacity(
                                            0.4),
                                        borderRadius: BorderRadius.circular(
                                            50))
                                    , child: RadioListTile(
                                      title: Text('C'),
                                      value: 2,
                                      groupValue: value,
                                      onChanged: (v) {
                                        setState(() {
                                          provider.toggleGroup(v);
                                          provider.group = value;
                                          provider.gruopName = 'C';
                                        });

                                        print("C ${provider.group}");
                                      }),
                                  )),
                            ],);
                          }, selector: (context, provider) {
                        return provider.typeGroup;
                      }),

                  //
                  // StreamBuilder(
                  //    stream: FirebaseFirestore.instance.collection('orders')
                  //           .where('orderType', isEqualTo: "onDriven")
                  //            .snapshots(),
                  //           builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  //      return
                  //        Container(
                  //         child:
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('orders')
                                    .where('orderType', isEqualTo: "onDriven")
                                    .where('groupName', isEqualTo: provider.gruopName)
                                    .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),);
                                }
                                else {
                                  return (snapshot.data.docs.isEmpty) ? Center(
                                      child: Text(
                                          'There are no products to deliver',
                                          style: TextStyle(fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF3E2723))))
                                 : SingleChildScrollView(
                                      child: ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (context, index) {
                                          orderId = snapshot.data.docs[index]['userID'];
                                        return Container(
                                              padding: const EdgeInsets.all(10),
                                              width: 350,
                                              margin: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color(0xFF3E2723),
                                                    width: 2,),
                                                  borderRadius: BorderRadius.circular(12)
                                              ),
                                              child:
                                              Container(
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text('Order Details:',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.red)),
                                                      Text(
                                                          ' product name: ${snapshot.data.docs[index]["productname"]}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color(0xFF3E2723))),

                                                      Text(' Quantity: ${snapshot.data.docs[index]["quantity"]}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color(0xFF3E2723))),
                                                      Row(children: [
                                                        (snapshot.data.docs[index]["description"] != null) ?
                                                        Expanded(
                                                          child: Text(
                                                            " Notes: ${ snapshot.data.docs[index]["description"]}",
                                                            style: const TextStyle(
                                                              fontFamily: 'Montserrat',
                                                              fontSize: 14.0,fontWeight: FontWeight.bold,),),
                                                        ) : Text(' no note find')
                                                      ],),


                                                      Container(child:
                                                      StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('users')
                                                              // .where('groupName', isEqualTo:provider.gruopName)
                                                              .where('userid', isEqualTo: snapshot.data.docs[index]["userID"]).snapshots(),
                                                          builder: (context,
                                                              AsyncSnapshot<
                                                                  QuerySnapshot> snapshot) {
                                                            print(
                                                                "fffffffffffffff ${provider.gruopName}");
                                                            if (!snapshot.hasData) {
                                                              return CircularProgressIndicator();
                                                            }
                                                            else {
                                                              print(
                                                                  "orderid ....${orderId}");
                                                              return (snapshot.data.docs.isEmpty)
                                                                  ? Center(
                                                                   child: Text('\There are no products to deliver',
                                                                      style: TextStyle(
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Color(
                                                                              0xFF3E2723))))
                                                           : ListView
                                                                  .builder(
                                                                  physics: NeverScrollableScrollPhysics(),
                                                                  shrinkWrap: true,
                                                                  scrollDirection: Axis
                                                                      .vertical,
                                                                  itemCount: snapshot
                                                                      .data.docs
                                                                      .length,
                                                                  itemBuilder: (
                                                                      context,
                                                                      index) {
                                                                    return
                                                                      Column(
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .start,
                                                                          children: [

                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .all(
                                                                                  3.0),
                                                                              child: Text(
                                                                                  'Customer Details:',
                                                                                  style: TextStyle(
                                                                                      fontSize: 18,
                                                                                      fontWeight: FontWeight
                                                                                          .bold,
                                                                                      color: Colors
                                                                                          .red)),
                                                                            ), Row(
                                                                              children: [
                                                                                Icon(
                                                                                    Icons
                                                                                        .person),
                                                                                Text(
                                                                                  snapshot
                                                                                      .data
                                                                                      .docs[index]['name'],
                                                                                  style: const TextStyle(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 14.0,
                                                                                    // fontWeight: FontWeight.bold

                                                                                  ),
                                                                                ),
                                                                              ],),
                                                                            Row(
                                                                              children: [
                                                                                Icon(
                                                                                    Icons
                                                                                        .phone),
                                                                                Text(
                                                                                  snapshot
                                                                                      .data
                                                                                      .docs[index]['phone'],
                                                                                  style: const TextStyle(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 14.0,
                                                                                    // fontWeight: FontWeight.bold

                                                                                  ),
                                                                                ),
                                                                              ],),
                                                                            Row(
                                                                              children: [
                                                                                Icon(
                                                                                    Icons
                                                                                        .location_on),
                                                                                Text(
                                                                                  snapshot
                                                                                      .data
                                                                                      .docs[index]['address'],
                                                                                  style: const TextStyle(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 14.0,
                                                                                    // fontWeight: FontWeight.bold

                                                                                  ),
                                                                                ),
                                                                              ],),
                                                                          ]);
                                                                  });
                                                            }
                                                          })),

                                                      SizedBox(height: 20,),


                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Container(
                                                            height: 40, width: 100,
                                                            child: ElevatedButton(
                                                              onPressed: /*shouldEnable ? null :*/() {
                                                                DriverModel model = DriverModel(
                                                                  productname: snapshot.data.docs[index]['productname'],
                                                                  quantity: snapshot.data.docs[index]['quantity'],
                                                                  group: provider.typeGroup.toString(),
                                                                  isFinished: false,
                                                                );
                                                                Provider.of<AdminProvider>(
                                                               context, listen: false).startDriver(model,snapshot.data.docs[index]["userID"],snapshot.data.docs[index]['orderId']
                                                                    ,           snapshot.data.docs[index]['description'] );
                                                                // setState(() {
                                                                // shouldEnable = true;
                                                              },

                                                              child: const Text(
                                                                'Start',
                                                                style: TextStyle(
                                                                    fontSize: 12),),
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                  primary: const Color(
                                                                      0xFF3E2723),
                                                                  onPrimary: const Color(
                                                                      0xFFFFF3E0),
                                                                  padding: const EdgeInsets
                                                                      .all(10)
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10),
                                                          Container(
                                                            height: 40, width: 100,
                                                            child: ElevatedButton(
                                                              onPressed: () {
                                                                // setState(() {
                                                                //   shouldEnable = false;
                                                                // // });
                                                                DriverModel model = DriverModel(
                                                                  productname: snapshot.data.docs[index]['productname'],
                                                                  quantity:snapshot.data.docs[index]['quantity'],
                                                                  group: provider.typeGroup.toString(),
                                                                  isFinished: true,
                                                                );
                                                                Provider.of<AdminProvider>(context, listen: false).stopDriver(model,snapshot.data.docs[index]['orderId']);
                                                                },
                                                              child: const Text(
                                                                'Stop',
                                                                style: TextStyle(
                                                                    fontSize: 12),),
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                  primary: const Color(
                                                                      0xFF3E2723),
                                                                  onPrimary: const Color(
                                                                      0xFFFFF3E0),
                                                                  padding: const EdgeInsets
                                                                      .all(10)
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      //button
                                                    ]),
                                              ),);
                                          }));
                                }
                              }),


                        // );}),

                    ])))));
  }


}
                      

                     
                         

                      
                                    
                     
                      
                      
                    
                     
                     
                      
                      
                     
                     
