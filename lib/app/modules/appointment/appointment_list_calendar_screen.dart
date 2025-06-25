import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/appointment_controller.dart';

class AppointmentListCalendarScreen extends StatefulWidget {
  const AppointmentListCalendarScreen({super.key});

  @override
  State<AppointmentListCalendarScreen> createState() =>
      _AppointmentListCalendarScreenState();
}

class _AppointmentListCalendarScreenState
    extends State<AppointmentListCalendarScreen> {
  AppointmentController controller = Get.find<AppointmentController>();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startDate = now;

    // _eventController.add(
    //   CalendarEventData(
    //     date: now,
    //     event: "Dr Peter",
    //     title: "Dr Peter",
    //     description: "Consultation",
    //     startTime: DateTime(now.year, now.month, now.day, 1, 0), // 01:00 AM
    //     endTime: DateTime(now.year, now.month, now.day, 2, 0), // 02:00 AM
    //     color: Colors.blue,
    //   ),
    // );
    return Expanded(
      child: Column(
        children: [
          // const DateRangeSelector(),
          // const SizedBox(
          //   height: 16,
          // ),
          Expanded(
              child: Obx(
            () => WeekView(
              controller: controller.eventController.value,
              initialDay: now,
              minDay: startDate,
              heightPerMinute: 1.5,
              eventTileBuilder:
                  (date, events, boundRect, startDuration, endDuration) {
                final event = events.first;
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(event.title),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "From: ${DateFormat('EEE MMM d HH:mm a').format(event.startTime ?? DateTime.now())}"),
                            Text(
                                "To: ${DateFormat('EEE MMM d HH:mm a').format(event.endTime ?? DateTime.now())}"),
                            // if (event.description != null)
                            //   Text("Description: ${event.description}"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Close".tr),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: event.color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        event.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 7,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
              // 🕒 Custom time on left in HH:mm format
              timeLineBuilder: (date) {
                final formatted = DateFormat('HH:mm').format(date);
                return Container(
                  alignment: Alignment.centerRight,
                  width: 60,
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(
                    formatted,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                );
              },

              weekDayBuilder: (date) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(
                    DateFormat('EEE MMM d').format(date),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                );
              },

              hourIndicatorSettings: HourIndicatorSettings(
                // interval: Duration(hours: 1), // Hourly indicators
                color: Colors.grey.shade300,
              ),
              showLiveTimeLineInAllDays: true,
              headerStringBuilder: (DateTime date, {DateTime? secondaryDate}) =>
                  "${DateFormat('EEE, MMM d').format(date)} - ${secondaryDate != null ? DateFormat('EEE, MMM d').format(secondaryDate) : ""}",
              headerStyle: const HeaderStyle(
                  decoration: BoxDecoration(color: Colors.transparent)),
              // 🔷 Custom event appearance (wider + styled)
              // eventTileBuilder:
              //     (date, events, boundRect, startDuration, endDuration) {
              //   final event = events.first;

              //   return Container(
              //     padding: const EdgeInsets.all(6),
              //     decoration: BoxDecoration(
              //       color: event.color,
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Text(
              //       event.title,
              //       style: const TextStyle(
              //           color: Colors.white, fontWeight: FontWeight.w600),
              //     ),
              //   );
              // },
            ),
          ))
          // Expanded(child: ScheduleScreen()),
        ],
      ),
    );
  }
}

class DateRangeSelector extends StatefulWidget {
  const DateRangeSelector({super.key});

  @override
  State<DateRangeSelector> createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<DateRangeSelector> {
  DateTime startDate = DateTime.now(); // Initial start date
  DateTime endDate =
      DateTime.now().add(const Duration(days: 7)); // Initial end date

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
        const SizedBox(height: 16),
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
