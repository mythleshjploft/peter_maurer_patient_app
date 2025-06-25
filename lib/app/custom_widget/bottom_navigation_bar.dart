import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/home_controller.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const CustomBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(33), topRight: Radius.circular(33)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: const Offset(0, -2), // Offset to top
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildNavItem("assets/icons/bottom_01.svg", "", () => onTap(0),
              currentIndex == 0),
          buildNavItem("assets/icons/bottom_02.svg", "", () => onTap(1),
              currentIndex == 1),
          buildNavItem("assets/icons/bottom_03.svg", "", () => onTap(2),
              currentIndex == 2,
              isIcon: true),
          buildNavItem(
            "assets/icons/bottom_04.svg",
            "",
            () => onTap(3),
            currentIndex == 3,
          ),
          // buildNavItem(userImagePublic, AppLocalizations.of(context)!.account, () => onTap(3), currentIndex == 3, isImage: true),
        ],
      ),
    );
  }

  Widget buildNavItem(
      String iconsPath, String label, VoidCallback onTap, bool isSelected,
      {bool? isImage, bool? isIcon}) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 46,
              height: 46,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor.withOpacity(0.42)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30)),
              child: (isIcon ?? false)
                  ? Transform.translate(
                      offset: const Offset(-3, -4),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Icons.notifications,
                            color: isSelected
                                ? AppColors.black
                                : const Color(0XFFCFCFCF),
                            size: 30,
                          ),
                          Obx(() => Visibility(
                                visible: (Get.find<HomeController>()
                                            .homeScreenData
                                            .value
                                            ?.notificationCount
                                            ?.toString() ??
                                        "0") !=
                                    "0",
                                child: Positioned(
                                  top: 0,
                                  right: -10,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle),
                                    height: 15,
                                    width: 15,
                                    child: Center(
                                      child: Text(
                                        "${Get.find<HomeController>().homeScreenData.value?.notificationCount ?? "0"}",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: BaseColors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                  : SvgPicture.asset(
                      iconsPath,
                      color: isSelected
                          ? AppColors.black
                          : const Color(0XFFCFCFCF),
                    ),
            ),
          ),
          //Icon(icon,color: isSelected?ColorsUtil.primaryColor:ColorsUtil.unSelectedIconColor ),
          // Text(
          //   label,
          //   style: TextStyle(
          //       color: isSelected ? AppColors.primaryColor : Color(0XFFCFCFCF),
          //       fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          //       fontSize: 11),
          // ),
        ],
      ),
    );
  }
}
