import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/doctor_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_bottom_sheet.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/modules/chat/chat_view.dart';
import 'package:peter_maurer_patients_app/app/modules/details/details_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';

class DoctorSearchView extends StatefulWidget {
  const DoctorSearchView({super.key});

  @override
  State<DoctorSearchView> createState() => _DoctorSearchViewState();
}

class _DoctorSearchViewState extends State<DoctorSearchView> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> upcomingAppointments = [
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "8 Years",
      "time": "",
      "duration": "Details",
      "image": "assets/images/dr_img.png"
    },
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "8 Years",
      "time": "",
      "duration": "Details",
      "image": "assets/images/dr_img.png"
    },
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "8 Years",
      "time": "",
      "duration": "Details",
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

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CustomBottomSheet();
      },
    );
  }

  DoctorController controller = Get.put(DoctorController());

  @override
  void initState() {
    super.initState();
    controller.getDoctorList();
  }

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

                  const SizedBox(height: 16),
                  CustomTextFieldWithoutText(
                    hintText: "Search",
                    controller: searchController,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Doctors",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      InkWell(
                          onTap: () {
                            _showCustomBottomSheet(context);
                          },
                          child: SvgPicture.asset(
                              "assets/icons/filter_icon_new.svg"))
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.doctorList?.length ?? 0,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.borderColor)
                            // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                            ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      cachedNetworkImage(
                                          image: controller
                                                  .doctorList?[index]?.image
                                                  ?.toString() ??
                                              "",
                                          height: 50,
                                          width: 50,
                                          borderRadius: 100),
                                      const SizedBox(width: 12),
                                      Text(
                                          "${controller.doctorList?[index]?.firstName?.toString() ?? ""} ${controller.doctorList?[index]?.lastName?.toString() ?? ""}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                      controller.doctorList?[index]?.specialist
                                              ?.toString() ??
                                          "",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.grayMedium)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/time_icon_new.svg'),
                                      const SizedBox(width: 4),
                                      const Text("8 years",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.grayMedium)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(DoctorDetailsView());
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text("Details",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Column(
                  //   children: upcomingAppointments.map((appointment) {
                  //     return Container(
                  //       margin: const EdgeInsets.only(bottom: 12),
                  //       padding: const EdgeInsets.all(12),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20),
                  //           border: Border.all(color: AppColors.borderColor)
                  //           // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  //           ),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.end,
                  //         children: [
                  //           Expanded(
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Row(
                  //                   children: [
                  //                     CircleAvatar(
                  //                       radius: 28,
                  //                       backgroundImage:
                  //                           AssetImage(appointment["image"]),
                  //                     ),
                  //                     const SizedBox(width: 12),
                  //                     Text(appointment["name"],
                  //                         style: const TextStyle(
                  //                             fontWeight: FontWeight.bold,
                  //                             fontSize: 16)),
                  //                   ],
                  //                 ),
                  //                 const SizedBox(height: 4),
                  //                 Text(appointment["specialty"],
                  //                     style: const TextStyle(
                  //                         fontSize: 14,
                  //                         color: AppColors.grayMedium)),
                  //                 const SizedBox(height: 4),
                  //                 Row(
                  //                   children: [
                  //                     SvgPicture.asset(
                  //                         'assets/icons/time_icon_new.svg'),
                  //                     const SizedBox(width: 4),
                  //                     Text(
                  //                         "${appointment["date"]} ${appointment["time"]}",
                  //                         style: const TextStyle(
                  //                             fontSize: 14,
                  //                             color: AppColors.grayMedium)),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           InkWell(
                  //             onTap: () {
                  //               Get.to(DoctorDetailsView());
                  //             },
                  //             child: Container(
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: 12, vertical: 6),
                  //               decoration: BoxDecoration(
                  //                 color: AppColors.primaryColor,
                  //                 borderRadius: BorderRadius.circular(20),
                  //               ),
                  //               child: Text(appointment["duration"],
                  //                   style: const TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.w500)),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                  // // SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     Text("Past Appointment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  //   ],
                  // ),
                  // SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
