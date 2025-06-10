import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/doctor_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/doctor_details_response.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/pre_exist_disease_list_response.dart';
import 'package:peter_maurer_patients_app/app/modules/dashboard/doctor_search_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorDetailsView extends StatefulWidget {
  const DoctorDetailsView(
      {super.key, required this.id, this.isFromDashboard = false});
  final bool isFromDashboard;
  final String id;

  @override
  State<DoctorDetailsView> createState() => _DoctorDetailsViewState();
}

class _DoctorDetailsViewState extends State<DoctorDetailsView> {
  DateTime _selectedDay = DateTime.now();
  DoctorController controller = Get.isRegistered<DoctorController>()
      ? Get.find<DoctorController>()
      : Get.put(DoctorController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getDoctorDetails(widget.id);
      controller.selectedCategory.value = DoctorCategory();
      controller.selectedConditionId.value = "";
      controller.selectedCondition.value = "";
      controller.categorySlotDuration.value = "";
      controller.selectedSlots.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorController>(builder: (logic) {
      return Scaffold(
        backgroundColor: AppColors.grayBackground,
        appBar: CustomAppBar(
            title:
                "${controller.doctorDetails?.value.firstName?.toString() ?? ""} ${controller.doctorDetails?.value.lastName?.toString() ?? ""}",
            onBackPress: () => Get.back()),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Color(0xffBAF0FF), Color(0xffF3FFE0)],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        cachedNetworkImage(
                            image: controller.doctorDetails?.value.image ?? "",
                            height: 80,
                            width: 80,
                            borderRadius: 15),
                        const SizedBox(
                          width: 15,
                          height: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.doctorDetails?.value.firstName?.toString() ?? ""} ${controller.doctorDetails?.value.lastName?.toString() ?? ""}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              controller.doctorDetails?.value.specialist
                                      ?.toString() ??
                                  "",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        infoBox("Experience",
                            "${controller.doctorDetails?.value.totalExperience?.toString() ?? ""} Years"),
                        const SizedBox(
                          height: 16,
                        ),
                        // infoBox("Patient", "200+"),
                      ],
                    ),
                  ],
                ),
              ),

              // Description Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Lorem ipsum dolor sit amet consectetur. Ac nunc faucibus auctor purus nulla pretium bibendum.Lorem ipsum dolor sit amet consectetur. Ac nunc faucibus auctor purus nulla pretium bibendum.",
                  style: TextStyle(color: Colors.black, fontSize: 13.5),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Read More".tr,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Image.asset("assets/images/location_icon.png"),
              ),

              // Location Section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/location_icon_map.svg"),
                    const SizedBox(width: 5),
                    Text(
                      "${controller.doctorDetails?.value.cityId?.name?.toString() ?? ""}, ${controller.doctorDetails?.value.countryId?.name?.toString() ?? ""}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),

              // Date & Time Section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Select Date And Time".tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),

              // Calendar Widget
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(.30),
                    border: Border.all(color: AppColors.borderColor)),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TableCalendar(
                      focusedDay: _selectedDay,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      calendarFormat: CalendarFormat.month,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      enabledDayPredicate: (day) {
                        return controller.enabledDates.contains(
                            "${day.month < 10 ? "0${day.month}" : "${day.month}"}-${day.day < 10 ? "0${day.day}" : "${day.day}"}-${day.year}");
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                        });
                        controller.selectedSlots.clear();
                        // controller.selectedSlot.value = "";
                      },
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        disabledTextStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    // TableCalendar(
                    //   focusedDay: _selectedDay,
                    //   firstDay: DateTime(2022),
                    //   lastDay: DateTime(2030),
                    //   calendarFormat: CalendarFormat.month,
                    //   selectedDayPredicate: (day) {
                    //     return isSameDay(_selectedDay, day);
                    //   },
                    //   onDaySelected: (selectedDay, focusedDay) {
                    //     setState(() {
                    //       _selectedDay = selectedDay;
                    //     });
                    //   },
                    //   headerStyle: const HeaderStyle(
                    //     formatButtonVisible: false,
                    //     titleCentered: true,
                    //   ),
                    //   calendarStyle: const CalendarStyle(
                    //     todayDecoration: BoxDecoration(
                    //       color: Colors.blueAccent,
                    //       shape: BoxShape.circle,
                    //     ),
                    //     selectedDecoration: BoxDecoration(
                    //       color: AppColors.primaryColor,
                    //       shape: BoxShape.circle,
                    //     ),
                    //   ),
                    // ),

                    Row(
                      children: [
                        Text(
                          monthYearDateFormat(_selectedDay.toString()),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    buildSizeHeight(10),
                    CustomTextField(
                      hintText: "Select Category",
                      controller: TextEditingController(
                          text: controller.selectedCategory.value.name
                                  ?.toString() ??
                              ""),
                      readOnly: true,
                      onTap: () {
                        showCategoryBtmSheet();
                      },
                    ),
                    buildSizeHeight(15),
                    CustomTextField(
                      hintText: "Select Condition",
                      controller: TextEditingController(
                          text: controller.selectedCondition.value),
                      readOnly: true,
                      onTap: () {
                        showConditionBtmSheet();
                      },
                    ),
                    buildSizeHeight(15),
                    CustomTextField(
                      hintText: "Select Pre Existing Disease",
                      controller: TextEditingController(
                          text: controller.selectedDisease
                              .map((e) => e.name.toString())
                              .toList()
                              .join(",")),
                      readOnly: true,
                      onTap: () {
                        showDiseaseBtmSheet();
                      },
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    if (controller.categorySlotDuration.value.isNotEmpty)
                      Row(
                        children: [
                          Text(
                            "${"Preferred Duration for Appointment".tr}:",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    if (controller.categorySlotDuration.value.isNotEmpty)
                      Row(
                        children: [
                          Obx(() => Text(
                                controller.categorySlotDuration.value,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                        ],
                      ),
                    buildSizeHeight(10),
                    controller.availableSlots[
                                "${_selectedDay.month < 10 ? "0${_selectedDay.month}" : "${_selectedDay.month}"}-${_selectedDay.day < 10 ? "0${_selectedDay.day}" : "${_selectedDay.day}"}-${_selectedDay.year}"] !=
                            null
                        ? Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.start,
                            children: controller.availableSlots[
                                    "${_selectedDay.month < 10 ? "0${_selectedDay.month}" : "${_selectedDay.month}"}-${_selectedDay.day < 10 ? "0${_selectedDay.day}" : "${_selectedDay.day}"}-${_selectedDay.year}"]!
                                .map((slot) => timeSlot(slot))
                                .toList(),
                          )
                        : Text("No available slots".tr),
                    // Wrap(
                    //   spacing: 10,
                    //   runSpacing: 10,
                    //   children: [
                    //     timeSlot("03:00pm"),
                    //     timeSlot("03:30pm"),
                    //     timeSlot("04:30pm"),
                    //     timeSlot("11:30am"),
                    //     timeSlot("05:30pm"),
                    //     timeSlot("02:30pm", selected: true),
                    //     timeSlot("05:00pm"),
                    //     timeSlot("10:30am"),
                    //   ],
                    // ),

                    const SizedBox(
                      height: 13,
                    ),
                  ],
                ),
              ),

              // Time Slots

              // Bottom Buttons
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SvgPicture.asset("assets/icons/call_chat_switch.svg"),
                    // CustomToggleSwitch(),
                    // FloatingActionButton(
                    //   backgroundColor: Colors.blue,
                    //   onPressed: () {},
                    //   child: Icon(Icons.call, color: Colors.white),
                    // ),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        controller.initiateChats(doctorId: widget.id);
                      },
                      child: const Icon(Icons.message, color: Colors.black),
                    ),
                    Visibility(
                      visible: widget.isFromDashboard,
                      child: Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const DoctorSearchView());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                "Book Other Doctor".tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (controller.selectedSlots.isEmpty) {
                            showSnackBar(subtitle: "Please select a time slot");
                          } else if ((controller.selectedCategory.value.id
                                      ?.toString() ??
                                  "")
                              .isEmpty) {
                            showSnackBar(subtitle: "Please select a category");
                          } else if (controller
                              .selectedConditionId.value.isEmpty) {
                            showSnackBar(subtitle: "Please select a Condition");
                          } else {
                            String formattedDate =
                                "${_selectedDay.month < 10 ? "0${_selectedDay.month}" : _selectedDay.month}-${_selectedDay.day < 10 ? "0${_selectedDay.day}" : _selectedDay.day}-${_selectedDay.year}";
                            controller.createAppointment(
                                doctorId: widget.id, date: formattedDate);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "Book".tr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  showCategoryBtmSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "Select Categories".tr,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              buildSizeHeight(20),
              ListView.builder(
                itemCount: controller.doctorCategories?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  DoctorCategory category =
                      controller.doctorCategories?[index] ?? DoctorCategory();
                  return Obx(
                    () => InkWell(
                      onTap: () {
                        controller.selectedCategory.value = category;
                        controller.categorySlotDuration.value =
                            category.slotDuration?.toString() ?? "0 Minutes";
                        // if (controller.selectedCategoriesList
                        //     .contains(category)) {
                        //   controller.selectedCategoriesList.remove(category);
                        // } else {
                        //   controller.selectedCategoriesList.add(category);
                        // }
                        // log("Selected Categories: ${controller.selectedCategoriesList.map((e) => e.name.toString()).toList()}");
                        controller.update();
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Radio(
                                groupValue: true,
                                value: controller.selectedCategory.value ==
                                    category,
                                onChanged: (val) {
                                  controller.selectedCategory.value = category;
                                  controller.categorySlotDuration.value =
                                      category.slotDuration?.toString() ??
                                          "0 Minutes";
                                  controller.update();
                                  Get.back();
                                }),
                            Expanded(
                                child: Text(category.name?.toString() ?? "")),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ]),
          ),
        );
      },
    );
  }

  void showDiseaseBtmSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(child: GetBuilder<DoctorController>(
            builder: (logic) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select Categories".tr,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  buildSizeHeight(20),
                  ListView.builder(
                    itemCount: controller.diseaseList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          if (controller.selectedDisease
                              .contains(controller.diseaseList[index])) {
                            controller.selectedDisease
                                .remove(controller.diseaseList[index]);
                            controller.selectedDisease.refresh();
                          } else {
                            controller.selectedDisease.add(
                                controller.diseaseList[index] ??
                                    DiseaseDatum());
                            controller.selectedDisease.refresh();
                          }
                          controller.update();
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: controller.selectedDisease
                                    .contains(controller.diseaseList[index]),
                                onChanged: (val) {
                                  if (val == true) {
                                    controller.selectedDisease.add(
                                        controller.diseaseList[index] ??
                                            DiseaseDatum());
                                    controller.selectedDisease.refresh();
                                  } else {
                                    controller.selectedDisease
                                        .remove(controller.diseaseList[index]);
                                    controller.selectedDisease.refresh();
                                  }
                                  controller.update();
                                  setState(() {});
                                },
                              ),
                              Expanded(
                                  child: Text(
                                      controller.diseaseList[index]?.name ??
                                          "")),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text("Done"),
                  ),
                ],
              );
            },
          )),
        );
      },
    );
  }

  showConditionBtmSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "Select Condition".tr,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              buildSizeHeight(20),
              ListView.builder(
                itemCount: controller.conditionList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var condition = controller.conditionList[index];
                  return Obx(
                    () => InkWell(
                      onTap: () {
                        controller.selectedConditionId.value =
                            condition?.id?.toString() ?? "";
                        controller.selectedCondition.value =
                            condition?.name?.toString() ?? "";
                        controller.selectedConditionId.refresh();
                        controller.selectedCondition.refresh();
                        controller.update();
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Radio(
                                groupValue: true,
                                value: controller.selectedConditionId.value ==
                                    (condition?.id?.toString() ?? ""),
                                onChanged: (val) {
                                  controller.selectedConditionId.value =
                                      condition?.id?.toString() ?? "";
                                  controller.selectedCondition.value =
                                      condition?.name?.toString() ?? "";
                                  controller.selectedConditionId.refresh();
                                  controller.selectedCondition.refresh();
                                  controller.update();
                                  Get.back();
                                }),
                            Text(condition?.name?.toString() ?? ""),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ]),
          ),
        );
      },
    );
  }

  // Helper method for info boxes
  Widget infoBox(String title, String value) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF).withOpacity(.55),
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5),
        // ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Helper method for time slots
  Widget timeSlot(
    String time,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          if (controller.selectedSlots.contains(time)) {
            controller.selectedSlots.remove(time);
          } else {
            controller.selectedSlots.add(time);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: 110,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(
                color: controller.selectedSlots.contains(time)
                    ? AppColors.primaryColor
                    : Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
            color: controller.selectedSlots.contains(time)
                ? AppColors.primaryColor.withOpacity(0.1)
                : Colors.white,
          ),
          child: Text(
            time,
            style: TextStyle(
                color: controller.selectedSlots.contains(time)
                    ? AppColors.primaryColor
                    : Colors.black,
                fontSize: 13),
          ),
        ),
      ),
    );
  }
}

// class DetailsView extends StatefulWidget {
//   const DetailsView({super.key});

//   @override
//   State<DetailsView> createState() => _DetailsViewState();
// }

// class _DetailsViewState extends State<DetailsView> {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar(
      title: "Dr. Dr. Maurer",
      onActionPress: () {},
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xffBAF0FF), Color(0xffF3FFE0)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/dr_img.png"),
                    ),
                    Text("Dr. Dr. Maurer"),
                    Text("Stomach Specialist")
                  ],
                ),
                Column(
                  children: [
                    //  Container(child:,)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
