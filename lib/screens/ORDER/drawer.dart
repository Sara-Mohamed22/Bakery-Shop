
import 'package:flutter/material.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/screens/Administration/accp_Orders.dart';
import 'package:mill_10/screens/ORDER/customerOrder.dart';
import 'package:mill_10/screens/ORDER/order_list.dart';
import 'package:mill_10/screens/ORDER/tracking_order.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';




  Drawer NavigationDrawer(BuildContext context) {
    
    
    return Drawer(child:
      Theme(
      data: Theme.of(context).copyWith(canvasColor:const Color(0xFF3E2723)),
      child: Drawer(
        
        
          
          child:Consumer<UserProvider>(builder: (context, provider, widget) {
         return ListView(
            children: <Widget>[
              
              
              UserAccountsDrawerHeader(
                // accountName: Text(
                //   provider.emailController.text,
                //   style: TextStyle(fontSize: 20.0, color: Color(0xFFFFF3E0),),
                // ),
                accountEmail:Text(
                  provider.email.text,
                  style: TextStyle(color:Color(0xFFFFF3E0),),
                ),
                currentAccountPicture: GestureDetector(onTap: (){
                  Provider.of<AdminProvider>(context,listen: false).selectImage();

                },
                  child:Provider.of<AdminProvider>(context,listen: false).file == null?  Container(
                    width: 100,height: 100,
                    color: Color(0xFFFFF3E0),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF3E2723),
                        size:70,
                      ),
                    ):  Container(width: 100,height: 100,
                    child:
                     Image.file(Provider.of<AdminProvider>(context,listen: false).file,
                        fit: BoxFit.fill, ) ,
                      ),
                    )
                  ,

                decoration:const BoxDecoration(color: Color(0xFF3E2723)),
              ),
              
              
              
              Container(
                padding:const EdgeInsets.only(right: 10.0, left: 10.0),
                child:const Divider(
                  color: Color(0xFFFFF3E0),
                ),
              ),
              
              
              Container(
                color:const Color(0xFF3E2723),
                padding:const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {AppRouter.router.pushToNewWidget(CustomerOrderPage(userId:provider.customerID));},
                      child:const ListTile(
                        title: Text(
                          "My Order",
                          style: TextStyle(color: Color(0xFFFFF3E0), fontSize: 20.0),
                        ),
                        leading: Icon(
                          Icons.history,
                          color: Color(0xFFFFF3E0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFFFF3E0),
                          size: 18.0,
                        ),
                      ),
                    ),
                  const  Divider(
                      color: Color(0xFFFFF3E0),
                    ),
                  ],
                ),
              ),
              Container(
                color:const Color(0xFF3E2723),
                padding:const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Tracking()));
                        },
                      child:const ListTile(
                        title: Text(
                          "traking order ",
                          style: TextStyle(color: Color(0xFFFFF3E0), fontSize: 20.0),
                        ),
                        leading: Icon(
                          Icons.drive_eta,
                          color: Color(0xFFFFF3E0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFFFF3E0),
                          size: 18.0,
                        ),
                      ),
                    ),
                  const  Divider(
                      color: Color(0xFFFFF3E0),
                    ),
                  ],
                ),
              ),
              
              
              
            ],
          );},
        
      ),
      )));
  }
