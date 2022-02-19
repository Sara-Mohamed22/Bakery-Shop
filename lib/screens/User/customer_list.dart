
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/screens/User/editCustomer.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';

import 'create_customer.dart';


class Customer extends StatefulWidget {
  const Customer({Key key}) : super(key: key);

  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  @override
  void initState() {
    super.initState();
  }

  // ignore: unused_element
  Widget _buildContactItem() {
   return
    StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').where('type',isEqualTo: 'costumer').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: Colors.black87,));
          } else {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  Provider.of<UserProvider>(context,listen: false).editCustomerID= snapshot.data.docs[index]['userid'];
                  return Container(height: 150,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    color: const Color(0xFFFFF3E0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Color(0xFF3E2723),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(snapshot.data.docs[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF3E2723),
                                      fontWeight: FontWeight.w600),
                                ),]),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone_iphone,
                                  color: Color(0xFF3E2723),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(snapshot.data.docs[index]['phone'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF3E2723),
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 15),

                              ],),
                            Row(
                              children: [
                                Icon(
                                  Icons.group_work,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                Text(" ${snapshot.data.docs[index]['type']}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600),
                                ),  ],
                            ),


                            Row(
                              children: [
                                Icon(Icons.group_work, size: 20,),

                            const   SizedBox(width: 6),
                            Text(snapshot.data.docs[index]['email'], style: TextStyle(fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),),


                          ],
                        ),
                          ],
                        ),
                       Spacer(),
                       Column(crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Expanded(
                             child: GestureDetector(
                                        child:Row(
                                            children: [
                                              IconButton(
                                                    onPressed: (){

                                                  AppRouter.router.pushToNewWidget(EditCustomerDetail(userId:snapshot.data.docs[index]['userid']));
                                                }, icon: Icon(Icons.edit)),
                                              Text('Edit',style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF3E2723),
                                                  fontWeight: FontWeight.w600),),]),
                                      ),
                           ),
                           Spacer(),
                           Padding(
                             padding: const EdgeInsets.only(left: 60),
                             child:
                                   GestureDetector(
                                     onTap: () {
                                       _showDeleteDialog(
                                         press:() {
                                           Provider.of<UserProvider>(context,listen:false).
                                           deletUser(snapshot.data.docs[index].id);
                                           Navigator.pop(context);
                                         },);
                                     },
                                     child: Row(
                                       children: [
                                         Icon(
                                           Icons.delete,
                                           color: Colors.red[700],
                                         ),
                                         Text('Delete',
                                             style: TextStyle(
                                                 fontSize: 13,
                                                 color: Colors.red[700],
                                                 fontWeight: FontWeight.w600)),
                                       ],
                                     ),
                                   ),


                           ),   ],
                       ),

                          ],
                        ),
                            );
                });
          }
        });
  }



  _showDeleteDialog({Function press}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete'),
            content:const Text('Are you sure you want to delete?'),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:const Text('Cancel')),
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: press,
                  child:const Text('Delete'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E2723),
        title:const Text('Customer List',
              style: TextStyle(
              fontSize: 18.0,
              color: Color(0xFFFFF3E0),
        ),
        ),
        leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          color:const Color(0xFFFFF3E0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body:_buildContactItem(),
      floatingActionButton: FloatingActionButton(
       tooltip: 'Add Customer',
      child: const Icon(Icons.add, color: Color(0xFFFFF3E0)), backgroundColor:const Color(0xFF3E2723),
          onPressed: () {
         Provider.of<UserProvider>(context,listen: false).clearCustomer();
         AppRouter.router.pushToNewWidget(CustomerDetail()) ;

           },
           ),
        );
  }


}