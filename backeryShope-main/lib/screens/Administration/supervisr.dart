

// ignore_for_file: unnecessary_new, missing_return, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/eventsProvider.dart';
import 'package:mill_10/model/meeting.dart';
import 'package:mill_10/model/meetingdataSource.dart';
import 'package:mill_10/screens/Administration/eventView.dart';
import 'package:mill_10/screens/Administration/times.dart';
import 'package:mill_10/screens/Administration/utils.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class Maincalend extends StatefulWidget {
  const Maincalend({Key key}) : super(key: key);

  @override
  State<Maincalend> createState() => _MaincalendState();
}

class _MaincalendState extends State<Maincalend> {

  MeetingDataSource meetEvent;
  QuerySnapshot querySnapshot;
  List<Appointment> _appointmentDetails=<Appointment>[];

  CalendarController _calendarController = CalendarController();


  getDataFromDatabase() async {
    QuerySnapshot value = await FirebaseFirestore.instance.collection('calender').get();
    return value;
  }

  void _viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      FirestoreHelper.firestoreHelper.datePicked = viewChangedDetails
          .visibleDates[viewChangedDetails.visibleDates.length ~/ 2];
    });
  }
  void initState() {
    getDataFromDatabase().then((results) {
      setState(() {
        if (results != null) {
           querySnapshot = results;
        }
      });
    });
    super.initState();
  }
  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      setState(() {
        _appointmentDetails = calendarTapDetails.appointments.cast<Appointment>();
      });
    }
  }
    @override
    // ignore: annotate_overrides
    Widget build(BuildContext context) {

    final provider=Provider.of<EventsProvider>(context,listen:false);
      return Scaffold(
          appBar: AppBar(

            backgroundColor: const Color(0xFF3E2723),
            elevation: 0.0,
            title: const Text('Calendar sheet',
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFFFFF3E0),
              ),
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add New time',
            child: const Icon(Icons.add, color: Color(0xFFFFF3E0)),
            backgroundColor: const Color(0xFF3E2723),
            onPressed: () {
              AppRouter.router.pushToNewWidget(Entertime());
            },
          ),

          body: SingleChildScrollView(
              child:
              SafeArea(
                child: Container(width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:
                  FutureBuilder(
                      future: provider.getEvents(),
                      builder: (context,snapshot) {
                        if (snapshot.hasData) {
                          return
                              SfCalendar(
                                view: CalendarView.month,
                                // onViewChanged: _viewChanged,
                                dataSource:MeetingDataSource(snapshot.data),

                                monthViewSettings: MonthViewSettings(
                                    showAgenda: true, agendaViewHeight: 400,
                                    agendaStyle: AgendaStyle(
                                       // backgroundColor: Colors.lightGreen,
                                      appointmentTextStyle: TextStyle(
                                          fontSize: 16,fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                      dateTextStyle: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black),
                                      dayTextStyle: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                 appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
                                 appointmentTextStyle: TextStyle(
                                   fontSize: 18,
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold,
                                   fontStyle: FontStyle.normal) ,

                                onLongPress:(details){
                                  provider.datdat=details.date;
                                  String date= Utils.toDate(provider.datdat);

                              print("ooooo ${date}");
                               //    if(details.appointments.first==null){
                               //      return
                               // showModalBottomSheet<void>(context: context,builder: (BuildContext context) {
                               //   return Container(height: 50,child: Center(child: Text("No data")));
                               //   });
                               // }
                               // else{
                               //   final event=details.appointments;
                                 AppRouter.router.pushToNewWidget(EventView(date:date));
                                  },
                                  // ;},


                                headerStyle: CalendarHeaderStyle  (textAlign: TextAlign.center, backgroundColor: Color(0xFF7fcd91),
                                    textStyle: TextStyle(fontSize: 25, fontStyle: FontStyle.normal, letterSpacing: 5, color: Color(0xFFff5eaea), fontWeight: FontWeight.w500)
                                ),

                                initialSelectedDate:DateTime.now(),
                                headerHeight: 70,
                                todayHighlightColor: Colors.black87,
                                selectionDecoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                              );}
                        else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              )));
    }

  }