import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final String? Function(String?)? validator;
  final bool readOnly;
  final void Function()? onTap;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.validator,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              hintText.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          onTap: onTap,
          obscureText: isPassword,
          readOnly: readOnly,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            hintText: hintText.tr,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
            suffixIcon: suffixIcon != null
                ? IconButton(icon: Icon(suffixIcon), onPressed: onSuffixTap)
                : null,
          ),
        ),
      ],
    );
  }
}

class CustomTextFieldWithoutText extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final void Function(String)? onChanged;
  const CustomTextFieldWithoutText({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      cursorColor: Colors.black,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true, // Enables background color
        fillColor: Colors.white, // B
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        hintText: hintText.tr,

        hintStyle: const TextStyle(color: Color(0xffCFCFCF)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: AppColors.borderColor), // Default border color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: AppColors.borderColor), // Border color when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ), // Border color when focused
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ), // Border color on error
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(icon: Icon(suffixIcon), onPressed: onSuffixTap)
            : null,
      ),
    );
  }
}
