// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/model/constantsName.dart';
import 'package:mill_10/model/user.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';
import 'drawer.dart';
import 'make_order.dart';

class CustomerOrderPage extends StatefulWidget {
  final String userId;

  const CustomerOrderPage({Key key, this.userId}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<CustomerOrderPage> {
  final GlobalKey<ScaffoldState> _keydrawer = GlobalKey<ScaffoldState>();
  String note;
  String user;
  UserProvider u ;

  Future<void> markAsReceived(String orderId) async {
    await FirestoreHelper.firestoreHelper.receivedOrder(true, orderId);
  }




  @override
  Widget build(BuildContext context) {

    u =Provider.of<UserProvider>(context);
    u.currentUser.uid ;

    return Scaffold(
      key: _keydrawer,
      endDrawer: NavigationDrawer(context),
      backgroundColor: const Color(0xFF3E2723),
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () => AppRouter.router.popPage(),
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF3E2723),
        title: const Text(
          'Orders',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 25.0,
            color: Color(0xFFFFF3E0),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 25.0),
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
            decoration: const BoxDecoration(color: Color(0xFFFFF3E0), borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0))),
            child: ListView(
              primary: false,
              padding: const EdgeInsets.only(left: 2.0, right: 2),
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('orders')
                        //    .where('userID', isEqualTo: FirestoreHelper.userId)

                            .where('userID', isEqualTo:  u.currentUser.uid )
                            .where('isReceived', isEqualTo: false)
                            // .where('status', isEqualTo: orderStatus.begin.name)
                            .snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Colors.black87,
                            ));
                          } else {
                            return (snapshot.data.docs.isEmpty)
                                ? Center(
                                    child: Text('There are no orders',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF3E2723))),
                                  )
                                : SingleChildScrollView(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder: (context, index) {
                                          FirestoreHelper.userId = snapshot.data.docs[index]['userID'];
                                          user = snapshot.data?.docs[index]['userID'];
                                          //  print('**${snapshot.data.docs[index]['productname']}');
                                          return Padding(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
                                              child: Container(
                                                  width: 400,
                                                  decoration:
                                                      BoxDecoration(color: Colors.yellow[50], borderRadius: BorderRadius.circular(15.0), boxShadow: [
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

                                                      // const  SizedBox(width: 10.0,),
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
                                                                    snapshot.data.docs[index]['productname'],
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
                                                                        return Center(child: CircularProgressIndicator());
                                                                      } else {
                                                                        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                          Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Icon(Icons.person),
                                                                              Expanded(
                                                                                child: Text(
                                                                                  // snapshot.data.name,
                                                                                  snapshot.data?.name != null ? snapshot.data.name : 'loading...',
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
                                                                                  //  snapshot.data.phone,
                                                                                  snapshot.data?.phone != null ? snapshot.data.phone : 'loading...',
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
                                                                                snapshot.data?.address != null ? snapshot.data.address : 'loading...',
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
                                                                    }),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.note,
                                                                    size: 20,
                                                                  ),
                                                                  // (snapshot.data.docs[index]['description']!=null)?
                                                                  Text(
                                                                    " Notes:",
                                                                    maxLines: 3,
                                                                    style: const TextStyle(
                                                                      fontFamily: 'Montserrat',
                                                                      fontSize: 14.0,
                                                                    ),
                                                                  )
                                                                  // :
                                                                  // Text(" no notes")
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 380,
                                                                child: Wrap(children: <Widget>[
                                                                  Text(
                                                                    "${snapshot.data?.docs[index]['description']}",
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
                                                      Column(
                                                        children: [
                                                          IconButton(
                                                            icon: Icon(
                                                              Icons.delete,
                                                              color: Colors.red[700],
                                                            ),
                                                            onPressed: () {
                                                              FirebaseFirestore.instance
                                                                  .collection("orders")
                                                                  .doc(snapshot.data?.docs[index].id)
                                                                  .delete();
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            height: 30
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () => markAsReceived(snapshot.data?.docs[index].id),
                                                            child: const Text(
                                                              'Received',
                                                              textScaleFactor: 2,
                                                              style: TextStyle(fontSize: 10),
                                                            ),
                                                            style: ElevatedButton.styleFrom(
                                                                primary: const Color(0xFFFFF3E0),
                                                                onPrimary: const Color(0xFF3E2723),
                                                                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5)),
                                                          ),
                                                        ],
                                                      ),

                                                      // IconButton(onPressed:(){
                                                      //   Provider.of<AdminProvider>(context,listen:false).makeOrder(snapshot.data.docs[index]);}
                                                      //   ,  icon: Icon(Icons.arrow_forward_ios_rounded,size: 17,)
                                                      //   ,),
                                                    ],
                                                  )));
                                        }),
                                  );
                          }
                        })),
              ],
            ),
          )
        ],
      ),
    );
  }

//
// Widget _bulidFoodItem({String image, String foodName,String id}) {
//   return  Padding(
//               padding:const EdgeInsets.only(left: 10.0, right: 10.0,bottom: 10),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => DetailsOrder()
//                   ));
//                 },
//
//                child:  Row(
//                 mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       // Hero(
//                       //   tag: 'tagImage$index',
//                       //
//                       //   child:
//                         Image(
//                             image:NetworkImage(image),
//                             fit: BoxFit.fill,
//                             height: 90.0,
//                             width: 90.0
//
//                         ),
//                       // ),
//                       const  SizedBox(width: 30.0,),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           // Hero(
//                           //   tag: 'tagName$index',
//                           //
//                           //   child:
//                             Text(foodName,
//                             style:const TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold
//
//                             ),
//                           )
//   // ),
//
//                         ],
//                       )
//                     ],
//                   ),
//
//                 ],
//               ),
//             )
//
//   );
// }

}
