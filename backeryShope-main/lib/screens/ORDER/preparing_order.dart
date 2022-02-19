// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/model/product.dart';
import 'package:mill_10/model/user.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';


class PreparingOrder extends StatefulWidget {
  String orderId;
 PreparingOrder({this.orderId,Key key}) : super(key: key);



  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<PreparingOrder> {
  final GlobalKey<ScaffoldState> _keydrawer = GlobalKey<ScaffoldState>();
  QuerySnapshot<Map<String, dynamic>> model;
  String group;
  var data;
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<AdminProvider>(context,listen:false);


    return Scaffold(
      key: _keydrawer,

      backgroundColor: const Color(0xFF3E2723),

      body:  ListView(
          children: <Widget>[

            const SizedBox(height: 25.0,),
            Padding(
              padding:const EdgeInsets.only(left: 40.0),
              child:
                  Text('Preparing Order ',
                    style: TextStyle(
                        color: Color(0xFFFFF3E0),
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0
                    ),
                  ),
            ),
            const  SizedBox(height: 40.0,),
            Container(height: MediaQuery.of(context).size.height - 185.0,
              decoration:const BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  
              ),
              child: ListView(
                  primary: false,padding:const EdgeInsets.only(left: 2.0, right: 2),
                children: <Widget>[
                 Padding(
                  padding:const EdgeInsets.only(top: 45.0),

                   child:StreamBuilder(
                      // stream: FirebaseFirestore.instance.collection('orders').where("status", isEqualTo: orderStatus.confirmed.name).snapshots(),

                       stream: FirebaseFirestore.instance.collection('orders').where("status", isEqualTo: orderStatus.preparing.name).snapshots(),
                                    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(child: const CircularProgressIndicator(color: Colors.black87,));
                                      } else {
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              data=snapshot.data.docs[index];
                                              provider.orderIDD=snapshot.data.docs[index]['idProduct'];
                                             provider.groupOrder= snapshot.data.docs[index]['groupName'];
                                              print(provider.orderIDD);
                                             provider.iduser= snapshot.data.docs[index]['userID'];
                                              FirestoreHelper.userId=snapshot.data.docs[index]['userID'];
                                              return  Padding(
                                                 padding:const EdgeInsets.only(left: 10.0, right: 10.0,bottom: 10),
                                              child:Container(width: 390,
                                                   decoration: BoxDecoration(color: Colors.yellow.withOpacity(0.2),
                                                       borderRadius: BorderRadius.circular(10)),

                                                   child:  Row(mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                       Padding(
                                                         padding: const EdgeInsets.only(bottom: 5.0,left: 4),
                                                         child: Image(
                                                             image:NetworkImage(snapshot.data.docs[index]['image']),
                                                             fit: BoxFit.fill,
                                                             height: 120.0,
                                                             width: 90.0

                                                         ),
                                                       ),
                                                       const  SizedBox(width: 5.0,),
                                                       Flexible(flex: 2,fit:FlexFit.loose,
                                                         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: <Widget>[
                                                             Text(snapshot.data.docs[index]['productname'], style:const TextStyle(
                                                                   fontFamily: 'Montserrat',
                                                                   fontSize: 18.0,
                                                                   fontWeight: FontWeight.bold

                                                               ),
                                                             ),
                                                            Row(mainAxisSize: MainAxisSize.min,
                                                                 children: [Icon(Icons.shopping_cart_rounded),
                                                                   Text(
                                                                     "Quantity: ${snapshot.data.docs[index]['quantity']}",
                                                                     style:const TextStyle(
                                                                       fontFamily: 'Montserrat',
                                                                       fontSize: 14.0,

                                                                     ),
                                                                   ),
                                                                 ],
                                                               ),


                                                             Container(
                                                                 decoration: BoxDecoration(
                                                                     borderRadius: BorderRadius.circular(8)),
                                                                 child:   Row(
                                                                   children: [Icon(Icons.note,size: 20,),
                                                                     (snapshot.data.docs[index]['description']!=null)?
                                                                     Expanded(child: Text(" Notes:${snapshot.data.docs[index]['description']}",
                                                                       style:const TextStyle(fontFamily: 'Montserrat', fontSize: 14.0,),)):
                                                                     Text("")
                                                                   ],
                                                                 )),
                                                             SafeArea(
                                                               child: FutureBuilder<UserModel>(
                                                                   future: FirestoreHelper.firestoreHelper.getUser(FirestoreHelper.userId),
                                                                   builder: (context, snapshot) {
                                                                     if(snapshot.connectionState == ConnectionState.waiting)
                                                                     {
                                                                       return Center(child: CircularProgressIndicator());
                                                                     }
                                                                     else {group=snapshot.data.group;
                                                                       return
                                                                         Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                             children: [
                                                                               Row(crossAxisAlignment: CrossAxisAlignment.start,
                                                                                 children: [
                                                                                   Icon(Icons.person),
                                                                                   Text(
                                                                                     snapshot.data.name!=null?  snapshot.data.name : 'loading...',
                                                                                   //  snapshot.data.name,
                                                                                     style: const TextStyle(
                                                                                       fontFamily: 'Montserrat',
                                                                                       fontSize: 14.0,
                                                                                       // fontWeight: FontWeight.bold

                                                                                     ),),],),
                                                                               Row(children: [
                                                                                 Icon(Icons.phone),
                                                                                 Text(
                                                                                  // snapshot.data.phone,
                                                                     snapshot.data.phone!=null?  snapshot.data.phone : 'loading...' ,
                                                                                   style: const TextStyle(
                                                                                     fontFamily: 'Montserrat',
                                                                                     fontSize: 14.0,
                                                                                     // fontWeight: FontWeight.bold
                                                                                   ),),],),
                                                                               Row(children: [
                                                                                 Icon(Icons.location_on),
                                                                                 Expanded(
                                                                                   child: Text(
                                                                                     //snapshot.data.address,
                                                                     snapshot.data.address!=null?  snapshot.data.address : 'loading...',
                                                                                     style: const TextStyle(
                                                                                       fontFamily: 'Montserrat',
                                                                                       fontSize: 14.0,
                                                                                       // fontWeight: FontWeight.bold

                                                                                     ),
                                                                                   ),
                                                                                 ),
                                                                               ],
                                                                               ),
                                                                               Row(children: [
                                                                                 Icon(Icons.group),
                                                                                 Text(
                                                                                   //snapshot.data.group,
                                                                                   snapshot.data.group!=null?  snapshot.data.group : 'loading...' ,
                                                                                   style: const TextStyle(
                                                                                     fontFamily: 'Montserrat',
                                                                                     fontSize: 14.0,
                                                                                     // fontWeight: FontWeight.bold

                                                                                   ),
                                                                                 ),
                                                                               ],
                                                                               ),

                                                                      ]);
                                                                   } } ),),



                                              ])),
                                                       Column(
                                                       children: [
                                                         Padding(padding: EdgeInsets.only(left: 50.0),

                                                             child: IconButton(onPressed:()=>FirebaseFirestore.instance.collection("orders").
                                                             doc(snapshot.data.docs[index].id).delete(), icon: Icon(Icons.delete),color: Colors.red,)),
                                                         Padding (padding: EdgeInsets.only(left: 0.0,top: 140),
                                                             child: OutlinedButton(child: Text("send ",style: TextStyle(fontSize: 12, color: Color(0xFF3a3a3b),
                                                             ))
                                                                 ,style: ButtonStyle(
                                                                     backgroundColor:MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
                                                                     shape: MaterialStateProperty.all<OutlinedBorder>(

                                                                         RoundedRectangleBorder(
                                                                             borderRadius: BorderRadius.all(Radius.circular(10.0),
                                                                             )))),

                                                                 onPressed: () async{
                                                                   await FirestoreHelper.firestoreHelper
                                                                   //    .changeOrderState(orderStatus.preparing, snapshot.data.docs[index].id);
                                                                   .changeOrderState(orderStatus.ready, snapshot.data.docs[index].id);

                                                                 }    )) ,

                                                             Container(
                                                                 child: StreamBuilder(
                                                                     stream: FirebaseFirestore.instance.collection('orders')
                                                                             .where("idProduct", isEqualTo:provider.orderIDD )
                                                                            .where('groupName',isEqualTo: provider.groupOrder)
                                                                             .where("backeryFinish", isEqualTo: true)
                                                                             .snapshots(),
                                                                     builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                       if (!snapshot.hasData) {
                                                                         return Center(child: const CircularProgressIndicator(color: Colors.black87,));
                                                                       } else {
                                                                         print("fffffffffffff ${snapshot.data.docs.length}");
                                                                     return (snapshot.data.docs.length>0)?
                                                                         Text('order is finished',
                                                                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.red),)

                                                                        :Center();
                                                                                // });
                                                                          }})),

                                                       ],),


                                                   ])));
                                            });}})),


          ]),
      ),
            ]));




          }




}

