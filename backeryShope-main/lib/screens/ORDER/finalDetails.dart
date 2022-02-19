//
//
// // ignore_for_file: prefer_typing_uninitialized_variables, file_names
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mill_10/backend/provider/adminProvider.dart';
// import 'package:mill_10/model/orderModel.dart';
// import 'package:mill_10/model/adminProvider.dart';
// import 'package:provider/provider.dart';
//
// class FinalDetailsOrder extends StatefulWidget {
// FinalDetailsOrder({Key key}) : super(key: key);
//
//   @override
//   _DetailsOrderState createState() => _DetailsOrderState();
// }
//
//
//
// class _DetailsOrderState extends State<FinalDetailsOrder>{
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<AdminProvider>(context, listen: false);
//
//     return Scaffold(
//         backgroundColor: const Color(0xFF3E2723),
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             color: const Color(0xFFFFF3E0),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           title: const Text('Final Details Order',
//             style: TextStyle(
//               fontSize: 18.0,
//               color: Color(0xFFFFF3E0),
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: StreamBuilder(
//             stream:( FirebaseFirestore.instance.collection('orders').doc(provider.doceId)
//                 .collection('preparbingOrder').doc(provider.preparID.id).snapshots());
//             builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: const CircularProgressIndicator(
//                   color: Colors.black87,));
//               } else {
//                 return ListView.builder(
//                   itemCount: snapshot.data.docs.length,
//                    itemBuilder: (context, index) {
//                     return
//                      Stack(
//                        children: <Widget>[
//                          Container(
//                            height: MediaQuery
//                                .of(context)
//                                .size
//                                .height - 82,
//                            width: MediaQuery
//                                .of(context)
//                                .size
//                                .width,
//                            color: Colors.transparent,
//                          ),
//                          Positioned(
//                              top: 75.0,
//                              child: Container(
//                                decoration: const BoxDecoration(
//                                  borderRadius: BorderRadius.only(
//                                      topLeft: Radius.circular(45.0),
//                                      topRight: Radius.circular(45.0)
//                                  ),
//                                  color: Color(0xFFFFF3E0),
//                                ),
//                                height: MediaQuery
//                                    .of(context)
//                                    .size
//                                    .height - 100,
//                                width: MediaQuery
//                                    .of(context)
//                                    .size
//                                    .width,
//                              )
//                          ),
//                          Positioned(
//                            top: 30,
//                            left: (MediaQuery
//                                .of(context)
//                                .size
//                                .width / 2) - 100,
//                            child:
//                            Container(child: Image(
//                                image: NetworkImage(snapshot.data.docs[index]['image']),
//                                fit: BoxFit.fill,
//                                height: 90.0,
//                                width: 90.0),
//                              //
//                              // height: 200,
//                              // width: 200,
//                            )
//                          ),
//                          Positioned(
//                            top: 250,
//                            left: 25,
//                            right: 25,
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Text(snapshot.data.docs[index]['productname'],
//                                  style: const TextStyle(
//                                      color: Color(0xFF3E2723),
//                                      fontFamily: 'Montserrat',
//                                      fontSize: 18,
//                                      fontWeight: FontWeight.bold
//                                  ),
//                                ),
//                                const SizedBox(height: 20,),
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment
//                                      .spaceBetween,
//                                  children: <Widget>[
//                                    Container(
//                                      width: 125,
//                                      height: 40,
//
//                                      child:
//                                      Text(
//                                        "Quantity: ${snapshot.data.docs[index]['quantity']}",
//                                        style: const TextStyle(
//                                            color: Color(0xFF3E2723),
//                                            fontFamily: 'Montserrat',
//                                            fontSize: 15,
//                                            fontWeight: FontWeight.bold
//                                        ),
//                                      ),
//                                    )
//                                  ],
//                                ),
//                                const SizedBox(height: 10,),
//                                const Text("Notes", style: TextStyle(
//                                    color: Color(0xFF3E2723),
//                                    fontFamily: 'Montserrat',
//                                    fontSize: 15, fontWeight: FontWeight.bold
//                                ),),
//                                const SizedBox(height: 10,),
//                                SizedBox(
//                                    height: 100,
//                                    child: Wrap(
//                                        children: [ Container(width: 350,
//                                            decoration: BoxDecoration(
//                                                color: Colors.white54,
//                                                borderRadius: BorderRadius
//                                                    .circular(10)),
//                                            child: Text(
//                                              "snapshot.data.docs['description']",
//                                              style: const TextStyle(
//                                                  color: Color(0xFF3E2723),
//                                                  fontFamily: 'Montserrat',
//                                                  fontSize: 15,
//                                                  fontWeight: FontWeight.bold
//                                              ),)),
//                                        ])
//
//
//                                ),
//
//
//                                Center(
//                                  child: SizedBox(
//                                    height: 50,
//                                    child: ElevatedButton(
//                                      onPressed: () {
//                                        // ProductModel order = ProductModel(
//                                        //     productname: widget.foodName,
//                                        //     image: widget.heroTag,
//                                        //     quantity: quantity.toString(),
//                                        //     description: note);
//                                        // Provider.of<AdminProvider>(context, listen: false).makeOrder(order);
//                                      },
//                                      child: const Text(
//                                        'Deliver Order',
//                                        textScaleFactor: 2,
//                                        style: TextStyle(
//                                            fontSize: 15),
//                                      ),
//                                      style: ElevatedButton.styleFrom(
//                                          primary: const Color(0xFF3E2723),
//                                          onPrimary: const Color(0xFFFFF3E0),
//                                          padding: const EdgeInsets.fromLTRB(
//                                              15, 5, 15, 5)
//                                      ),),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          )
//                        ],
//                      );
//                    }
//                 );
//               }
//             }));
//   }}