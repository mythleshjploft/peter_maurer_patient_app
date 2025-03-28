import 'package:flutter/material.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar.dart';


class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedTab = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: CustomAppBar(title: "To-Do"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
             
          children: [
             
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    _buildSegmentButton('Today', 0),
                    _buildSegmentButton('Completed', 1),
                    _buildSegmentButton('Pending', 2),
                  ],
                ),
              ),
              SizedBox(height: 20),
            Expanded(child: _buildTaskList()),
            // const Center(child: Text("Completed Tasks")),
            // const Center(child: Text("Pending Tasks")),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView(
     
      children: [
        _buildTaskCard(
          title: "Follow Up with Patient",
          description: "Ensure timely and effective patient care by following up on previous consultations.\nCheck progress, review test",
          status: "Done",
          statusColor: AppColors.primaryColor,
          time: "Monday  8:00 - 9:00 am  July 31, 2024",
          backgroundColor: Colors.blue.withOpacity(0.2),
        ),
        const SizedBox(height: 16),
        _buildTaskCard(
          title: "Follow Up with Patient",
          description: "Ensure timely and effective patient care by following up on previous consultations.\nCheck progress, review test",
          status: "Pending",
          statusColor: Colors.grey,
          time: "Monday  8:00 - 9:00 am  July 31, 2024",
          backgroundColor: Colors.grey.withOpacity(0.2),
        ),
      ],
    );
  }

  Widget _buildSegmentButton(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: selectedTab == index ? AppColors.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selectedTab == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTaskCard({
    required String title,
    required String description,
    required String status,
    required Color statusColor,
    required String time,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  // color: backgroundColor,
                  border: Border.all(   color: backgroundColor,),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                       
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: statusColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 12),
          Container(
            padding:  EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:  Color(0xffDCFCE7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: Colors.green, size: 18),
                const SizedBox(width: 8),
                Text(
                  time,
                  style: const TextStyle( fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
