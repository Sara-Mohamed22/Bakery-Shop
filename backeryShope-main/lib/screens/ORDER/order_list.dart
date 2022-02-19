import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/model/constantsName.dart';
import 'package:mill_10/model/orderModel.dart';
import 'package:mill_10/model/user.dart';
import 'package:provider/provider.dart';
import 'drawer.dart';
import 'make_order.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final GlobalKey<ScaffoldState> _keydrawer = GlobalKey<ScaffoldState>();
  String note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keydrawer,
      endDrawer: NavigationDrawer(context),
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
                  'Order List ',
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
              padding: const EdgeInsets.only(left: 2.0, right: 2),
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('orders').where('status', isEqualTo: orderStatus.begin.name).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Colors.black87,
                            ));
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  FirestoreHelper.userId = snapshot.data.docs[index]['userID'];

                                  return Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
                                      child: Container(
                                          width: 400,
                                          decoration:
                                              BoxDecoration(color: Colors.yellow[50], borderRadius: BorderRadius.circular(15.0), boxShadow: const [
                                            BoxShadow(
                                              color: Colors.white30,
                                              blurRadius: 20,
                                              offset: Offset(5, 4),
                                            )
                                          ]),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image(
                                                  image: NetworkImage(snapshot.data.docs[index]['image']),
                                                  fit: BoxFit.fill,
                                                  height: 90.0,
                                                  width: 90.0),

                                              // ),
                                              const SizedBox(width: 10.0),
                                              Flexible(
                                                flex: 2,
                                                child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Icon(Icons.badge),
                                                          Text(
                                                            snapshot.data?.docs[index]['productname'] ?? 'none',
                                                            style: const TextStyle(
                                                                fontFamily: 'Montserrat',
                                                                fontSize: 18.0,
                                                                color: Color(0xFF3E2723),
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.shopping_cart_rounded),
                                                          Text(
                                                            "Quantity: ${snapshot.data.docs[index]['quantity']}",
                                                            style: const TextStyle(
                                                              fontFamily: 'Montserrat',
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SafeArea(
                                                        child: FutureBuilder<UserModel>(
                                                            future: FirestoreHelper.firestoreHelper.getUser(FirestoreHelper.userId),
                                                            builder: (context, snapshot) {
                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                return const Center(child: CircularProgressIndicator());
                                                              } else {
                                                                if (snapshot.hasError) {
                                                                  return const Center(child: Text('something went wrong'));
                                                                } else {
                                                                  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Icon(Icons.person),
                                                                        Expanded(
                                                                          child: Text(
                                                                            snapshot.data?.name ?? 'loading...',
                                                                            style: const TextStyle(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 14.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),

                                                                    Row(
                                                                      children: [
                                                                        Icon(Icons.phone),
                                                                        Expanded(
                                                                          child: Text(
                                                                            snapshot.data?.phone ?? 'loading...',
                                                                            //  snapshot.data.phone,
                                                                            style: const TextStyle(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 14.0,
                                                                              // fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),

                                                                    Row(
                                                                      children: [
                                                                        Icon(Icons.location_on),
                                                                        Expanded(
                                                                            child: Text(
                                                                          //  snapshot.data.address,
                                                                          snapshot.data?.address ?? 'loading...',
                                                                          style: const TextStyle(
                                                                            fontFamily: 'Montserrat',
                                                                            fontSize: 14.0,
                                                                          ),
                                                                        )),
                                                                      ],
                                                                    ),
                                                                    // ),
                                                                  ]);
                                                                }
                                                              }
                                                            }),
                                                      ),
                                                      Row(
                                                        children: const [
                                                          Icon(Icons.note, size: 20),
                                                          // (snapshot.data.docs[index]['description']!=null)?
                                                          Text(
                                                            " Notes:",
                                                            maxLines: 3,
                                                            style: TextStyle(fontFamily: 'Montserrat', fontSize: 14.0),
                                                          )
                                                          // :
                                                          // Text(" no notes")
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 380,
                                                        child: Wrap(children: <Widget>[
                                                          Text(
                                                            "${snapshot.data.docs[index]['description']}",
                                                            maxLines: 5,
                                                            softWrap: true,
                                                            overflow: TextOverflow.visible,
                                                            style: const TextStyle(
                                                              fontFamily: 'Montserrat',
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                        ]),
                                                      )
                                                    ]),
                                              ),
                                              // SizedBox(width: 10,),
                                              IconButton(
                                                onPressed: () async {
                                                  await FirestoreHelper.firestoreHelper
                                                      .changeOrderState(orderStatus.confirmed, snapshot.data.docs[index].id);
                                                 // .changeOrderState(orderStatus.preparing, snapshot.data.docs[index].id);

                                                  //  setState(() {});
                                                },
                                                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 17),
                                              ),
                                            ],
                                          )));
                                });
                          }
                        })),
              ],
            ),
          )
        ],
      ),
    );
  }
}
