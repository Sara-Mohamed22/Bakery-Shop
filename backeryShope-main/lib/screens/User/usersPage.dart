import 'package:flutter/material.dart';
import 'package:mill_10/screens/Administration/driver.dart';

class Users extends StatelessWidget {
  const Users({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xFF3E2723),
        title:const Text("UsersPage",
          style: TextStyle(
            color: Color(0xFFFFF3E0),
          ),),
        centerTitle: true,
      ),
      backgroundColor:const Color(0xFF3E2723),

      body:  ListView(
        children: <Widget>[

          Row(
            children: <Widget>[
       Container(

      margin:const EdgeInsets.all(5.0),
      padding:const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color:const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children:const <Widget>[
          Icon(
            Icons.fastfood,
            size: 80.0,
            color: Color(0xFF3E2723),
          ),
          Text(
            "Product",
            style: TextStyle(fontSize: 18.0),
          )
        ],
      ),
    )]),
              Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Driver()));
                    },
                    child: Container(
                      margin:const EdgeInsets.all(5.0),
                      padding:const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color:const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(
                        children:const <Widget>[
                          Icon(
                            Icons.drive_eta_rounded,
                            size: 80.0,
                            color: Color(0xFF3E2723),
                          ),
                          Text(
                            "Driver",
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  )),
              // Expanded(
              //     child: GestureDetector(
              //       onTap: () {
              //         Navigator.push(context,
              //             MaterialPageRoute(builder: (context) =>Acceptorder()));
              //       },
              //       child: Container(
              //         margin:const EdgeInsets.all(5.0),
              //         padding:const EdgeInsets.all(10.0),
              //         decoration: BoxDecoration(
              //             color:const Color(0xFFFFF3E0),
              //             borderRadius: BorderRadius.circular(15.0)),
              //         child: Column(
              //           children:const <Widget>[
              //             Icon(
              //               Icons.message,
              //               size: 80.0,
              //               color: Color(0xFF3E2723),
              //             ),
              //             Text(
              //               "Order",
              //               style: TextStyle(fontSize: 18.0),
              //             )
              //           ],
              //         ),
              //       ),
              //     )),
            ],
          ),


      );
  }
}
