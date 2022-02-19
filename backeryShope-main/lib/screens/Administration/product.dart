
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/screens/Administration/add_product.dart';
import 'package:mill_10/screens/ORDER/make_order.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  const Product({Key key}) : super(key: key);
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {






  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor:const Color(0xFF3E2723),
          onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (_){
             return AddPrd();

           }));
          },
          tooltip: 'Add Product',
          child:const Icon(Icons.add,
          color: Color(0xFFFFF3E0),

           ),
        ),
      
     
      backgroundColor:const Color(0xFF3E2723),
      body: ListView(
        children: <Widget>[
          Padding(
            padding:const EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon:const Icon(Icons.arrow_back),
                    color:const Color(0xFFFFF3E0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
            ),
          ),
        const  SizedBox(height: 25.0,),
          Padding(
            padding:const EdgeInsets.only(left: 40.0),
            child: Row(
              children:const <Widget>[
                Text('Our',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color(0xFFFFF3E0),
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0
                  ),
                ),
                SizedBox(width: 10.0,),
                Text('product',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFFFFF3E0),
                      fontSize: 25.0
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 40.0,),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height - 185.0,
            decoration:const BoxDecoration(
                color: Color(0xFFFFF3E0),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0))
            ),
           child: ListView(
              primary: false,
              padding:const EdgeInsets.only(left: 25.0, right: 25.0),
              children: <Widget>[
           Padding(
                  padding:const EdgeInsets.only(top: 45.0),
           child: SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
            child: StreamBuilder(
               stream: FirebaseFirestore.instance.collection('product').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
               if(!snapshot.hasData) {
               return CircularProgressIndicator();
                } else{

                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount:snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                        return
                        _bulidFoodItem(
                              imgPath:snapshot.data.docs[index]['image'],
                              foodName:snapshot.data.docs[index]['productname'],
                              press:()=>  FirebaseFirestore.instance.collection("product").
                                          doc(snapshot.data.docs[index].id).delete(),
                          orderpress: ()=>  Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DetailsOrder(snapshot.data.docs[index]['idproduct'])
                          ))
                              // Provider.of<AdminProvider>(context, listen: false).addOrder(snapshot.data.docs[index],context,),

                        );

                    }
                         );
                      }
               }
                  ),
                )
           )],
            ),
          )
        ],
      ),
    );
  }

  Widget _bulidFoodItem({String imgPath, String foodName,Function press,Function orderpress}) {
    return Padding(
      padding:const EdgeInsets.only(left: 10.0, right: 10.0,bottom: 10),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: imgPath,
                  
                  child: Image(
                      image: NetworkImage(imgPath),
                      fit: BoxFit.fill,
                      height: 90.0,
                      width: 90.0
                      
                  ),
                ),
              const  SizedBox(width: 30.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      foodName,
                      style:const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold

                      ),
                    ),

                 Row(
                   children: [
                   ElevatedButton(
                     onPressed:orderpress,
                     // // var userId =  Provider.of<AuthProvider>(context,listen: false).currentUser.uid;
                     // final productName = Provider.of<AdminProvider>(context, listen: false).productNameController.text;
                     // // print(userId);
                     // ProductModel order = ProductModel(productname: productName);
                     // Provider.of<AdminProvider>(context, listen: false).addOrder(order);
                     // },
                     // },
                     child: Text(
                       'order',
                       style: TextStyle(
                           fontSize: 12),
                     ),
                     style: ElevatedButton.styleFrom(
                       primary: const Color(0xFF3E2723),
                       onPrimary: const Color(0xFFFFF3E0),
                       // padding:const EdgeInsets.fromLTRB(30, 5, 30, 5)
                     ),
                   ),
                   SizedBox(width: 20,),
                   ElevatedButton(
                     onPressed: press,
                     child: Text(
                       'Delete',
                       style: TextStyle(
                           fontSize: 12),
                     ),
                     style: ElevatedButton.styleFrom(
                       primary: const Color(0xFF3E2723),
                       onPrimary: const Color(0xFFFFF3E0),
                       // padding:const EdgeInsets.fromLTRB(30, 5, 30, 5)
                     ),
                   ),
                 ],)

                /* Row(
                   children: [
                     SizedBox(width: 90,
                       child: ElevatedButton(
                         onPressed:orderpress,
                           // // var userId =  Provider.of<AuthProvider>(context,listen: false).currentUser.uid;
                           // final productName = Provider.of<AdminProvider>(context, listen: false).productNameController.text;
                           // // print(userId);
                           // ProductModel order = ProductModel(productname: productName);
                           // Provider.of<AdminProvider>(context, listen: false).addOrder(order);
                         // },
                         // },
                         child: Text(
                           'order',
                           style: TextStyle(
                               fontSize: 12),
                         ),
                         style: ElevatedButton.styleFrom(
                             primary: const Color(0xFF3E2723),
                             onPrimary: const Color(0xFFFFF3E0),
                             // padding:const EdgeInsets.fromLTRB(30, 5, 30, 5)
                         ),
                       ),
                     ),
                       SizedBox(width: 10,),
                     SizedBox(width: 90,
                       child: ElevatedButton(
                                   onPressed: press,
                                   child: Text(
                                     'Delete',
                                     style: TextStyle(
                                       fontSize: 12),
                                   ),
                                  style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF3E2723),
                                  onPrimary: const Color(0xFFFFF3E0),
                                  // padding:const EdgeInsets.fromLTRB(30, 5, 30, 5)
                                 ),
                                 ),
                     ),
                   ],
                 ),*/
                  ],
                )
              ],
            ),
            
          ],
        ),
      
    );
  }
}