// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/model/user.dart';
import 'package:provider/provider.dart';


class EditEmployeeDetail extends StatefulWidget {
 final String userId;
  const EditEmployeeDetail ({Key key,this.userId}) : super(key: key);

  @override
  _EmployeeDetailState createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EditEmployeeDetail > {


  var _typeSelected;

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



  // Future<UserModel> getUser(context) async {
  //   final provider=Provider.of<UserProvider>(context,listen: false);
  //   UserModel user = await FirestoreHelper.firestoreHelper.getUser(widget.userId);
  //   provider.employeeID=user.userid;
  //   print("${user.userid}");
  //   print("${user.email}");
  //   provider.name.text =user.name;
  //   provider.email.text =user.email;
  //   provider.password.text =user.password;
  //   provider.phone.text =user.phone;
  //   provider.description.text =user.description;
  //   provider.role=user.role;
  //
  // }




  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<UserProvider>(context,listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor:const Color(0xFF3E2723),
          title:const Text(
            "Edite Employee Details",
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
        body: SingleChildScrollView(
          child: SafeArea(
           child: FutureBuilder<UserModel>(
                future: provider.getUserEmploye(widget.userId),
                builder: (context,snapshot) {
              return
                  Container(
                    margin:const EdgeInsets.all(15),
                    child: Form(key:provider.editEmployee,
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
                          Drop(),
                          const  SizedBox(height: 30),
                          Container(
                            height: 50,
                            padding:const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              onPressed: ()=>provider.updateEmployeeData(userID:provider.employeeID),
                              child:const Text(
                                'Update Employee Details',
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

              );}))));
  }



}




class Drop extends StatefulWidget {
  const Drop({Key key}) : super(key: key);

  @override
  _DropState createState() => _DropState();
}

class _DropState extends State<Drop> {

  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(50)),
        child: DropdownButton<String>(
            hint: Text('Role Type',style: TextStyle(color: Color(0xFF3E2723)),),
            isExpanded:true,
            value:   Provider.of<UserProvider>(context,listen:false).role,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 42,
            underline: SizedBox(),
            onChanged: (String newValue) {
              setState(() {
              dropdownValue = newValue;
                Provider.of<UserProvider>(context,listen:false).role=newValue;

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
}
