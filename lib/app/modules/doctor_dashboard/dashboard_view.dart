import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/modules/chat/chat_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardView extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> upcomingAppointments = [
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "28 November 2023",
      "time": "08:30 PM",
      "duration": "60 Minutes",
      "image": "assets/images/dr_img.png"
    },
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "28 November 2023",
      "time": "08:30 PM",
      "duration": "60 Minutes",
      "image": "assets/images/dr_img.png"
    },
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "28 November 2023",
      "time": "08:30 PM",
      "duration": "60 Minutes",
      "image": "assets/images/dr_img.png"
    },
  ];

  final List<Map<String, dynamic>> pastAppointments = [
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "28 November 2023",
      "image": "assets/images/dr_img.png"
    },
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "28 November 2023",
      "image": "assets/images/dr_img.png"
    },
  ];

  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const HeaderRow(),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getGreetingOfTheDay(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "Angela ",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldWithoutText(
                    hintText: "Search",
                    controller: searchController,
                  ),
                  const SizedBox(height: 26),
                  Row(
                    children: [
                      Text("My Appointment".tr,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildVisitsSummary(),
                  const SizedBox(height: 16),
                  _buildCalendar(),
                  const SizedBox(height: 16),
                  _buildPatientList(),
                  const SizedBox(height: 16),
                  const ConsultationCard(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                                radius: 4, backgroundColor: Colors.green),
                            const SizedBox(width: 6),
                            Text("DAILY READ".tr,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                            "Equitable medical education with efforts toward real change",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child:
                              Image.asset("assets/images/Rectangle 39896.png"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Visits Summary Section
  Widget _buildVisitsSummary() {
    return Stack(
      children: [
        Image.asset("assets/images/Group 1000005470.png"),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text("Visits for Today",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("104",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              const SizedBox(height: 35),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInfoBox("New Patients", "40", "51%", Colors.green,
                      "assets/icons/loss_icon.svg"),
                  const SizedBox(width: 8),
                  _buildInfoBox("Old Patients", "64", "20%", Colors.red,
                      "assets/icons/success_icon.svg"),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildInfoBox(
      String title, String count, String percentage, Color color, String icon) {
    return Container(
      width: 185,
      height: 95,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(count,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(percentage,
                        style: TextStyle(
                            color: color, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(icon)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Calendar Section
  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [CustomCalendar(), UpcomingMeetings()],
      ),
    );
  }

  // Upcoming Event Section
  Widget _buildUpcomingEvent() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Upcoming".tr,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("M", style: TextStyle(color: Colors.white))),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Monthly doctor's meet",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("8 April, 2021 | 04:00 PM",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Patient List Section
  Widget _buildPatientList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Patient List",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildPatientItem("SM", "Stacy Mitchell", "Weekly Visit", "9:15 AM",
              const Color(0xffF62088)),
          _buildPatientItem("AD", "Amy Dunham", "Routine Checkup", "9:30 AM",
              const Color(0xff0000FF)),
          _buildPatientItem(
              "DJ", "Demi Joan", "Report", "9:50 AM", const Color(0xff128983)),
        ],
      ),
    );
  }

  Widget _buildPatientItem(String initials, String name, String visitType,
      String time, Color color) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Text(initials, style: const TextStyle(color: Colors.black))),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(visitType, style: const TextStyle(color: Colors.grey)),
      trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color.withOpacity(0.15)),
          child: Text(time,
              style: TextStyle(color: color, fontWeight: FontWeight.w400))),
    );
  }

  // Consultation Card Section
  // Widget _buildConsultationCard() {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //       boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
  //     ),
  //     child: const Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text("Consultation",
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //         ListTile(
  //           leading: CircleAvatar(
  //               backgroundColor: Colors.blue,
  //               child: Text("DW", style: TextStyle(color: Colors.white))),
  //           title: Text("Denzel White",
  //               style: TextStyle(fontWeight: FontWeight.bold)),
  //           subtitle: Text("Male - 28 Years 3 Months",
  //               style: TextStyle(color: Colors.grey)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // // Daily Read Section
  // Widget _buildDailyReadCard() {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //       boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
  //     ),
  //     child: const Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text("DAILY READ",
  //             style:
  //                 TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
  //         Text("Equitable medical education with efforts toward real change",
  //             style: TextStyle(fontWeight: FontWeight.bold)),
  //       ],
  //     ),
  //   );
  // }
}

class ConsultationCard extends StatelessWidget {
  const ConsultationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircleAvatar(
                    backgroundColor: const Color(0xff128983).withOpacity(0.15),
                    child: const Text("DW",
                        style: TextStyle(color: Colors.black))),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Denzel White',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Male - 28 Years 3 Months',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconText("assets/icons/depression 1.svg", 'Tumor Surgery'),
              _buildIconText("assets/icons/cancer 1.svg", 'Trauma Surgery'),
              _buildIconText("assets/icons/heart_burn.svg", 'Heart Burn'),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Last Checked',
              'Dr Everly on 21 April 2024 Prescription', '#2J983KT0'),
          const SizedBox(
            height: 12,
          ),
          _buildInfoRow('Observation',
              'High fever and cough at normal hemoglobin levels.', ''),
          const SizedBox(
            height: 12,
          ),
          _buildInfoRow(
              'Prescription',
              'Paracetamol - 2 times a day\nDizopam - Day and Night before meal Wikoryl',
              ''),
        ],
      ),
    );
  }

  Widget _buildIconText(String icon, String text) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          color: AppColors.primaryColor,
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value, String link) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.50), fontSize: 14),
                  ),
                  if (link.isNotEmpty)
                    TextSpan(
                      text: ' $link',
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InitialsAvatar extends StatelessWidget {
  final String initials;
  final double size;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const InitialsAvatar({
    super.key,
    required this.initials,
    this.size = 60.0,
    this.backgroundColor = const Color(0xFFD9EAE9),
    this.borderColor = const Color(0xFF7AA6A4),
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class UpcomingMeetings extends StatelessWidget {
  const UpcomingMeetings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Upcoming",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// Meeting Card
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffF0F9FD), // Light background color
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: const Row(
              children: [
                /// Circle Avatar with Initial
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primaryColor,
                  child: Text(
                    "M",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(width: 12),

                /// Meeting Details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Montly doctor’s meet",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "8 April, 2021",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "|",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "04:00 PM",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  // Sample events
  final Map<DateTime, List<String>> _events = {
    DateTime(2022, 9, 8): ['Event 1'],
    DateTime(2022, 9, 14): ['Event 2'],
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Calendar Header
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Calendar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),

          const SizedBox(height: 8),

          /// Month Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "September 2022",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _focusedDay = DateTime(
                          _focusedDay.year,
                          _focusedDay.month - 1,
                        );
                      });
                    },
                    icon: const Icon(Icons.chevron_left),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _focusedDay = DateTime(
                          _focusedDay.year,
                          _focusedDay.month + 1,
                        );
                      });
                    },
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ],
          ),

          const Divider(),

          /// Calendar Widget
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            headerVisible: false,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue.shade200,
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              markerDecoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: (day) {
              return _events[day] ?? [];
            },
          ),
        ],
      ),
    );
  }
}
