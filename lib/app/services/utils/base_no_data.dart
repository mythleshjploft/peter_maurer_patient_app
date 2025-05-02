import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseNoData extends StatelessWidget {
  final String? message;
  final Color? textColor;
  final double size;
  const BaseNoData({super.key, this.message, this.textColor, this.size = 180});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: size,
            child: OverflowBox(
              minHeight: size,
              maxHeight: size,
              minWidth: size,
              maxWidth: size,
              // child: Lottie.asset(
              //   BaseAssets.noData,
              // ),
            ),
          ),
          Text(
            message?.tr ?? "No Data Found!".tr,
            style: TextStyle(
              fontSize: 16,
              color: textColor ?? Colors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
