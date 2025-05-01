import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/appointment_controller.dart';
import 'package:peter_maurer_patients_app/app/models/appointment_screen/appointment_history_reponse.dart';
import 'package:peter_maurer_patients_app/app/modules/appointment/appointment_reschedule_view.dart';
import 'package:peter_maurer_patients_app/app/modules/appointment/appointment_webview.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';

class AppointCardListScreen extends StatefulWidget {
  const AppointCardListScreen({super.key});

  @override
  State<AppointCardListScreen> createState() => _AppointCardListScreenState();
}

class _AppointCardListScreenState extends State<AppointCardListScreen> {
  AppointmentController controller = Get.find<AppointmentController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.filteredAppointmentList.length,
              itemBuilder: (context, index) {
                var appointment = controller.filteredAppointmentList[index];
                return AppointmentCard(
                  appointmentDatum: appointment,
                );
              },
            );
          }),
          // const AppointmentCard(),
          const SizedBox(
            height: 4,
          ),
          // const AppointmentCardOtherType()
        ],
      ),
    ));
  }
}

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key, required this.appointmentDatum});
  final AppointmentData appointmentDatum;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  AppointmentController controller = Get.find<AppointmentController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // controller.updateStatus(
                          //     id: widget.appointmentDatum.id?.toString() ?? "",
                          //     status: "Pending");
                        },
                        child: cachedNetworkImage(
                            image: widget.appointmentDatum.doctorId?.image
                                    ?.toString() ??
                                "",
                            height: 55,
                            width: 55,
                            borderRadius: 100),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: (widget.appointmentDatum.status?.toString() ??
                                      "") ==
                                  "Pending"
                              ? Colors.yellow.withOpacity(0.40)
                              : (widget.appointmentDatum.status?.toString() ??
                                          "") ==
                                      "Canceled"
                                  ? Colors.red.withOpacity(0.2)
                                  : const Color(0xffDCFCE7),
                          border: Border.all(
                              color:
                                  (widget.appointmentDatum.status?.toString() ??
                                              "") ==
                                          "Pending"
                                      ? Colors.yellow.withOpacity(0.40)
                                      : (widget.appointmentDatum.status
                                                      ?.toString() ??
                                                  "") ==
                                              "Canceled"
                                          ? Colors.red.withOpacity(0.4)
                                          : const Color(0xffDCFCE7)),
                          borderRadius: BorderRadius.circular(58),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.appointmentDatum.status?.toString() ?? "",
                          style: TextStyle(
                              fontSize: 15,
                              color:
                                  (widget.appointmentDatum.status?.toString() ??
                                              "") ==
                                          "Pending"
                                      ? Colors.black
                                      : (widget.appointmentDatum.status
                                                      ?.toString() ??
                                                  "") ==
                                              "Canceled"
                                          ? Colors.red
                                          : const Color(0xff16A34A)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "${widget.appointmentDatum.doctorId?.firstName?.toString() ?? ""} ${widget.appointmentDatum.doctorId?.lastName?.toString() ?? ""}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.appointmentDatum.doctorId?.image?.toString() ?? "",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  // Text(
                  //   "${widget.appointmentDatum.doctorId?.city?.toString() ?? ""}, ${widget.appointmentDatum.doctorId?.country?.toString() ?? ""}",
                  //   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  // )
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xffDCFCE7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time,
                        color: Colors.green, size: 16),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        showBaseDialgueBox(
                          title: const Text("Slot Details"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  getSlots(widget.appointmentDatum.slots ?? []),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 8),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        "${getDayOfWeek(widget.appointmentDatum.date?.toString() ?? "")}     View Slot",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      monthYearDateFormat(
                          widget.appointmentDatum.date?.toString() ?? ""),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Visibility(
                visible: controller.selectedTab.value == 0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(AppointmentRescheduleView(
                            appointmentId:
                                widget.appointmentDatum.id?.toString() ?? "",
                            patientId:
                                widget.appointmentDatum.patientId?.toString() ??
                                    "",
                            doctorId: widget.appointmentDatum.doctorId?.id
                                    ?.toString() ??
                                "",
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(58),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Reschedule",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    buildSizeWidth(10),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          controller.updateStatus(
                              id: widget.appointmentDatum.id?.toString() ?? "",
                              status: "Canceled");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(58),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Cancel Appointment",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.selectedTab.value == 0,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => AppointmentWebViewScreen(
                        url:
                            //  "https://pub.dev/packages/webview_flutter"
                            "http://3.109.98.222:7902/noteForm/${widget.appointmentDatum.id}"));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(58),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Fill Form",
                      style: TextStyle(fontSize: 14, color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getSlots(List<dynamic> slots) {
    String time = "";
    if (slots.isEmpty) {
      return time;
    }
    if (slots.isNotEmpty) {
      List<String> timeSlots = [];
      for (var slot in slots) {
        timeSlots
            .add("${slot.startTime?.toString()} - ${slot.endTime?.toString()}");
      }
      time = timeSlots.join(", ");
      return time;
    }
  }
}

// class AppointmentCardOtherType extends StatelessWidget {
//   const AppointmentCardOtherType({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 24,
//                       backgroundImage: AssetImage(
//                           "assets/images/dr_img.png"), // Replace with actual image
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 const Text(
//                   "Dr. Dr. Maurer",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   "Dentist",
//                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   "Pharmacy A - xxx building, xxx street, xxx city",
//                   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                 )
//               ],
//             ),
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: const Color(0xffDCFCE7),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Row(
//                 children: [
//                   Icon(Icons.access_time, color: Colors.green, size: 16),
//                   SizedBox(width: 6),
//                   Text(
//                     "Monday  8:00 - 9:00 am",
//                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
//                   ),
//                   Spacer(),
//                   Text(
//                     "July 31, 2024",
//                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       //  showRescheduleDialog(context);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       decoration: BoxDecoration(
//                         color: const Color(0xffDCFCE7),
//                         border: Border.all(color: const Color(0xffDCFCE7)),
//                         borderRadius: BorderRadius.circular(58),
//                       ),
//                       alignment: Alignment.center,
//                       child: const Text(
//                         "Confirmed",
//                         style:
//                             TextStyle(fontSize: 15, color: Color(0xff16A34A)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       // Get.to(const AppointmentRescheduleView());
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryColor,
//                         borderRadius: BorderRadius.circular(58),
//                       ),
//                       alignment: Alignment.center,
//                       child: const Text(
//                         "Reschedule",
//                         style: TextStyle(fontSize: 15, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
