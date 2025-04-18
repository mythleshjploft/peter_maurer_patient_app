import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/doctor_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar_doctor.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_bottom_sheet.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/modules/details/details_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_no_data.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DoctorSearchView extends StatefulWidget {
  const DoctorSearchView({super.key});

  @override
  State<DoctorSearchView> createState() => _DoctorSearchViewState();
}

class _DoctorSearchViewState extends State<DoctorSearchView> {
  final TextEditingController searchController = TextEditingController();

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const CustomBottomSheet();
      },
    );
  }

  DoctorController controller = Get.isRegistered<DoctorController>()
      ? Get.find<DoctorController>()
      : Get.put(DoctorController());

  @override
  void initState() {
    super.initState();
    controller.getDoctorList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      appBar: CustomAppBarDoctor(
        backgroundColor: const Color(0xffF8F8F8),
        showBackButton: false,
        profileImagePath: BaseStorage.read(StorageKeys.userImage) ?? "",
        title: (BaseStorage.read(StorageKeys.firstName) ?? "") +
            " " +
            (BaseStorage.read(StorageKeys.lastName) ?? ""),
        isNetworkImage: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SmartRefresher(
          controller: controller.refreshController,
          header: const WaterDropHeader(waterDropColor: AppColors.primaryColor),
          onRefresh: () => controller.getDoctorList(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                CustomTextFieldWithoutText(
                  hintText: "Search",
                  controller: searchController,
                  onChanged: (val) {
                    controller.filterDoctors(val);
                  },
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
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.filteredDoctorList.isEmpty) {
                    return const BaseNoData();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.filteredDoctorList.length,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      cachedNetworkImage(
                                          image: controller
                                                  .filteredDoctorList[index]
                                                  ?.image
                                                  ?.toString() ??
                                              "",
                                          height: 50,
                                          width: 50,
                                          borderRadius: 100),
                                      const SizedBox(width: 12),
                                      Flexible(
                                        child: Text(
                                          "${controller.filteredDoctorList[index]?.firstName?.toString() ?? ""} ${controller.filteredDoctorList[index]?.lastName?.toString() ?? ""}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                      controller.filteredDoctorList[index]
                                              ?.specialist
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
                                Get.to(() => DoctorDetailsView(
                                    id: controller.filteredDoctorList[index]?.id
                                            ?.toString() ??
                                        ""));
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
                  );
                }),
                buildSizeHeight(100),
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
        ),
      ),
    );
  }
}
