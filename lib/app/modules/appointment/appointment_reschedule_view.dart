import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/appointment_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar_doctor.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';

import 'package:table_calendar/table_calendar.dart';

class AppointmentRescheduleView extends StatefulWidget {
  const AppointmentRescheduleView(
      {super.key,
      required this.patientId,
      required this.appointmentId,
      required this.doctorId});
  final String appointmentId;
  final String patientId;
  final String doctorId;
  @override
  State<AppointmentRescheduleView> createState() =>
      _AppointmentRescheduleViewState();
}

class _AppointmentRescheduleViewState extends State<AppointmentRescheduleView> {
  final TextEditingController searchController = TextEditingController();

  final TextEditingController textController = TextEditingController();
  AppointmentController controller = Get.find<AppointmentController>();
  int selectedTab = 0;
  bool isListView = false;
  DateTime _selectedDay = DateTime.now();
  @override
  void initState() {
    super.initState();
    controller.getDoctorDetails(widget.doctorId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      appBar: CustomAppBarDoctor(
          showBackButton: false,
          profileImagePath: BaseStorage.read(StorageKeys.userImage) ?? "",
          title: (BaseStorage.read(StorageKeys.firstName) ?? "") +
              " " +
              (BaseStorage.read(StorageKeys.lastName) ?? ""),
          isNetworkImage: true),
      body: GetBuilder<AppointmentController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Appointments".tr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // CustomTextFieldWithoutText(
              //   hintText: "Search",
              //   controller: searchController,
              // ),
              // const SizedBox(height: 20),
              // Segmented Control

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(color: AppColors.borderColor)),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Back Button
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: const Icon(Icons.arrow_back,
                                        color: Colors.black54, size: 24),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Doctor's Info
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/icons/equip_icon.svg"),
                                    const SizedBox(width: 8),
                                    Text(
                                      (BaseStorage.read(
                                                  StorageKeys.firstName) ??
                                              "") +
                                          " " +
                                          (BaseStorage.read(
                                                  StorageKeys.lastName) ??
                                              ""),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff7E7E7E)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // Appointment Duration
                                Row(
                                  children: [
                                    const Icon(Icons.access_time,
                                        color: Colors.grey, size: 28),
                                    const SizedBox(width: 8),
                                    Text(
                                      "${controller.selectedSlots.length * 15} mins",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff7E7E7E)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TableCalendar(
                                  focusedDay: _selectedDay,
                                  firstDay: DateTime.now(),
                                  lastDay: DateTime.now()
                                      .add(const Duration(days: 365)),
                                  calendarFormat: CalendarFormat.month,
                                  selectedDayPredicate: (day) =>
                                      isSameDay(_selectedDay, day),
                                  enabledDayPredicate: (day) {
                                    return controller.enabledDates.contains(
                                        "${day.month < 10 ? "0${day.month}" : "${day.month}"}-${day.day < 10 ? "0${day.day}" : "${day.day}"}-${day.year}");
                                  },
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      _selectedDay = selectedDay;
                                    });
                                    controller.selectedSlots.clear();
                                    // controller.selectedSlot.value = "";
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
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    disabledTextStyle:
                                        TextStyle(color: Colors.grey),
                                  ),
                                ),
                                // TableCalendar(
                                //   focusedDay: _selectedDay,
                                //   firstDay: DateTime(2022),
                                //   lastDay: DateTime(2030),
                                //   calendarFormat: CalendarFormat.month,
                                //   selectedDayPredicate: (day) {
                                //     return isSameDay(_selectedDay, day);
                                //   },
                                //   onDaySelected: (selectedDay, focusedDay) {
                                //     setState(() {
                                //       _selectedDay = selectedDay;
                                //     });
                                //   },
                                //   headerStyle: const HeaderStyle(
                                //     formatButtonVisible: false,
                                //     titleCentered: true,
                                //   ),
                                //   calendarStyle: const CalendarStyle(
                                //     todayDecoration: BoxDecoration(
                                //       color: Colors.blueAccent,
                                //       shape: BoxShape.circle,
                                //     ),
                                //     selectedDecoration: BoxDecoration(
                                //       color: AppColors.primaryColor,
                                //       shape: BoxShape.circle,
                                //     ),
                                //   ),
                                // ),

