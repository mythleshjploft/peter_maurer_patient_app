import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/home_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar_doctor.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/modules/details/details_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_no_data.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final TextEditingController searchController = TextEditingController();
  HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    controller.getHomeScreenData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      appBar: CustomAppBarDoctor(
          showBackButton: false,
          profileImagePath: BaseStorage.read(StorageKeys.userImage) ?? "",
          title:
              "${(BaseStorage.read(StorageKeys.firstName) ?? "")} ${(BaseStorage.read(StorageKeys.lastName) ?? "")}",
          isNetworkImage: true),
      body: SmartRefresher(
        controller: controller.refreshController,
        header: const WaterDropHeader(waterDropColor: AppColors.primaryColor),
        onRefresh: () {
          controller.getHomeScreenData();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
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
                        Text(
                          "${BaseStorage.read(StorageKeys.firstName) ?? ""} ${BaseStorage.read(StorageKeys.lastName) ?? ""}",
                          style: const TextStyle(
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
                      suffixIcon: Icons.search,
                      onChanged: (val) {
                        controller.filterAppointments(val);
                      },
                    ),
                    const SizedBox(height: 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Book Your Appointment".tr,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: CustomButton(
                            text: "Book Now".tr,
                            onPressed: () {
                              Get.to(() => const DoctorDetailsView(
                                    id: "67ecd39be7a9300a7839e2c7",
                                    isFromDashboard: true,
                                  ));
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("My Appointment".tr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        // SizedBox(
                        //   width: 100,
                        //   child: CustomButton(
                        //     text: "Book",
                        //     onPressed: () {
                        //       Get.to(() => const DoctorDetailsView(
                        //             id: "67ecd39be7a9300a7839e2c7",
                        //             isFromDashboard: true,
                        //           ));
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Obx(() {
                      if (controller.isHomeLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (controller.filteredAppointments.isEmpty) {
                        return const BaseNoData(
                            size: 40, message: "No Appointment Found");
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.filteredAppointments.length,
                          physics: const ScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: AppColors.borderColor)
                                  // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                                  ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            cachedNetworkImage(
                                                image: controller
                                                        .filteredAppointments[
                                                            index]
                                                        .doctorId
                                                        ?.image
                                                        ?.toString() ??
                                                    "",
                                                height: 50,
                                                width: 50,
                                                borderRadius: 100),
                                            const SizedBox(width: 12),
                                            Text(
                                                "${controller.filteredAppointments[index].doctorId?.firstName?.toString() ?? ""} ${controller.filteredAppointments[index].doctorId?.lastName?.toString() ?? ""}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                            controller
                                                    .filteredAppointments[index]
                                                    .doctorId
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
                                            Text(
                                                "${controller.filteredAppointments[index].date?.toString() ?? ""} ${controller.filteredAppointments[index].slot["start_time"]?.toString() ?? ""} - ${controller.homeScreenData.value?.appointemnt?[index].slot["end_time"]?.toString() ?? ""}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        AppColors.grayMedium)),
                                          ],
                                        ),
                                        buildSizeHeight(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                  controller
                                                          .filteredAppointments[
                                                              index]
                                                          .slotDuration
                                                          ?.toString() ??
                                                      "",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Past Appointment".tr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(),
                height: 220,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xffBAF0FF), Color(0xffF3FFE0)],
                  ),
                ),
                child: Obx(() {
                  if (controller.isHomeLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller
                          .homeScreenData.value?.pastAppointment?.isEmpty ??
                      true) {
                    return const BaseNoData(
                        size: 40, message: "No Past Appointment Found");
                  }
                  return ListView.builder(
                      itemCount: controller
                              .homeScreenData.value?.pastAppointment?.length ??
                          0,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final pastAppointment = controller
                            .homeScreenData.value?.pastAppointment?[index];
                        return Container(
                          width: 180,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              cachedNetworkImage(
                                  image: pastAppointment?.doctorId?.image
                                          ?.toString() ??
                                      "",
                                  height: 50,
                                  width: 50,
                                  borderRadius: 100),
                              const SizedBox(height: 8),
                              Text(
                                  "${pastAppointment?.doctorId?.firstName?.toString() ?? ""} ${pastAppointment?.doctorId?.lastName?.toString() ?? ""}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(height: 4),
                              Text(
                                  pastAppointment?.doctorId?.specialist
                                          ?.toString() ??
                                      "",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                    monthYearDateFormat(
                                        pastAppointment?.date?.toString() ??
                                            ""),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        );
                      });
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Daily Read".tr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => Container(
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
                            Visibility(
                              visible: !controller.isHomeLoading.value,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      controller
                                              .homeScreenData.value?.blog?.title
                                              ?.toString() ??
                                          "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  const SizedBox(height: 12),
                                  cachedNetworkImage(
                                      image: controller
                                              .homeScreenData.value?.blog?.image
                                              ?.toString() ??
                                          "",
                                      height: 230,
                                      width: double.infinity,
                                      borderRadius: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
