

import 'package:mill_10/model/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;

  }
  Meeting getEvent(int index)=> appointments[index] as Meeting;
  @override
  DateTime getStartTime(int index) {
    return getEvent(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return getEvent(index).to;
  }

  @override
  String getSubject(int index) {
    return getEvent(index).note;
  }

  @override
  bool isAllDay(int index) {
    return getEvent(index).isAllDay;
  }

}