                                Row(
                                  children: [
                                    Text(
                                      monthYearDateFormat(
                                          _selectedDay.toString()),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                controller.availableSlots[
                                            "${_selectedDay.month < 10 ? "0${_selectedDay.month}" : "${_selectedDay.month}"}-${_selectedDay.day < 10 ? "0${_selectedDay.day}" : "${_selectedDay.day}"}-${_selectedDay.year}"] !=
                                        null
                                    ? Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: controller.availableSlots[
                                                "${_selectedDay.month < 10 ? "0${_selectedDay.month}" : "${_selectedDay.month}"}-${_selectedDay.day < 10 ? "0${_selectedDay.day}" : "${_selectedDay.day}"}-${_selectedDay.year}"]!
                                            .map((slot) => timeSlot(slot))
                                            .toList(),
                                      )
                                    : Text("No available slots".tr),
                                // Wrap(
                                //   spacing: 10,
                                //   runSpacing: 10,
                                //   children: [
                                //     timeSlot("03:00pm"),
                                //     timeSlot("03:30pm"),
                                //     timeSlot("04:30pm"),
                                //     timeSlot("11:30am"),
                                //     timeSlot("05:30pm"),
                                //     timeSlot("02:30pm", selected: true),
                                //     timeSlot("05:00pm"),
                                //     timeSlot("10:30am"),
                                //   ],
                                // ),

                                const SizedBox(
                                  height: 13,
                                ),
                              ],
                            ),
                            // TableCalendar(
                            //   focusedDay: _selectedDay,
                            //   firstDay: DateTime(2022),
                            //   lastDay: DateTime(2030),
                            //   calendarFormat: CalendarFormat.month,
                            //   selectedDayPredicate: (day) {
                            //     return isSameDay(_selectedDay, day);
                            //   },
                            //   onDaySelected: (selectedDay, focusedDay) {
                            //     setState(() {
                            //       _selectedDay = selectedDay;
                            //     });
                            //   },
                            //   headerStyle: const HeaderStyle(
                            //     formatButtonVisible: false,
                            //     titleCentered: true,
                            //   ),
                            //   calendarStyle: const CalendarStyle(
                            //     todayDecoration: BoxDecoration(
                            //       color: Colors.blueAccent,
                            //       shape: BoxShape.circle,
                            //     ),
                            //     selectedDecoration: BoxDecoration(
                            //       color: AppColors.primaryColor,
                            //       shape: BoxShape.circle,
                            //     ),
                            //   ),
                            // ),
                            // const Row(
                            //   children: [
                            //     Text(
                            //       "Thursday, 10th August",
                            //       style: TextStyle(
                            //           fontSize: 14, fontWeight: FontWeight.w400),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 13,
                            // ),
                            // Wrap(
                            //   spacing: 10,
                            //   runSpacing: 10,
                            //   children: [
                            //     timeSlot("03:00pm"),
                            //     timeSlot("03:30pm"),
                            //     timeSlot("04:30pm"),
                            //     timeSlot("11:30am"),
                            //     timeSlot("05:30pm"),
                            //     timeSlot("02:30pm", selected: true),
                            //     timeSlot("05:00pm"),
                            //     timeSlot("10:30am"),
                            //   ],
                            // ),

