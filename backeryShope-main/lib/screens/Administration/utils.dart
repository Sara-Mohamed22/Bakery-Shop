// ignore_for_file: unnecessary_string_interpolations

import 'package:intl/intl.dart';

class Utils{
  static String toDateTime(DateTime dateTime){
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);
    return '$date $time';
  }

static String toDate(DateTime dateTime) {
  final date = DateFormat.yMMMEd().format(dateTime);
  return'$date';
}

static String toTime(DateTime dateTime) {
 final time = DateFormat.Hm().format(dateTime);
  return'$time';
}

//to different between time
 /* static String getTimeDifference(String startTime   , String endTime) {
    var dateFormat = DateFormat('h:m');
    DateTime durationStart = dateFormat.parse(startTime ??'00:00');
    DateTime durationEnd = dateFormat.parse(endTime ??'00:00');
    var time = durationEnd.difference(durationStart);
    var t;

      if( time.inHours != 0 && time !=null) {
        if (time.inHours < 0) {
          t = time.abs();
        }
        return '$t';
      }
      else
        {
          return '$time' ;
        }

  }*/
  ///////////////
 static String currentDataTime()
  {
    DateTime date = DateTime.now();
    return ' ${date.hour} :${date.minute}';
  }

}

class Time  {
final String note;
final DateTime from; 
final DateTime to;
 Time( this.note, this.from, this.to); 
}

