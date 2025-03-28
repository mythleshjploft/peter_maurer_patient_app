import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSocialButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomSocialButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          side: const BorderSide(color: Colors.grey),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imagePath, height: 24), // Google/Facebook icon
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xff020202).withOpacity(0.50)),
            ),
          ],
        ),
      ),
    );
  }
}
