import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final List<Map<String, dynamic>> notifications = [
    {
      "name": "Angela",
      "time": "Last Today at 9:42 AM",
      "profileImage":
          "assets/images/notification_user_icon.png", // Change to your image
      "isNew": true,
      "count": 1
    },
    {
      "name": "Angela",
      "time": "30 Second",
      "profileImage":
          "assets/images/temp_profile_img.png", // Change to your image
      "isNew": false,
      "status": "New Booking"
    },
    {
      "name": "Angela",
      "time": "Last Today at 9:42 AM",
      "profileImage": "assets/images/notification_user_icon.png",
      "isNew": true,
      "count": 1
    },
    {
      "name": "Angela",
      "time": "30 Second",
      "profileImage": "assets/images/temp_profile_img.png",
      "isNew": false,
      "status": "New Booking"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Notifications",
        onActionPress: () {},
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                var item = notifications[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade300, width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(item["profileImage"]),
                          ),
                          if (item["isNew"])
                            const Positioned(
                              top: 0,
                              left: 0,
                              child: CircleAvatar(
                                radius: 4,
                                backgroundColor: AppColors.primaryColor,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item["name"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14)),
                            const SizedBox(height: 4),
                            Text(item["time"],
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                      if (item["count"] != null)
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.primaryColor,
                          child: Text("${item["count"]}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12)),
                        ),
                      if (item["status"] != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xffE5F7E9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(item["status"],
                              style: const TextStyle(fontSize: 12)),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: const Center(
                child: Text("Clear All",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          )

          // _buildMenuItem('assets/icons/home_icon.svg', "Dashboard", onTap: () {}),
          // _buildMenuItem('assets/icons/history.svg', "Appointments History", onTap: () {}),
          // _buildMenuItem('assets/icons/profile_icon.svg', "Profile", onTap: () {}),
          // _buildMenuItem('assets/icons/logout_icon_v1.svg', "Log Out", onTap: () {}),
        ],
      ),
    );
  }

  // Menu Item Widget
  Widget _buildMenuItem(String icon, String title, {VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryColor
                .withOpacity(0.19), // Change the color as needed
            width: 1.0, // Adjust thickness
          ),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            child: SvgPicture.asset(icon),
          ),
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
