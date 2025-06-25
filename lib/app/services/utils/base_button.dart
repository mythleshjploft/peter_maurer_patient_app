import 'package:flutter/material.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_colors.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final double? btnHeight, btnWidth;
  final double? borderRadius, fontSize;
  final double? bottomMargin, topMargin, rightMargin, leftMargin;
  final EdgeInsetsGeometry? padding;
  final Color? btnColor, titleColor;
  final bool? enableHapticFeedback, hideKeyboard, hideBorder;
  final void Function()? onPressed;

  const BaseButton({
    super.key,
    required this.title,
    this.btnHeight,
    this.btnWidth,
    this.btnColor,
    this.onPressed,
    this.bottomMargin,
    this.topMargin,
    this.rightMargin,
    this.leftMargin,
    this.titleColor,
    this.enableHapticFeedback,
    this.hideKeyboard,
    this.padding,
    this.hideBorder,
    this.borderRadius,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (enableHapticFeedback ?? true) {}
        if (hideKeyboard ?? true) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          right: rightMargin ?? 10,
          left: leftMargin ?? 10,
          top: topMargin ?? 0,
          bottom: bottomMargin ?? 0,
        ),
        decoration: BoxDecoration(
          gradient: btnColor == null ? BaseColors.gradient : null,
          color: btnColor ?? AppColors.primaryColor,
          border: Border.all(
            color: btnColor != null
                ? hideBorder ?? false
                    ? BaseColors.greyColorLight
                    : AppColors.primaryColor
                : Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 14),
        ),
        padding: padding,
        height: btnHeight ?? 60,
        width: btnWidth ?? double.infinity,
        child: Center(
          child: AbsorbPointer(
            child: Text(
              title,
              style: TextStyle(
                color: titleColor ?? Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: fontSize ?? 16.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


   // style: ElevatedButton.styleFrom(
          //   minimumSize: Size(btnWidth ?? double.infinity, btnHeight ?? 60),
          //   backgroundColor: btnColor ?? Colors.transparent,
          //   foregroundColor: btnColor ?? Colors.transparent,
          //   disabledBackgroundColor: btnColor ?? Colors.transparent,
          //   disabledForegroundColor: btnColor ?? Colors.transparent,
          //   elevation: 0,
          //   padding: padding,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(borderRadius ?? 14),
          //     side:
          //         const BorderSide(color: BaseColors.primaryColorLight, width: 1),
          //   ),
          // ),