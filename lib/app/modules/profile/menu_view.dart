import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar_doctor.dart';
import 'package:peter_maurer_patients_app/app/modules/appointment/apppointment_List_view.dart';
import 'package:peter_maurer_patients_app/app/modules/dashboard/doctor_search_view.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: CustomAppBarDoctor(
          backgroundColor: Colors.white,
        showBackButton: false,
        actions: [
            InkWell(
                    onTap:() => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(50)
                        ),
                      child: const Icon(Icons.close, color: AppColors.white, size: 28),
                     
                    ),
                  ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric( vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           

            // Menu Items
            _buildMenuItem('assets/icons/home_icon.svg', "Dashboard", onTap: () {}),
            _buildMenuItem('assets/icons/home_icon.svg', "Doctor", onTap: () {
               Get.to(DoctorSearchView());
            }),
            _buildMenuItem('assets/icons/history.svg', "Appointments History", onTap: () {
              Get.to(ApppointmentListView());
            }),
            _buildMenuItem('assets/icons/profile_icon.svg', "Profile", onTap: () {}),
            _buildMenuItem('assets/icons/logout_icon_v1.svg', "Log Out", onTap: () {}),
          ],
        ),
      ),
    );
  }

  // Menu Item Widget
  Widget _buildMenuItem(String icon, String title, {VoidCallback? onTap}) {
    return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20,),
      child: Container(
      
          decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppColors.primaryColor.withOpacity(0.19), // Change the color as needed
          width: 1.0, // Adjust thickness
        ),
      ),
        ),
        
        padding: const EdgeInsets.only(bottom: 10,top: 10),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            child: SvgPicture.asset(icon),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
