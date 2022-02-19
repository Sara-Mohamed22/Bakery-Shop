



// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/model/meeting.dart';
import 'package:intl/intl.dart';
import 'package:mill_10/model/meetingdataSource.dart';
import 'package:mill_10/screens/Administration/supervisr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventsProvider extends ChangeNotifier{

String dropdownValue,dateEvent;
DateTime fromDate;
DateTime toDate;
DateTime datdat;
 List<Meeting> _times=[];
  List<Meeting> get event=> _times;
List<Meeting> eventResult=[];
FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime _selectedDate=DateTime.now();
  DateTime  get selectedDate=> _selectedDate;

void setDate(DateTime date)=> _selectedDate=date;

  GlobalKey<FormState> timeKey = GlobalKey<FormState>();
  TextEditingController noteController = TextEditingController();
TextEditingController nameController = TextEditingController();
List<Meeting> meetingEvent;
  // List<Meeting> get eventOfSelectedDate=>list;


String formatTimestamp(Timestamp timestamp) {
  var format = DateFormat('y-MM-d'); // 'hh:mm' for hour & min
  return format.format(timestamp.toDate());
}


Future<List<Meeting>> getEvents() async {
  var events = await FirebaseFirestore.instance.collection('calender').get();
  List<Meeting> list = [];
  // ignore: unused_local_variable
  for(var data in events.docs){
    Meeting meetingData=Meeting(
        name: data['name'],
        from:(data['from']as Timestamp).toDate(),
        to: (data['to']as Timestamp).toDate(),
        note:data['note'] ,
        id: data['id'],
        isAllDay: false
    );
    list.add(meetingData);
  }
  print(list);
  return list;
}
 getCalendarDataSource() async {
  var events = await FirebaseFirestore.instance.collection('calender').get();
  final List<Appointment> appointments = <Appointment>[];
  for(var data in events.docs){
  appointments.add(Appointment(
    startTime: (data['from']as Timestamp).toDate(),
    endTime: (data['to']as Timestamp).toDate(),
    subject: data['name'],
    notes: data['note'] ,
    color: Color(0xFFfb21f66),
  ));}
return appointments;
}

  getDataFromDatabase() async {
    QuerySnapshot value = await FirebaseFirestore.instance.collection('calender').get();
    return value;
  }






addEvent(Meeting meeting,context)async {
  // _events.add(meeting);
     await FirestoreHelper.firestoreHelper.addEvent(meeting,context);
  notifyListeners();}


  // getMeet() async {
  //  QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore.collection('calender').get();
  //
  //  meetingEvent = querySnapshot.docs.map((e) {
  //    Map map = e.data();
  //    map['id'] = e.id;
  //    return Meeting.fromMap(map);
  //  }).toList();
  //
  // notifyListeners();
  //
  //  return meetingEvent;
  //
  // }

}