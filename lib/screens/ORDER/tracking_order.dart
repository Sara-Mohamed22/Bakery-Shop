// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/model/orderModel.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Tracking extends StatefulWidget {
  const Tracking({Key key}) : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
    Widget getTimeLine()  {
    double heightCon = 180.0;
OrderModel orderModel;
 return StreamBuilder(
  stream: FirebaseFirestore.instance.collection('orders').where('userID',isEqualTo:FirestoreHelper.userId ).snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
      return const Center(
        child: CircularProgressIndicator(),);
    }
    else {
      return (snapshot.data.docs.isEmpty) ? Center(
          child: Text('There are no products to tracking',
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723)))) :
      SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return
              SingleChildScrollView(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.brown, boxShadow: [
                        BoxShadow(
                          color: Colors.yellow,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                          borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.all(30),
                      child: Column(children: [
                        SizedBox(height: 20),
                        Text("Your order ${snapshot.data.docs[index]['productname']}",
                            style: TextStyle(color: Colors.brown[50],
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0)
                        ),
                        SizedBox(height: heightCon,
                            child: TimelineTile(lineXY: 0.2,
                              indicatorStyle: const IndicatorStyle(height: 1.0),
                              alignment: TimelineAlign.manual,
                              endChild: Container(
                                color: snapshot.data.docs[index]['orderType'] ==
                                    "begin"
                                    ? Colors.yellow.withOpacity(0.3)
                                    : Colors.brown,
                                padding: const EdgeInsets.all(10.0),
                                child: Row(children: <Widget>[
                                  Text("Preparing your order",
                                      style: TextStyle(color: Color(0xFFFFF3E0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0)
                                  ),
                                  Icon(
                                    Icons.restaurant, color: Color(0xFFFFF3E0),
                                  )
                                ],),),)),

                        SizedBox(height: heightCon,
                            child: TimelineTile(lineXY: 0.2,
                              indicatorStyle: const IndicatorStyle(height: 1.0),
                              alignment: TimelineAlign.manual,
                              endChild: Container(
                                color: snapshot.data.docs[index]['orderType'] ==
                                    "onPrepaer"
                                    ? Colors.yellow.withOpacity(0.3)
                                    : Colors.brown,
                                padding: const EdgeInsets.all(10.0),
                                child: Row(children: const <Widget>[
                                  Text("Your order is ready",
                                    style: TextStyle(
                                        color: Color(0xFFFFF3E0),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),),
                                  Icon(
                                    Icons.restaurant, color: Color(0xFFFFF3E0),)
                                ],),),)),

                        SizedBox(height: heightCon,
                            child: TimelineTile(
                              lineXY: 0.2,
                              indicatorStyle: const IndicatorStyle(height: 1.0),
                              alignment: TimelineAlign.manual,
                              endChild: Container(
                                color: snapshot.data.docs[index]['orderType'] ==
                                    "onDriven"
                                    ? Colors.yellow.withOpacity(0.3)
                                    : Colors.brown,
                                width: 30,
                                padding: EdgeInsets.all(10.0),
                                child: Row(children: const <Widget>[
                                  Text("Your order is on the way",
                                    style: TextStyle(
                                        color: Color(0xFFFFF3E0),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),),
                                  Icon(
                                    Icons.restaurant,
                                    color: Color(0xFFFFF3E0),
                                  )
                                ],
                                ),),)),
                      ],)));
          },),
      );
    }
  });
}

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.brown[200],
      appBar: AppBar(
        centerTitle: true,
        title:const Text(
          "Tracking Order ",
          style: TextStyle(color: Color(0xFFFFF3E0)),
        ),
        backgroundColor:const  Color(0xFF3E2723),
        leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          color:const Color(0xFFFFF3E0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
        const  Padding(padding: EdgeInsets.only(top: 30.0)),
          const Text(
            "Any problem contact us:",
            style: TextStyle(fontSize: 18.0,color: Colors.brown, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          const Text("+358 10101010",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,)),
          Padding(
            padding:const EdgeInsets.all(15.0),
            child: Divider(
              color: Colors.grey[200],
            ),
          ),

          getTimeLine(),

        ],
      ),
     );
  }
}