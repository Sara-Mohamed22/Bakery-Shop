
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:string_validator/string_validator.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Meeting {

  String note,name,id;
  DateTime from;
  DateTime to;
  bool isAllDay;
  String date;
  Meeting({this.isAllDay,this.note, this.from, this.to,this.name,this.id,this.date});

  Map<String,dynamic> tooMap(){
    return {
      'id':id,
      'name':name,
      'note':note,
      'from':from,
      'to':to,
       'date':date,
      "isAllDay":isAllDay,
    };}

  factory Meeting.fromMap(Map<String, dynamic> snapshot) {
    return  Meeting(
      date: snapshot['date'],
      id:snapshot['id'],
      name:snapshot['name'],
      note:snapshot['note'],
      from:DateTime.fromMillisecondsSinceEpoch(snapshot['from']),
       to:DateTime.fromMillisecondsSinceEpoch(snapshot['to']),
      isAllDay:snapshot['isAllDay'],);
  }
  Meeting.toMap(DocumentSnapshot<Object> snapshot) {
    Map map = snapshot.data();
    this.date=map['date'];
    this.id=map['id'];
    this.name=map['name'];
    this.note=map["note"];
    this.from=map['from'];
    this.to=map['to'];
    this.isAllDay=map['iaAllDay'];}
}



// class Appointment {
//
//   String note,name,id;
//   DateTime from;
//   DateTime to;
//   bool isAllDay;
//   String date;
//   Appointment({this.isAllDay,this.note, this.from, this.to,this.name,this.id,this.date});
//
//   Map<String,dynamic> tooMap(){
//     return {
//       'id':id,
//       'subject':name,
//       'note':note,
//       'starTime':from,
//       'endTime':to,
//       'date':date,
//       "isAllDay":isAllDay,
//     };}
//
//   factory Appointment.fromMap(Map<String, dynamic> snapshot) {
//     return  Appointment(
//       date: snapshot['date'],
//       id:snapshot['id'],
//       name:snapshot['subject'],
//       note:snapshot['note'],
//       from:DateTime.fromMillisecondsSinceEpoch(snapshot['startTime']),
//       to:DateTime.fromMillisecondsSinceEpoch(snapshot['endTime']),
//       isAllDay:snapshot['isAllDay'],);
//   }
//   Appointment.toMap(DocumentSnapshot<Object> snapshot) {
//     Map map = snapshot.data();
//     this.date=map['date'];
//     this.id=map['id'];
//     this.name=map['subject'];
//     this.note=map["note"];
//     this.from=map['startTime'];
//     this.to=map['endTime'];
//     this.isAllDay=map['iaAllDay'];}
// }