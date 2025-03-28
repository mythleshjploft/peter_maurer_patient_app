import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  @override
  _CustomToggleSwitchState createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  bool isCallSelected = true; // Initial state: Call is selected

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCallSelected = !isCallSelected;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 130, // Adjust width
        height: 50, // Adjust height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300), // Light border
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Fill (Moves left & right)
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: isCallSelected ? 0 : 65, // Moves based on selection
              child: Container(
                width: 65, // Half width
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blueAccent, // Active color
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            // Row with Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Call Icon (Large)
                Icon(
                  Icons.call,
                  color: isCallSelected ? Colors.white : Colors.blueAccent,
                  size: 24,
                ),

                // Chat Icon (Large)
                Icon(
                  Icons.chat_bubble_outline,
                  color: isCallSelected ? Colors.blueAccent : Colors.white,
                  size: 22,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
