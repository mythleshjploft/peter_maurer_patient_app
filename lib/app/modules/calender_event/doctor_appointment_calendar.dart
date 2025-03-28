import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DoctorAppointmentCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.week,
      firstDayOfWeek: 1,
      headerDateFormat: 'EEE MMM d',
      timeSlotViewSettings: const TimeSlotViewSettings(
        numberOfDaysInView: 2,
        timeInterval: Duration(hours: 1),
        timeIntervalHeight: 60,
        timeFormat: 'h a',
        dayFormat: 'EEE MMM d',
      ),
      dataSource: AppointmentDataSource(getAppointments()),
      specialRegions: getBookedSlots(),
    );
  }
}

List<Appointment> getAppointments() {
  return [
    Appointment(
      startTime: DateTime(2025, 2, 16, 8, 0),
      endTime: DateTime(2025, 2, 16, 9, 0),
      subject: 'Dr. Devon Miles',
      color: Colors.blue,
    ),
    Appointment(
      startTime: DateTime(2025, 7, 14, 16, 0),
      endTime: DateTime(2025, 7, 14, 17, 0),
      subject: 'Dr. Sarah Connor',
      color: Colors.green,
    ),
    Appointment(
      startTime: DateTime(2025, 7, 15, 8, 0),
      endTime: DateTime(2025, 7, 15, 9, 0),
      subject: 'Dr. Devon Miles',
      color: Colors.blue,
    ),
    Appointment(
      startTime: DateTime(2025, 7, 15, 15, 0),
      endTime: DateTime(2025, 7, 15, 16, 0),
      subject: 'Dr. Bonnie Barstow',
      color: Colors.blue,
    ),
    Appointment(
      startTime: DateTime(2025, 7, 16, 10, 0),
      endTime: DateTime(2025, 7, 16, 11, 0),
      subject: 'Dr. John Doe',
      color: Colors.orange,
    ),
    Appointment(
      startTime: DateTime(2025, 7, 16, 14, 0),
      endTime: DateTime(2025, 7, 16, 15, 0),
      subject: 'Dr. Emily Smith',
      color: Colors.purple,
    ),
    Appointment(
      startTime: DateTime(2025, 7, 18, 12, 0),
      endTime: DateTime(2025, 7, 18, 13, 0),
      subject: 'Dr. Robert Brown',
      color: Colors.red,
    ),
  ];
}

List<TimeRegion> getBookedSlots() {
  return [
    TimeRegion(
      startTime: DateTime(2025, 2, 16, 10, 0),
      endTime: DateTime(2025, 2, 16, 14, 0),
      text: 'Booked',
      color: Colors.grey.shade200,
    ),
    TimeRegion(
      startTime: DateTime(2025, 2, 16, 12, 0),
      endTime: DateTime(2025, 2, 16, 14, 0),
      text: 'Booked',
      color: Colors.grey.shade200,
    ),
    TimeRegion(
      startTime: DateTime(2025, 7, 17, 9, 0),
      endTime: DateTime(2025, 7, 17, 12, 0),
      text: 'Booked',
      color: Colors.grey.shade200,
    ),
  ];
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
