import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_togal_switch.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorDetailsView extends StatefulWidget {
  @override
  _DoctorDetailsViewState createState() => _DoctorDetailsViewState();
}

class _DoctorDetailsViewState extends State<DoctorDetailsView> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      appBar: CustomAppBar(title: "Dr. Dr. Maurer"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                   colors: [Color(0xffBAF0FF), Color(0xffF3FFE0)],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      
                      Image.asset("assets/images/details_dr_img.png",width: 97,height: 87,),
                     
                      SizedBox(width: 15,height: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr. Dr. Maurer",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Stomach Specialist",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      infoBox("Experience", "2 Years+"),
                      SizedBox(height: 16,),
                      infoBox("Patient", "200+"),
                    ],
                  ),
                ],
              ),
            ),

            // Description Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Lorem ipsum dolor sit amet consectetur. Ac nunc faucibus auctor purus nulla pretium bibendum.Lorem ipsum dolor sit amet consectetur. Ac nunc faucibus auctor purus nulla pretium bibendum.",
                style: TextStyle(color: Colors.black,fontSize: 13.5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "Read More",
                      style: TextStyle(color:AppColors.primaryColor, fontWeight: FontWeight.w400,decoration: TextDecoration.underline,),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Image.asset("assets/images/location_icon.png"),
            ),

            // Location Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/location_icon_map.svg"),
                  SizedBox(width: 5),
                  Text(
                    "Raleigh, North Carolina",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),

            // Date & Time Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Select Date And Time",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),

            // Calendar Widget
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(.30),
                border: Border.all(color: AppColors.borderColor)
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TableCalendar(
                    focusedDay: _selectedDay,
                    firstDay: DateTime(2022),
                    lastDay: DateTime(2030),
                    calendarFormat: CalendarFormat.month,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                      });
                    },
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
               
                  Row(
                    children: [
                      Text(
                        "Thursday, 10th August",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 13,),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                timeSlot("03:00pm"),
                timeSlot("03:30pm"),
                timeSlot("04:30pm"),
                timeSlot("11:30am"),
                timeSlot("05:30pm"),
                timeSlot("02:30pm", selected: true),
                timeSlot("05:00pm"),
                timeSlot("10:30am"),
              ],
            ),
               SizedBox(height: 13,),
                ],
              ),
            ),

            // Time Slots
            

            // Bottom Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/icons/call_chat_switch.svg"),
                  // CustomToggleSwitch(),
                  // FloatingActionButton(
                  //   backgroundColor: Colors.blue,
                  //   onPressed: () {},
                  //   child: Icon(Icons.call, color: Colors.white),
                  // ),
                  // FloatingActionButton(
                  //   backgroundColor: Colors.grey.shade300,
                  //   onPressed: () {},
                  //   child: Icon(Icons.message, color: Colors.black),
                  // ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Book",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
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

  // Helper method for info boxes
  Widget infoBox(String title, String value) {
    return Container(
      width: 120,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
         color: Color(0xffFFFFFF).withOpacity(.55),
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5),
        // ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Helper method for time slots
  Widget timeSlot(String time, {bool selected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: selected ? AppColors.primaryColor : Colors.grey.shade400),
        borderRadius: BorderRadius.circular(4),
        color: selected ? AppColors.primaryColor.withOpacity(0.1) : Colors.white,
      ),
      child: Text(
        time,
        style: TextStyle(color: selected ? AppColors.primaryColor : Colors.black),
      ),
    );
  }
}


// class DetailsView extends StatefulWidget {
//   const DetailsView({super.key});

//   @override
//   State<DetailsView> createState() => _DetailsViewState();
// }

// class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
        title: "Dr. Dr. Maurer",
        onActionPress: () {},
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
               width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xffBAF0FF), Color(0xffF3FFE0)],
                    ),
                      borderRadius:  BorderRadius.circular(
                      20
                    ),),
              child:  Row(
                children: [Column(
                  children: [
                     CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/dr_img.png"),
                      ),
        
                      Text("Dr. Dr. Maurer"),
                      Text("Stomach Specialist")
                  ],
                ),Column(
                  children: [
                  //  Container(child:,)
                  ],
                )],
              ),
            )
          ],
        ),
      ),
    );
  }
