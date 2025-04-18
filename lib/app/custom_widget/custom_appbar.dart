import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;
  final VoidCallback? onActionPress;
  final IconData actionIcon;
  final List<Widget>? actions;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.onBackPress,
      this.onActionPress,
      this.actionIcon = Icons.refresh, // Default action icon
      this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: onBackPress ?? () => Navigator.pop(context),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
