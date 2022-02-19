
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/provider/eventsProvider.dart';
import 'package:mill_10/model/meeting.dart';
import 'package:mill_10/screens/Administration/supervisr.dart';
import 'package:mill_10/screens/ORDER/drawer.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';

class EventView extends StatelessWidget {
  // final  event;
final String date;
  EventView({Key key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<EventsProvider>(context,listen:false);
    return Scaffold(
        backgroundColor: const Color(0xFF3E2723),
        appBar:AppBar(centerTitle: true,
          title: Text("Event's Details",
            style: TextStyle(
                color: Color(0xFFFFF3E0),
                fontWeight: FontWeight.bold,
                fontSize: 18.0
            ),
          ),
          leading:IconButton(
            onPressed: ()=>AppRouter.router.popPage(),
              icon: const Icon(Icons.keyboard_arrow_left_sharp,)) ,
          backgroundColor: const Color(0xFF3E2723),
          actions:[
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                    icon: const Icon(Icons.menu,),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer(); },
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip);})],
        ),
        endDrawer: NavigationDrawer(context),
     body:
        ListView(
          children:[ Container(
              margin: EdgeInsets.all(20),
              child: Column(children:[
                const SizedBox(height: 25.0,),

                 StreamBuilder(
                   stream: FirebaseFirestore.instance.collection('calender').where('date',isEqualTo:date).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                         if (!snapshot.hasData) {
                         return Center(child: CircularProgressIndicator(color: Colors.black87,));
                           } else {
                   return  ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,scrollDirection: Axis.vertical,
                       itemCount: snapshot.data.docs.length,
                       itemBuilder: (context, index) {
                          print(Provider.of<EventsProvider>(context).dateEvent);
                    return   Column(
                      children: [
                        Container(padding: EdgeInsets.all(10),
                             decoration: BoxDecoration(
                             color: Color(0xFFFFF3E0),
                             borderRadius: BorderRadius.circular(10)
                             ),child:
                          Column(
                          children:[
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Employee name:",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                              ),
                              // SizedBox(width:10,),
                              Text(snapshot.data.docs[index]['name'],
    // Provider.of<EventsProvider>(context).dropdownValue,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.red)),
                              SizedBox(width:55,height: 10,),
                           Padding(
                             padding: const EdgeInsets.only(top: 0.0,left: 10),
                             child: IconButton(onPressed: (){
                               FirebaseFirestore.instance.collection('calender').doc(snapshot.data.docs[index]['id']).delete();
                             }, icon: Icon(Icons.delete)),
                           )


                            ],
                          ),

                          Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('From:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                ),
                                SizedBox(width: 50,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text((snapshot.data.docs[index]['from'] as Timestamp).toDate().toString(),
                                  // Provider.of<EventsProvider>(context).fromDate.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                ),
                              ]),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('TO:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              ),
                              SizedBox(width: 68,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text((snapshot.data.docs[index]['to'] as Timestamp).toDate().toString(),
                            // Provider.of<EventsProvider>(context).toDate.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              ),
                            ],
                          ),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text('Notes:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              ),
                              SizedBox(width: 50,),
                              Container(width: 320,height: 100,
                                  decoration: BoxDecoration(color: Colors.yellow.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(snapshot.data.docs[index]['note'],
                         // Provider.of<EventsProvider>(context).noteController.text,
                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),
                            ],
                          ),


                          // buildDateTime()
                        ],)),
                        SizedBox(height: 50,) ],
                    )


                    ;});

          }}),
              ],
        )),

          ]));

    }}

