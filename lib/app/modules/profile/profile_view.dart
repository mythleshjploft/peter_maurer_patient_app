import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/profile_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar.dart';
import 'package:peter_maurer_patients_app/app/modules/profile/personal_info.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_no_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// Import the reusable AppBar widget

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController controller = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    controller.getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Profile",
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                  onTap: () {
                    clearSessionData();
                  },
                  child: SvgPicture.asset(
                    "assets/icons/logout_icon.svg",
                  )),
            )
          ],
          onActionPress: () {
            // Add action button functionality here
          },
          onBackPress: () {}),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if ((controller.profileData?.value?.id?.toString() ?? "") == "") {
          return const BaseNoData();
        }
        return SmartRefresher(
          controller: controller.refreshController,
          header: const WaterDropHeader(waterDropColor: AppColors.primaryColor),
          onRefresh: () {
            controller.getProfileDetails();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xffBAF0FF), Color(0xffF3FFE0)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      // borderRadius: const BorderRadius.only(
                      //   bottomLeft: Radius.circular(20),
                      //   bottomRight: Radius.circular(20),
                      // ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        GestureDetector(
                          onTap: () {
                            showMediaPicker(
                                    isCropEnabled: true,
                                    showGalleryOption: true)
                                .then((value) {
                              if ((value?.path ?? "").isNotEmpty) {
                                controller.updateProfileImage(
                                    image: value ?? File(""));
                              }
                            });
                          },
                          child: cachedNetworkImage(
                              image: controller.profileData?.value?.image ?? "",
                              borderRadius: 100,
                              height: 100,
                              width: 100),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (controller.profileData?.value?.firstName ?? "") +
                              " " +
                              (controller.profileData?.value?.lastName ?? ""),
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          (controller.profileData?.value?.email ?? ""),
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.grayMedium),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),

                  // Personal Info Card
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Personal Info".tr,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.nameController.text = controller
                                          .profileData?.value?.firstName ??
                                      "";
                                  controller.lastNameController.text =
                                      controller.profileData?.value?.lastName ??
                                          "";
                                  controller.selectedGender =
                                      controller.profileData?.value?.gender ??
                                          "";
                                  controller.dobController.text = controller
                                          .profileData?.value?.dob
                                          ?.toString() ??
                                      "";
                                  controller.emailController.text =
                                      controller.profileData?.value?.email ??
                                          "";
                                  controller.phoneController.text = controller
                                          .profileData?.value?.mobileNumber ??
                                      "";
                                  controller.zipCodeController.text =
                                      controller.profileData?.value?.zipCode ??
                                          "";
                                  controller.countryCode.value = controller
                                          .profileData?.value?.countryCode ??
                                      "";
                                  controller.selectedCity = null;
                                  controller.selectedCountry = null;
                                  Get.to(const PersonalInfo());
                                },
                                child: Text("Edit".tr,
                                    style: const TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                          const Divider(),
                          _infoRow(
                            "Name",
                            (controller.profileData?.value?.firstName ?? "") +
                                " " +
                                (controller.profileData?.value?.lastName ?? ""),
                          ),
                          _infoRow(
                              "Gender",
                              controller.profileData?.value?.gender
                                      ?.toString() ??
                                  ""),
                          _infoRow("Phone no",
                              "${controller.profileData?.value?.countryCode?.toString() ?? ""} ${controller.profileData?.value?.mobileNumber?.toString() ?? ""}"),
                          _infoRow(
                              "Email",
                              controller.profileData?.value?.email
                                      ?.toString() ??
                                  ""),
                          _infoRow(
                              "Date of birth",
                              controller.profileData?.value?.dob?.toString() ??
                                  ""),
                          _infoRow(
                              "Country",
                              controller.profileData?.value?.countryId?.name
                                      ?.toString() ??
                                  ""),
                          _infoRow(
                              "City",
                              controller.profileData?.value?.cityId?.name
                                      ?.toString() ??
                                  ""),
                          _infoRow(
                              "Zip code",
                              controller.profileData?.value?.zipCode
                                      ?.toString() ??
                                  ""),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // Helper Widget for Displaying Info Rows
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  color: AppColors.headingColor, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(color: AppColors.grayDark)),
        ],
      ),
    );
  }
}
