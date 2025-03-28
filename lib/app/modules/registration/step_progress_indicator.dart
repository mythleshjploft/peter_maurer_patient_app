import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepProgressIndicator extends StatelessWidget {
  int currenStep;
  StepProgressIndicator({super.key, required this.currenStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Line between steps
              Positioned(
                top: 18, // Adjust for alignment
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  color: Colors.grey.shade400, // Line color
                ),
              ),
              // Steps
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStep("1", currenStep >= 1),
                  _buildStep("2", currenStep >= 2),
                  _buildStep("3", currenStep >= 3),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStep(String text, bool isCompleted) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? Color(0xFF55A5C4) : Colors.white, // Filled for completed steps
        border: Border.all(color: Colors.grey), // Border for unselected step
      ),
      alignment: Alignment.center,
      child: isCompleted
          ? Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : Container(), // Empty for the last step
    );
  }
}
