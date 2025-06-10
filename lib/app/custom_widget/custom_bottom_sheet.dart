import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/controllers/doctor_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/category_list_response.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  DoctorController controller = Get.isRegistered<DoctorController>()
      ? Get.find<DoctorController>()
      : Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RPSCustomPainter(),
      child: GetBuilder<DoctorController>(builder: (logic) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Align(
              //   alignment: Alignment.topRight,
              //   child: GestureDetector(
              //     onTap: () => Navigator.pop(context),
              //     child: const CircleAvatar(
              //       backgroundColor: Color(0xFFD6ECFF),
              //       child: Icon(Icons.close, color: Colors.blue),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 10),
              Text(
                "Filter".tr,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButtonFormField<SortingData>(
                  decoration: const InputDecoration(border: InputBorder.none),
                  hint: Text(
                      controller.selectedSorting.value?.tag?.isEmpty ?? true
                          ? "Sort by".tr
                          : controller.selectedSorting.value?.title ?? ""),
                  items: controller.sortingData
                      .map((e) => DropdownMenuItem(
                          value: e, child: Text(e.title ?? "")))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedSorting.value = value;
                  },
                ),
              ),
              CustomTextField(
                hintText: "Select Start Date",
                controller: TextEditingController(
                    text: controller.filterStartDateValue.value),
                readOnly: true,
                onTap: () {
                  controller.filterStartDate(context);
                },
              ),
              CustomTextField(
                hintText: "Select End Date",
                controller: TextEditingController(
                    text: controller.filterEndDateValue.value),
                readOnly: true,
                onTap: () {
                  controller.filterEndDate(
                    context,
                  );
                },
              ),
              CustomTextField(
                hintText: "Select Category",
                controller: TextEditingController(
                    text: controller.selectedCategoryFilter.value.name
                            ?.toString() ??
                        ""),
                readOnly: true,
                onTap: () {
                  showCategoryBtmSheet();
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  controller.getDoctorList(isFilter: true);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  "Apply".tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }),
    );
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
                itemCount: controller.categoryList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  CategoryDatum category =
                      controller.categoryList[index] ?? CategoryDatum();
                  return Obx(
                    () => InkWell(
                      onTap: () {
                        controller.selectedCategoryFilter.value = category;
                        controller.update();
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Radio(
                                groupValue: true,
                                value:
                                    controller.selectedCategoryFilter.value ==
                                        category,
                                onChanged: (val) {
                                  controller.selectedCategoryFilter.value =
                                      category;

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

  Widget _buildDropdown(String label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(border: InputBorder.none),
        hint: Text(label.tr),
        items: ["Option 1", "Option 2"]
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, String label, DateTime? date) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            date = pickedDate;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date != null
                ? "${date.day}/${date.month}/${date.year}"
                : label.tr),
            const Icon(Icons.calendar_today, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Top Curve
class RPSCustomPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.1);
    path.quadraticBezierTo(size.width * 0.5, 0, size.width, size.height * 0.1);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Function to Show Bottom Sheet
void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return const CustomBottomSheet();
    },
  );
}
