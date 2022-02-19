// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mill_10/screens/ORDER/delivaryOrder.dart';
import 'package:mill_10/screens/ORDER/drawer.dart';
import 'package:mill_10/screens/ORDER/order_list.dart';
import 'package:mill_10/screens/ORDER/preparing_order.dart';
import 'package:mill_10/utilities/router.dart';



class Acceptorder extends StatelessWidget {
  const Acceptorder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(onPressed: ()=>AppRouter.router.popPage(),
          icon:Icon( Icons.arrow_back_outlined,color: Colors.white,),

        ),

        elevation:0,
        backgroundColor: const Color(0xFF3E2723),
        title: const Text(
          'Order',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 25.0,
            color: Color(0xFFFFF3E0),
          ),
        ),
        centerTitle: true,
      ),

      body: DefaultTabController(
        length: 3,
        child: Scaffold(
           backgroundColor: const Color(0xFF3E2723),
          appBar: AppBar(

            toolbarHeight: 5,
           backgroundColor: const Color(0xFFFFF3E0),
           
            bottom:  const TabBar(
            unselectedLabelColor: Color(0xFF3E2723),
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                color: Color(0xFF3E2723),
              ),
              tabs: [
                Tab(
                   child: Align(
                   alignment: Alignment.center,
                   child: Text ("Order List",style: TextStyle(fontSize: 12.0)),
                   ) ,
                 ),

                Tab(
                  child:  Align(
                   alignment: Alignment.center,
                   child: Text ("preparing Order",style: TextStyle(fontSize: 12.0)),
                   ) ,
                   ), 

                Tab(
                  child: Align(
                   alignment: Alignment.center,
                   child: Text ("Orders Delivered",style: TextStyle(fontSize: 12.0)),
                   ) ,
                    ),
                  ],
                ),
              ),
          body:  TabBarView(
            children: [
              OrderPage(),
              PreparingOrder(),
              DelivaryOrder(),
            ],
          ),
        ),
      ),
    );
  }
}
          
                 
              

                
                     
            
          
                  
              