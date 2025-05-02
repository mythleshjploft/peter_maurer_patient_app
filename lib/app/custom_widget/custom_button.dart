import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: onPressed,
        child: Text(text.tr,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
