import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;
  final VoidCallback? onActionPress;
  final IconData actionIcon;
  final List<Widget>? actions;
  final bool? showBackButton;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.onBackPress,
      this.onActionPress,
      this.actionIcon = Icons.refresh, // Default action icon
      this.actions,
      this.showBackButton});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: (showBackButton ?? true) ? 40 : 0,
        leading: Visibility(
          visible: showBackButton ?? true,
          replacement: const SizedBox.shrink(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: onBackPress ?? () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          title.tr,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
