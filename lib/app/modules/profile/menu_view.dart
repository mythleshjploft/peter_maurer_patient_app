import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar_doctor.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/dashboard_view.dart';
import 'package:peter_maurer_patients_app/app/modules/appointment/apppointment_List_view.dart';
import 'package:peter_maurer_patients_app/app/modules/dashboard/doctor_search_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarDoctor(
        showBackButton: false,
        profileImagePath: BaseStorage.read(StorageKeys.userImage) ?? "",
        title:
            "${(BaseStorage.read(StorageKeys.firstName) ?? "")} ${(BaseStorage.read(StorageKeys.lastName) ?? "")}",
        isNetworkImage: true,
        backgroundColor: AppColors.white,
        actions: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(Icons.close, color: AppColors.white, size: 28),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menu Items
            _buildMenuItem('assets/icons/home_icon.svg', "Dashboard",
                onTap: () {
              Get.offAll(() => const DashBoardView());
            }),
            _buildMenuItem('assets/icons/home_icon.svg', "Doctor", onTap: () {
              Get.to(const DoctorSearchView());
            }),
            _buildMenuItem('assets/icons/history.svg', "Appointments History",
                onTap: () {
              Get.to(const ApppointmentListView());
            }),
            _buildMenuItem('assets/icons/profile_icon.svg', "Profile",
                onTap: () {
              Get.offAll(() => const DashBoardView(index: 3));
            }),
            _buildMenuItem('assets/icons/logout_icon_v1.svg', "Log Out",
                onTap: () {
              clearSessionData();
            }),
          ],
        ),
      ),
    );
  }

  // Menu Item Widget
  Widget _buildMenuItem(String icon, String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.primaryColor
                  .withOpacity(0.19), // Change the color as needed
              width: 1.0, // Adjust thickness
            ),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            child: SvgPicture.asset(icon),
          ),
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
