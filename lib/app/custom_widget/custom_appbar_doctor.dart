import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/modules/profile/menu_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';

class CustomAppBarDoctor extends StatelessWidget
    implements PreferredSizeWidget {
  final bool showBackButton;
  final String profileImagePath;
  final bool isNetworkImage;
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final void Function()? onPressed;

  const CustomAppBarDoctor(
      {super.key,
      this.showBackButton = true, // Default to show back button
      this.profileImagePath = 'assets/images/dr_img.png',
      this.title = "Dr. Dr. Maurer",
      this.actions,
      this.backgroundColor,
      this.isNetworkImage = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.grayBackground,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: onPressed ?? () => Navigator.pop(context),
            )
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Visibility(
                visible: !isNetworkImage,
                replacement: cachedNetworkImage(
                    image: profileImagePath,
                    height: 40,
                    width: 40,
                    isProfile: true,
                    borderRadius: 100),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(profileImagePath),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(
              children: actions ??
                  [
                    InkWell(
                        onTap: () {
                          Get.back();
                          Get.to(const MenuScreen());
                        },
                        child:
                            SvgPicture.asset("assets/icons/options_icon.svg"))
                  ]),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
