// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/model/product.dart';
import 'package:mill_10/model/user.dart';
import 'package:mill_10/screens/Administration/utils.dart';
import 'package:provider/provider.dart';
import 'package:mill_10/backend/provider/eventsProvider.dart';

class DelivaryOrder extends StatelessWidget {
  const DelivaryOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // List<String> ee =[];

    return Scaffold(
      backgroundColor: const Color(0xFF3E2723),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 25.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Row(
              children: const <Widget>[
                Text(
                  'Orders Delivered ',
                  style: TextStyle(color: Color(0xFFFFF3E0), fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF3E0),
            ),
            child: ListView(
              primary: false,
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height - 300,
                      child: StreamBuilder(
                         // stream: FirebaseFirestore.instance.collection('orders').where("status", isEqualTo: orderStatus.delivered.name).snapshots(),
                          stream: FirebaseFirestore.instance.collection('orders').where("status", isEqualTo: orderStatus.complete.name).snapshots(),

                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: const CircularProgressIndicator(
                                color: Colors.black87,
                              ));
                            } else {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    FirestoreHelper.userId = snapshot.data.docs[index]['userID'];

                                    print('idorder:: ${snapshot.data.docs[index]['orderId']}');

                                    return _bulidFoodItem(context,
                                        foodName: snapshot.data.docs[index]['productname'],
                                        count: snapshot.data.docs[index]['quantity'],
                                        dateDelivered: snapshot.data.docs[index]['dateDelivered'] != null
                                            ? DateTime.parse(snapshot.data.docs[index]['dateDelivered'])
                                            : null,
                                        delete: () =>
                                            FirebaseFirestore.instance.collection("orders").doc(snapshot.data.docs[index].id).delete(),
                                        show: Map<String,dynamic>.from(snapshot.data.docs[index].data())['isReceived'] ?? false);
                                  });
                            }
                          })),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bulidFoodItem(context, {String foodName, String count, Function delete, bool show, DateTime dateDelivered}) {
    /*   var v = Utils.getTimeDifference(Utils.toTime(Provider
          .of<EventsProvider>(context, listen: false)
          .toDate)
          , Utils.toTime(Provider
              .of<EventsProvider>(context, listen: false)
              .fromDate)).split('.')[0];
      print('v ** ${v}'); */

    // var v = Provider.of<AdminProvider>(context, listen: false).driveTime;

    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
        child:
            //   v!=null?
            Container(
          width: 350,
          decoration: BoxDecoration(color: Colors.yellow.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
          child: Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(width: 10.0),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text(
                    foodName,
                    style: const TextStyle(fontFamily: 'Montserrat', fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SafeArea(
                    child: FutureBuilder<UserModel>(
                        future: FirestoreHelper.firestoreHelper.getUser(FirestoreHelper.userId),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            print(" user driver id is ${FirestoreHelper.userId}");
                            return const Center(
                              child: Text('loading'),
                            );
                          } else {
                            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.person),
                                  Text(
                                    snapshot.data.name,
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.phone),
                                  Text(
                                    snapshot.data.phone,
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  Text(
                                    snapshot.data.address,
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.shopping_cart_rounded),
                                  Text(
                                    "Quantity: ${count}",
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.shopping_cart_rounded),
                                  Text(
                                    //  "Delivery time: 4:55",

                                    "Delivery time: " +
                                        (dateDelivered == null ? 'unknown' : DateFormat('MM-dd ??? kk:mm').format(dateDelivered)),
                                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14.0),
                                  ),
                                ],
                              ),
                              Row(
                                //  mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(width: 30),
                                  Row(
                                    children: [
                                      Text("Delivered ", style: TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold)),
                                      Icon(Icons.done, color: Colors.green)
                                    ],
                                  ),

                                  SizedBox(
                                    width: 20,
                                  ),

                                  //        Provider.of<CustomProvider>(context).recieve == snapshot.data.docs[index]['productname'] ?
                                  show == true
                                      ? Row(
                                          children: [
                                            Text("Received ", style: TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold)),
                                            Icon(
                                              Icons.done,
                                              color: Colors.green,
                                            )
                                          ],
                                        )
                                      : Container(
                                          width: 60,
                                        )
                                ],
                              )
                            ]);
                          }
                        }),
                  ),
                ]),
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 95), child: IconButton(onPressed: delete, icon: Icon(Icons.delete), color: Colors.red)),
                    SizedBox(
                      height: 20,
                    ),

                    /* Center(
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),

                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              // SizedBox(width: 20,),
                              Text("Delivered ",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.green,fontWeight: FontWeight.bold
                                  )),Icon(Icons.done,color: Colors.green,),

                              Text("Received ",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.green,fontWeight: FontWeight.bold
                                  )),Icon(Icons.done,color: Colors.green,)
                                  ],
                          )
                      ),
                    )*/
                  ],
                )
              ]),
        )
        //    : Container(height: 100,),
        );
  }
}
