

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/model/orderModel.dart';
import 'package:mill_10/model/product.dart';
import 'package:provider/provider.dart';

class DetailsOrder extends StatefulWidget {
  String idProduct;

  DetailsOrder(this.idProduct, {Key key}) : super(key: key);
  // ignore: use_key_in_widget_constructors

  @override
  _DetailsOrderState createState() => _DetailsOrderState();
}



class _DetailsOrderState extends State<DetailsOrder>{
  var quantity=0;
  int index=0;
  String note;

  void _minus() {

    if(quantity>0){
      setState(() {
        quantity =  quantity-10;
      });
    }


  }

  void _plus() {
     setState(() {
       quantity = quantity+10;
    });
  }


  @override
  Widget build(BuildContext context) {

  return Scaffold(
      backgroundColor: const Color(0xFF3E2723),
      appBar: AppBar(
        leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          color:const Color(0xFFFFF3E0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title:const Text('Order',
              style: TextStyle(
              fontSize: 18.0,
              color: Color(0xFFFFF3E0),
        ),
        ),
        centerTitle: true,
      ),

      body: StreamBuilder(
       stream: FirebaseFirestore.instance.collection('product').doc(widget.idProduct).snapshots(),
       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
       if (!snapshot.hasData) {
       return Center(child: CircularProgressIndicator(color: Colors.black87,));
    }  else {
       return SingleChildScrollView(
         child: Column(children:[

            Stack(
              children: <Widget>[
                   Container(
                     height: MediaQuery.of(context).size.height - 82,
                     width: MediaQuery.of(context).size.width,
                     color: Colors.transparent,
                   ),
                   Positioned (
                     top: 75.0,
                     child: Container(
                       decoration:const BoxDecoration(
                         borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(45.0),
                           topRight: Radius.circular(45.0)
                         ),
                         color: Color(0xFFFFF3E0),
                       ),
                       height: MediaQuery.of(context).size.height - 100,
                       width: MediaQuery.of(context).size.width,
                     )
                   ),
                   Positioned(
                     top: 30,
                     left: (MediaQuery.of(context).size.width / 2) - 100,
                     // child: Hero(
                     //   tag: countIndex(),
                        child:
                       Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(40),
                           image: DecorationImage(
                             image: NetworkImage(snapshot.data['image']),
                             fit: BoxFit.fill
                           )
                         ),
                       ),
                      // ),
                     height: 200,
                     width: 200,
                   ),
                   Positioned(
                     top: 250,
                     left: 25,
                     right: 25,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                       // Hero(
                       //    tag: nameIndex() ,
                       // child:
                       Text(snapshot.data['productname'],
                           style:const TextStyle(
                             color: Color(0xFF3E2723),
                             fontFamily: 'Montserrat',
                             fontSize: 22,
                             fontWeight: FontWeight.bold
                           ),
                         )
         // ),
                        , SizedBox(height: 20,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Container(
                               width: 125,
                               height: 40,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(17),
                                 color:const Color(0xFF3E2723),
                               ),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: <Widget>[
                                   InkWell(
                                     onTap: () {
                                       _minus();
                                      },
                                     child: Container(
                                       height: 25,
                                       width: 25,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(7),
                                         color:const Color(0xFF3E2723),
                                       ),
                                       child:const Center(
                                         child: Icon(
                                           Icons.remove,
                                           color: Colors.white,
                                           size: 20,
                                         ),
                                       ),
                                     )
                                   ),
                                   Text(quantity.toString(),
                                     style:const TextStyle(
                                       color: Color(0xFFFFF3E0),
                                       fontFamily: 'Montserrat',
                                       fontSize: 15
                                     ),
                                   ),
                                   InkWell(

                                     onTap: () {
                                       _plus();
                                      },


                                       child: Container(
                                         height: 25,
                                         width: 25,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(7),
                                             color:const Color(0xFF3E2723),
                                         ),
                                         child:const Center(
                                           child: Icon(
                                             Icons.add,
                                             color: Color(0xFFFFF3E0),
                                             size: 20,
                                           ),
                                         ),
                                       )
                                   ),
                                 ],
                               ),
                             )
                           ],
                         ),
                        const SizedBox(height: 20,),
                         SizedBox(
                          height: 100,
                           child: Form(key:Provider.of<AdminProvider>(context).notekey,
                             child: TextField(
                             controller: Provider.of<AdminProvider>(context).noteProductController ,
                        // onChanged: (value) {
                        //   setState(() {
                        //     note = value;
                        //   });
                        // },
                        decoration: InputDecoration(
                            labelText: "Note :",
                            border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(50),
                            )
                        ),
                      )),
                         ),


                         SizedBox(
                          height: 50,
                            child: Center(
                              child: ElevatedButton(
                                onPressed: ()  {
                                OrderModel order=OrderModel(
                                  userId: snapshot.data['userID'],
                                  idProduct: widget.idProduct,
                                   productname:snapshot.data['productname'],
                                     image:snapshot.data['image'],
                                     quantity:quantity.toString(),
                                     description: Provider.of<AdminProvider>(context,listen: false).noteProductController.text);
                                    Provider.of<AdminProvider>(context,listen:false).makeProductOrderP(order,context);
                                },
                                child:const Text(
                                'Make Order',
                                 textScaleFactor: 2,
                                 style: TextStyle(
                                 fontSize: 15),
                                 ),
                                 style: ElevatedButton.styleFrom(
                                 primary: const Color(0xFF3E2723),
                                 onPrimary: const Color(0xFFFFF3E0),
                                 padding:const EdgeInsets.fromLTRB(15, 5, 15, 5)
                           ),),
                            ),
                          ),
                        ],
                     ),
                   )
              ],
            )]),
       );

    }
    }));}

  }
