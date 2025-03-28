import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';

void showRescheduleDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
        alignment: Alignment.center,
          children: [
             // SVG Background
            SvgPicture.asset(
              'assets/icons/Rectangle 69.svg', // Your SVG card background
            
            ),
            Container(
              // width: MediaQuery.of(context).size.width * 0.8,
              // height: 50,
               padding: const EdgeInsets.all(20),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20),
              //   color: Colors.white,
              // ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Background SVG
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
                      SvgPicture.asset(
                        'assets/icons/reschedule_appoinment_icon.svg', // Replace with your success icon SVG
                        height: 80,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Appointment Rescheduled Successfully!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Your appointment has been successfully rescheduled. Here are the updated details:",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Done",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50,
              right: 10,
              child: IconButton(
                icon: SvgPicture.asset("assets/icons/close_icon_with_background.svg"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          
          ],
        ),
      );
    },
  );
}