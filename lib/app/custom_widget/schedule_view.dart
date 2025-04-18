import 'package:flutter/material.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';

class ScheduleScreen extends StatelessWidget {
  final List<String> timeSlots = [
    '7am',
    '8am',
    '9am',
    '10am',
    '11am',
    '12pm',
    '1pm',
    '2pm',
    '3pm',
    '4pm',
    '5pm',
    '6pm',
    '7pm',
    '8pm',
    '9pm'
  ];

  final List<Map<String, dynamic>> events = [
    {
      'day': 'Sun Jul 16',
      'time': '8am',
      'doctor': 'Dr. Devon Miles',
      'color': AppColors.primaryColor,
    },
    {
      'day': 'Sun Jul 16',
      'time': '3pm',
      'doctor': 'Dr. Bonnie Barstow',
      'color': AppColors.primaryColor,
    },
    {
      'day': 'Mon Jul 17',
      'time': '8am',
      'doctor': 'Dr. Devon Miles',
      'color': AppColors.primaryColor,
    },
    {
      'day': 'Mon Jul 17',
      'time': '3pm',
      'doctor': 'Dr. Bonnie Barstow',
      'color': AppColors.primaryColor,
    },
    {
      'day': 'Sun Jul 16',
      'time': '12pm',
      'doctor': 'Booked',
      'color': Colors.grey[300],
    },
    {
      'day': 'Mon Jul 17',
      'time': '12pm',
      'doctor': 'Booked',
      'color': Colors.grey[300],
    }
  ];

  ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: timeSlots
                    .map((time) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          child: Text(time,
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14)),
                        ))
                    .toList(),
              ),
              const SizedBox(width: 8),
              // Days & Events Column
              Row(
                children: ['Sun Jul 16', 'Mon Jul 17'].map((day) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date Header
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(day,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff075985))),
                      ),

                      Column(
                        children: timeSlots.map((time) {
                          final event = events.firstWhere(
                            (e) => e['day'] == day && e['time'] == time,
                            orElse: () => {},
                          );

                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            width: 140,
                            height: 40,
                            decoration: BoxDecoration(
                              color: event.isNotEmpty
                                  ? event['color']
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: event.isNotEmpty
                                ? Text(
                                    event['doctor'] == 'Booked'
                                        ? 'Booked'
                                        : "${event['time']}\n${event['doctor']}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: event['color'] ==
                                              AppColors.primaryColor
                                          ? Colors.white
                                          : Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : null,
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
