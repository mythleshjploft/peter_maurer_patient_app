import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/base_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar.dart';
import 'package:peter_maurer_patients_app/app/models/notification_screen/notification_list_response.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_no_data.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  BaseController controller = Get.find<BaseController>();
  // final List<Map<String, dynamic>> notifications = [
  //   {
  //     "name": "Angela",
  //     "time": "Last Today at 9:42 AM",
  //     "profileImage":
  //         "assets/images/notification_user_icon.png", // Change to your image
  //     "isNew": true,
  //     "count": 1
  //   },
  //   {
  //     "name": "Angela",
  //     "time": "30 Second",
  //     "profileImage":
  //         "assets/images/temp_profile_img.png", // Change to your image
  //     "isNew": false,
  //     "status": "New Booking"
  //   },
  //   {
  //     "name": "Angela",
  //     "time": "Last Today at 9:42 AM",
  //     "profileImage": "assets/images/notification_user_icon.png",
  //     "isNew": true,
  //     "count": 1
  //   },
  //   {
  //     "name": "Angela",
  //     "time": "30 Second",
  //     "profileImage": "assets/images/temp_profile_img.png",
  //     "isNew": false,
  //     "status": "New Booking"
  //   },
  // ];

  @override
  void initState() {
    controller.getNotificationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Notifications",
        onBackPress: () {},
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (controller.isNotificationLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.notificationList.isEmpty) {
              return const BaseNoData();
            }
            return Expanded(
              child: ListView.builder(
                itemCount: controller.notificationList.length,
                itemBuilder: (context, index) {
                  NoticationData data = controller.notificationList[index];
                  return GestureDetector(
                    onTap: () {
                      controller.readNotification(
                          controller.notificationList[index].id?.toString() ??
                              "");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.shade300, width: 0.5),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Stack(
                          //   children: [
                          //     // CircleAvatar(
                          //     //   radius: 24,
                          //     //   backgroundImage: AssetImage(
                          //     //       "assets/images/temp_profile_img.png"),
                          //     // ),
                          //     // cachedNetworkImage(
                          //     //     image: data.user?.image ?? "",
                          //     //     borderRadius: 100,
                          //     //     height: 50,
                          //     //     width: 50),
                          //     // if (item["isNew"])
                          //     Visibility(
                          //       visible: !(data.isRead ?? false),
                          //       child: const Positioned(
                          //         top: 0,
                          //         left: 0,
                          //         child: CircleAvatar(
                          //           radius: 4,
                          //           backgroundColor: AppColors.primaryColor,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Visibility(
                            visible: !(data.isRead ?? false),
                            child: const CircleAvatar(
                              radius: 4,
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(data.title?.toString() ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                                const SizedBox(height: 4),
                                Text(data.description ?? "",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          ),
                          // if (item["count"] != null)
                          // const CircleAvatar(
                          //   radius: 12,
                          //   backgroundColor: AppColors.primaryColor,
                          //   child: Text("count",
                          //       style:
                          //           TextStyle(color: Colors.white, fontSize: 12)),
                          // ),
                          // if (item["status"] != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xffE5F7E9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text("New Booking",
                                style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
          Obx(
            () => Visibility(
              visible: controller.notificationList.isNotEmpty,
              child: Container(
                margin: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    controller.deleteNotification();
                  },
                  child: Center(
                    child: Text("Clear All".tr,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
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
}