                            const SizedBox(
                              height: 13,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                        text: "Update".tr,
                        onPressed: () {
                          if (controller.selectedSlots.isEmpty) {
                            showSnackBar(subtitle: "Please select a time slot");
                          } else {
                            String formattedDate =
                                "${_selectedDay.month < 10 ? "0${_selectedDay.month}" : _selectedDay.month}-${_selectedDay.day < 10 ? "0${_selectedDay.day}" : _selectedDay.day}-${_selectedDay.year}";
                            controller.updateAppointment(
                                doctorId: widget.doctorId,
                                date: formattedDate,
                                appointmentId: widget.appointmentId);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Expanded(
              //   child: Center(
              //           child: Container(
              //             width: 350,
              //             padding: const EdgeInsets.all(16),
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(20),
              //               boxShadow: const [
              //                 BoxShadow(
              //                   color: Colors.black12,
              //                   blurRadius: 8,
              //                   spreadRadius: 2,
              //                 ),
              //               ],
              //             ),
              //             child: Column(
              //               children: [
              //                 // Header
              //                 const Row(
              //                   children: [
              //                     CircleAvatar(
              //                       backgroundImage: AssetImage('assets/images/Ellipse 1.png'),
              //                       radius: 20,
              //                     ),
              //                     SizedBox(width: 8),
              //                     Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           "Dr. Madelyn Ve...",
              //                           style: TextStyle(fontWeight: FontWeight.bold),
              //                         ),
              //                         Text(
              //                           "Dentist",
              //                           style: TextStyle(color: Colors.grey),
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //                 const Divider(),

              //                 // Messages List
              //                 Expanded(
              //                   child: Obx(() => ListView.builder(
              //                         itemCount: controller.messages.length,
              //                         itemBuilder: (context, index) {
              //                           final message = controller.messages[index];
              //                           return _buildMessageBubble(message.text, message.isUser);
              //                         },
              //                       )),
              //                 ),

              //                 // Input Field
              //                 _buildInputField(),
              //               ],
              //             ),
              //           ),
              //         ),
              // ),

              // Expanded(
              //   child: Container(
              //     padding: const EdgeInsets.all(27),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(32),
              //       border: Border.all(color: AppColors.borderColor),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.1), // Light shadow
              //           spreadRadius: 2, // How much the shadow spreads
              //           blurRadius: 8, // Softness of the shadow
              //           offset: Offset(2, 4), // Position of the shadow (X, Y)
              //         ),
              //       ],
              //     ),
              //     child: Column(
              //       children: [

              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 26),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSegmentButton(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: selectedTab == index ? AppColors.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selectedTab == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min, // Prevents Row from taking full width
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns text and avatar properly
        children: [
          // Show avatar only for received messages
          if (!isUser)
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/Ellipse 1.png'),
              radius: 20,
            ),

          const SizedBox(width: 8), // Space between avatar and message

          Flexible(
            // Prevents overflow if text is too long
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    isUser ? Colors.lightBlue.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isUser
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: isUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timeSlot(
    String time,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          if (controller.selectedSlots.contains(time)) {
            controller.selectedSlots.remove(time);
          } else {
            controller.selectedSlots.add(time);
          }
          controller.update();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
                color: controller.selectedSlots.contains(time)
                    ? AppColors.primaryColor
                    : Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
            color: controller.selectedSlots.contains(time)
                ? AppColors.primaryColor.withOpacity(0.1)
                : Colors.white,
          ),
          child: Text(
            time,
            style: TextStyle(
                color: controller.selectedSlots.contains(time)
                    ? AppColors.primaryColor
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(
                          "assets/images/dr_img.png"), // Replace with actual image
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dr. Dr. Maurer",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Dentist",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Pharmacy A - xxx building, xxx street, xxx city",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xffDCFCE7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.access_time, color: Colors.green, size: 16),
                  SizedBox(width: 6),
                  Text(
                    "Monday  8:00 - 9:00 am",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    "July 31, 2024",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle reschedule action
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(58),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Reschedule".tr,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle cancel action
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(58),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Cancel".tr,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// Widget for displaying user profile avatars

class DateRangeSelector extends StatefulWidget {
  const DateRangeSelector({super.key});

  @override
  _DateRangeSelectorState createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<DateRangeSelector> {
  DateTime startDate = DateTime(2024, 7, 16); // Initial start date
  DateTime endDate = DateTime(2024, 7, 24); // Initial end date

  void updateDateRange(int days) {
    setState(() {
      startDate = startDate.add(Duration(days: days));
      endDate = endDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedStartDate = DateFormat('EEE MMM d').format(startDate);
    String formattedEndDate = DateFormat('EEE MMM d').format(endDate);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => updateDateRange(-7),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColorGray),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.chevron_left,
                        color: AppColors.primaryColor),
                    const SizedBox(width: 4),
                    Text(
                      "Previous 7 days".tr,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () => updateDateRange(7),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColorGray),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      "Next 7 days".tr,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right,
                        color: AppColors.primaryColor),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$formattedStartDate - $formattedEndDate",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.calendar_today_outlined,
                color: Colors.blue, size: 18),
          ],
        ),
      ],
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String imagePath;
  final double size;

  const ProfileAvatar({super.key, required this.imagePath, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.asset(imagePath, width: size, height: size),
    );
  }
}

/// Header section with profile image and options icon
class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            ProfileAvatar(imagePath: 'assets/images/temp_profile_img.png'),
            SizedBox(width: 8),
            Text(
              "Angela",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SvgPicture.asset("assets/icons/options_icon.svg"),
      ],
    );
  }
}

/// Widget for message list item
class MessageTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final bool isUnread;

  const MessageTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ProfileAvatar(imagePath: avatar, size: 56),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff94A3B8),
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8,
              ),
              if (isUnread)
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff22C55E),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "1",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// class ChatScreen extends StatelessWidget {
//   ChatScreen({super.key});

//    final ChatController controller = Get.put(ChatController());
//   final TextEditingController textController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body:
//       Center(
//         child:
//         Container(
//           width: 350,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 8,
//                 spreadRadius: 2,
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               // Header
//               Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundImage: AssetImage('assets/avatar.png'),
//                     radius: 20,
//                   ),
//                   const SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         "Dr. Madelyn Ve...",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         "Dentist",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const Divider(),

//               // Messages List
//               Expanded(
//                 child: Obx(() => ListView.builder(
//                       itemCount: controller.messages.length,
//                       itemBuilder: (context, index) {
//                         final message = controller.messages[index];
//                         return _buildMessageBubble(message.text, message.isUser);
//                       },
//                     )),
//               ),

//               // Input Field
//               _buildInputField(),
//             ],
//           ),
//         ),
//       ),

//     );
//   }

//   Widget _buildMessageBubble(String text, bool isUser) {
//     return Align(
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isUser ? Colors.lightBlue.shade100 : Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(text),
//       ),
//     );
//   }

//   Widget _buildInputField() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.link),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.image),
//             onPressed: () {},
//           ),
//           Expanded(
//             child: TextField(
//               controller: textController,
//               decoration: const InputDecoration(
//                 hintText: "Type a message...",
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send, color: Colors.blue),
//             onPressed: () {
//               if (textController.text.isNotEmpty) {
//                 controller.sendMessage(textController.text, true);
//                 textController.clear();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

// }

class ChatController extends GetxController {
  var messages = <Message>[].obs; // Observable list of messages

  void sendMessage(String text, bool isUser) {
    if (text.trim().isEmpty) return;
    messages.add(Message(text: text, isUser: isUser));

    // Simulating a bot reply after a delay
    if (isUser) {
      Future.delayed(const Duration(seconds: 1), () {
        messages.add(Message(text: "Thanks for your message!", isUser: false));
      });
    }
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}
