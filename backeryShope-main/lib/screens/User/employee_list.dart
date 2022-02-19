
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/screens/User/editCustomer.dart';
import 'package:mill_10/screens/User/editEmployee.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';

import 'create_employee.dart';


class Employees extends StatefulWidget {
  const Employees({Key key}) : super(key: key);
  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {

  @override
  void initState() {
    super.initState();
   }


  _showDeleteDialog({Function press}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete employee}'),
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

  dynamic contact;
  Color typeColor = Colors.red;

  @override
Widget build(BuildContext context) {
 return Scaffold(
   appBar: AppBar(
        backgroundColor:const Color(0xFF3E2723),
        title:const Text('Employees List',
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
   body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').where('type',isEqualTo: 'employee').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
       } else
    {
    return ListView.builder(
                 shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount:snapshot.data.docs.length,
                itemBuilder: (context,index) {
      return Container(margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:const EdgeInsets.all(8),
                  height: 150,
                  color:const Color(0xFFFFF3E0),
       child: Column(
       children: [
        Row(children: [
         const Icon(Icons.person, color: Color(0xFF3E2723), size: 20,),
         // const  SizedBox(width: 6,),
          Text(" ${snapshot.data.docs[index]['name']}",
                style:const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF3E2723),
                              fontWeight: FontWeight.w600),),
           Spacer(),
           GestureDetector(onTap:  (){
              AppRouter.router.pushToNewWidget(EditEmployeeDetail(userId:snapshot.data.docs[index]['userid']));
            },
            child: Row(
                children: [
                    Icon(Icons.edit),
                  Text('Edit',style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF3E2723),
                      fontWeight: FontWeight.w600),),]),
          ) ,

        ],
        ),
           const SizedBox(height:6,),
        Row(children: [
           const Icon(Icons.phone_iphone, color: Color(0xFF3E2723), size: 20,),
           const SizedBox(width: 6,),
           Text(snapshot.data.docs[index]['phone'],
                             style:const TextStyle(
                                       fontSize: 16,
                                       color: Color(0xFF3E2723),
                                       fontWeight: FontWeight.w600),
         ),],
        ),

         const SizedBox(height:6,),
         Row(children: [
           const Icon(Icons.work, color: Color(0xFF3E2723), size: 20,),
           const SizedBox(width: 6,),
           Text(snapshot.data.docs[index]['role'],
             style:const TextStyle(
                 fontSize: 16,
                 color: Color(0xFF3E2723),
                 fontWeight: FontWeight.w600),
           ),],
         ),
         const SizedBox(height:6,),
            Row(
              children: [
                Icon(Icons.email, size: 20,color: Color(0xFF3E2723),),
                const   SizedBox(width: 6),
                Text(snapshot.data.docs[index]['email'], style: TextStyle(fontSize: 16,
                    
                    fontWeight: FontWeight.w600),),
                Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () =>_showDeleteDialog(
                          press:() {
                            Provider.of<UserProvider>(context,listen:false).
                            deletUser(snapshot.data.docs[index].id);
                            Navigator.pop(context);
                          },),
                        child: Row(
                          children: [
                          Icon(Icons.delete, color: Colors.red[700],),
                          // const  SizedBox(width: 6,),
                         Text('Delete', style: TextStyle(
                                fontSize: 12,
                                color: Colors.red[700],
                                fontWeight: FontWeight.w600
                            )),

                        ],),),


                  ],)
              ],
            ),


       ]
                  ));});}}),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Employee',
        child:const Icon(Icons.add, color: Color(0xFFFFF3E0)),
                backgroundColor:Color(0xFF3E2723),
          onPressed: () {
          Provider.of<UserProvider>(context,listen: false).clearCustomer();
          AppRouter.router.pushToNewWidget(EmployeeDetail());},
           )

           );
  }

  // Color getTypeColor(String type) {
  //   // ignore: deprecated_member_use
  //   Color color = Theme.of(context).accentColor;
  //
  //   if (type == 'Driver') {
  //     color = Colors.brown;
  //   }
  //
  //   if (type == 'Bakery') {
  //     color = Colors.green;
  //   }
  //
  //   if (type == 'Supervisor') {
  //     color = Colors.teal;
  //   }
  //
  //   if (type == 'collector') {
  //     color = Colors.blue;
  //   }
  //   return color;
  // }
}