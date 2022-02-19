import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/model/user.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';

import 'employee_list.dart';


class EmployeeDetail extends StatefulWidget {
  const EmployeeDetail({Key key}) : super(key: key);

  @override
  _EmployeeDetailState createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> {
  
  String dropdownValue;
  var _typeSelected;
Widget dropDown(BuildContext context){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(50)),
      child: DropdownButton<String>(
          hint: Text('Role Type',style: TextStyle(color: Color(0xFF3E2723)),),
          isExpanded:true,
          value: dropdownValue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 42,
          underline: SizedBox(),
          onChanged: (String newValue) {
            setState(() {
               dropdownValue = newValue;
            Provider.of<UserProvider>(context,listen:false).role=dropdownValue ;

            });

         },
          items: <String>['Driver', 'Bakery', 'Supervisor', 'collector'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList()),
    );
}
  Widget _buildEmployeeType(BuildContext context,String title) {
    return InkWell(
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          color: _typeSelected == title ? Colors.green : const Color(0xFF3E2723),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style:const TextStyle(
              fontSize: 18,
              // color: Color(0xFFFFF3E0),
            ),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _typeSelected = title;
          // _typeSelected=Provider.of<UserProvider>(context,listen: false).toggleRole();
        });

      },
    );
  }

  @override
  Widget build(BuildContext context) {
 return Scaffold(
        appBar: AppBar(
          backgroundColor:const Color(0xFF3E2723),
          title:const Text(
            "New Employee",
            style: TextStyle(
              color: Color(0xFFFFF3E0),
            ),
          ),
          leading: IconButton(
            color:const Color(0xFFFFF3E0),
            icon:const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
  body: Consumer<UserProvider>(builder: (context, provider, widget) {
    return ListView(
              children: [
     Stack(
          children: <Widget>[
      Container(
              margin:const EdgeInsets.all(15),
       child: Form(key:provider.employkey,
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                      TextFormField(
            controller: provider.name,
            validator:(v)=> provider.nullValidation(v),
            decoration: InputDecoration(
            labelText: "Employee Name :",
            prefixIcon:const Icon(
            Icons.account_circle,
            color: Color(0xFF3E2723),
            size: 30,
            ),
            contentPadding:const EdgeInsets.all(15),
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            )),
            ),
                    const SizedBox(height: 15),
                      TextFormField(
                  controller: provider.phone,
                        validator:(v)=> provider.nullValidation(v),
                        decoration: InputDecoration(
                            labelText: "Employee number :",
                            prefixIcon:const Icon(
                              Icons.phone_iphone,
                              color: Color(0xFF3E2723),
                              size: 30,
                            ),
                            contentPadding:const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                      ),
                    const  SizedBox(height: 15),
                      TextFormField(
                        controller: provider.description,
                        validator:(v)=> provider.nullValidation(v),
                        decoration: InputDecoration(
                            labelText: "Description :",
                            prefixIcon:const Icon(
                              Icons.description,
                              color: Color(0xFF3E2723),
                              size: 30,
                            ),
                            contentPadding:const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                      ),
                    const  SizedBox(height: 15),
                      TextFormField(
                        controller: provider.email,
                         validator:(v)=> provider.emailValidation(v),
                        decoration: InputDecoration(
                            labelText: "Email :",
                            prefixIcon:const Icon(
                              Icons.phone_iphone,
                              color: Color(0xFF3E2723),
                              size: 30,
                            ),
                            contentPadding:const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                      ),
                     const SizedBox(height: 15),
                      TextFormField(
                       controller: provider.password,
                       validator:(v)=> provider.nullValidation(v),
                        decoration: InputDecoration(
                            labelText: "Password :",
                            prefixIcon:const Icon(
                              Icons.description,
                              color: Color(0xFF3E2723),
                              size: 30,
                            ),
                            contentPadding:const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                      ),
                    const  SizedBox(height: 15),
                        dropDown(context),
                    const  SizedBox(height: 30),
                      Container(
                        height: 50,
                        padding:const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton( 
                               onPressed: ()=>provider.signUpemploye(context),
                                child:const Text(
                                 'Save Employee',
                                 textScaleFactor: 2,
                                 style: TextStyle(
                                   fontSize: 10),
                               ),
                             style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF3E2723), 
                              onPrimary: const Color(0xFFFFF3E0),
                              padding:const EdgeInsets.fromLTRB(15, 5, 15, 5)
                             ),),
                      )
                    ],
                  ),
                ),
    )],
            )
          ],
        );}));
  }

           
                              
}
