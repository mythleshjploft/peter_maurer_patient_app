import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/modules/profile/menu_view.dart';


class CustomAppBarDoctor extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final String profileImagePath;
  final String title;
  final List<Widget>? actions;
  Color? backgroundColor;

   CustomAppBarDoctor({
    super.key,
    this.showBackButton = true, // Default to show back button
    this.profileImagePath = 'assets/images/temp_profile_img.png',
    this.title  = "Dr. Dr. Maurer",
    this.actions,
    this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
   backgroundColor:backgroundColor?? AppColors.grayBackground,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(profileImagePath),
              ),
              const SizedBox(width: 8),
               Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(children: actions ?? [InkWell(
            onTap: (){
              Get.to(MenuScreen());
            },
            child: SvgPicture.asset("assets/icons/options_icon.svg"))]),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
