import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/home_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar_doctor.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/modules/chat/chat_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final TextEditingController searchController = TextEditingController();
  HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    controller.getAppointmentList();
    super.initState();
  }

  final List<Map<String, dynamic>> upcomingAppointments = [
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "28 November 2023",
      "time": "08:30 PM",
      "duration": "60 Minutes",
      "image": "assets/images/dr_img.png"
    },
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "28 November 2023",
      "time": "08:30 PM",
      "duration": "60 Minutes",
      "image": "assets/images/dr_img.png"
    },
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "28 November 2023",
      "time": "08:30 PM",
      "duration": "60 Minutes",
      "image": "assets/images/dr_img.png"
    },
  ];

  final List<Map<String, dynamic>> pastAppointments = [
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "28 November 2023",
      "image": "assets/images/dr_img.png"
    },
    {
      "name": "Dr. Dr. Maurer",
      "specialty": "Stomach Specialist",
      "date": "28 November 2023",
      "image": "assets/images/dr_img.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      appBar: CustomAppBarDoctor(
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Good Morning ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${BaseStorage.read(StorageKeys.firstName) ?? ""} ${BaseStorage.read(StorageKeys.lastName) ?? ""}",
                        style: const TextStyle(
                          fontSize: 22,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldWithoutText(
                    hintText: "Search",
                    controller: searchController,
                    suffixIcon: Icons.search,
                  ),
                  const SizedBox(height: 26),
                  const Row(
                    children: [
                      Text("My Appointment",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.appointmentList?.length ?? 0,
                      physics: const ScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.borderColor)
                              // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                              ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        cachedNetworkImage(
                                            image: controller
                                                    .appointmentList?[index]
                                                    ?.doctorId
                                                    ?.image
                                                    ?.toString() ??
                                                "",
                                            height: 50,
                                            width: 50,
                                            borderRadius: 100),
                                        const SizedBox(width: 12),
                                        Text(
                                            "${controller.appointmentList?[index]?.doctorId?.firstName?.toString() ?? ""} ${controller.appointmentList?[index]?.doctorId?.lastName?.toString() ?? ""}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                        controller.appointmentList?[index]
                                                ?.doctorId?.specialist
                                                ?.toString() ??
                                            "",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.grayMedium)),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/time_icon_new.svg'),
                                        const SizedBox(width: 4),
                                        Text(
                                            "${controller.appointmentList?[index]?.date?.toString() ?? ""} ${controller.appointmentList?[index]?.slot?.toString() ?? ""}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.grayMedium)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                    "${controller.appointmentList?[index]?.slotDuration?.toString() ?? ""} Minutes",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        );
                      }),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text("Past Appointment",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xffBAF0FF), Color(0xffF3FFE0)],
                  ),
                ),
                child: Row(
                  children: pastAppointments.map((appointment) {
                    return Container(
                      width: 180,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage(appointment["image"]),
                          ),
                          const SizedBox(height: 8),
                          Text(appointment["name"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(appointment["specialty"],
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(appointment["date"],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text("Daily Read",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(
                                radius: 4, backgroundColor: Colors.green),
                            SizedBox(width: 6),
                            Text("DAILY READ",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                            "Equitable medical education with efforts toward real change",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child:
                              Image.asset("assets/images/Rectangle 39896.png"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
