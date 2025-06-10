import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/home_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/dashboard_view.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/category_list_response.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/condition_list_response.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/doctor_details_response.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/doctor_list_response.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/initiate_chat_response.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/pre_exist_disease_list_response.dart';
import 'package:peter_maurer_patients_app/app/modules/appointment/apppointment_list_view.dart';
import 'package:peter_maurer_patients_app/app/modules/chat/chat_view.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_api_service.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_responses/base_success_response.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_variables.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DoctorController extends GetxController {
  RxList<DoctorDatum?>? doctorList = <DoctorDatum>[].obs;
  RxList<DoctorDatum?> filteredDoctorList = <DoctorDatum?>[].obs;
  RxBool isLoading = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  getDoctorList({bool? isFilter}) async {
    isLoading.value = true;
    try {
      BaseApiService()
          .get(
              apiEndPoint:
                  "${ApiEndPoints().doctorList}${(isFilter ?? false) ? "?category_id=${selectedCategoryFilter.value.id ?? ""}&start_date=${filterStartDateValueApi.value}&end_date=${filterEndDateValueApi.value}&sorting_by=${selectedSorting.value?.tag ?? ""}" : ""}",
              showLoader: false)
          .then((value) {
        isLoading.value = false;
        refreshController.refreshCompleted();
        if (value?.statusCode == 200) {
          try {
            DoctorListResponse response =
                DoctorListResponse.fromJson(value?.data);
            if ((response.success ?? false)) {
              doctorList?.value = response.data?.docs ?? [];
              // Initially assign full list to filtered list
              filteredDoctorList.value = doctorList!;
              doctorList?.refresh();
              update();
            } else {
              showSnackBar(subtitle: response.message ?? "");
            }
          } catch (e) {
            showSnackBar(subtitle: parsingError);
          }
        } else {
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } catch (e) {
      isLoading.value = false;
      refreshController.refreshCompleted();
      showSnackBar(subtitle: "Something went wrong, please try again");
    }
  }

  void filterDoctors(String query) {
    final List<DoctorDatum?> allDoctors = doctorList ?? [];
    if (query.isEmpty) {
      filteredDoctorList.value = allDoctors;
    } else {
      final lowerQuery = query.toLowerCase();
      filteredDoctorList.value = allDoctors.where((doc) {
        final fullName =
            "${doc?.firstName ?? ""} ${doc?.lastName ?? ""}".toLowerCase();
        return fullName.contains(lowerQuery);
      }).toList();
    }
  }

  RxList<Availability>? doctorsAvailability = <Availability>[].obs;
  Rx<DoctorDetails>? doctorDetails = DoctorDetails().obs;
  RxList<DoctorCategory>? doctorCategories = <DoctorCategory>[].obs;

  final DateTime selectedDay = DateTime.now();
  final RxMap<String, List<String>> availableSlots =
      <String, List<String>>{}.obs; // Stores slots for each available date
  final RxList<String> enabledDates = <String>[].obs;
  // RxString selectedSlot = "".obs;
  RxList<String> selectedSlots = <String>[].obs;
  Map<String, List<String>> weeklySlots = {};
  void processAvailabilityDataFromModel(DoctorsAvailability? availabilityData) {
    if (availabilityData == null) return;

    final RxMap<String, List<String>> tempAvailableSlots =
        <String, List<String>>{}.obs;
    final RxList<String> tempEnabledDates = <String>[].obs;

    for (var dateEntry in availabilityData.availableDates ?? []) {
      final String? dateStr = dateEntry.date;
      final List<AvailableTimeSlot> slots = dateEntry.availableTimeSlot ?? [];

      final List<String> timeSlots = slots
          .map((slot) => "${slot.startTime ?? ""} - ${slot.endTime ?? ""}")
          .toList();

      if (dateStr != null && timeSlots.isNotEmpty) {
        tempEnabledDates.add(dateStr);
        tempAvailableSlots[dateStr] = timeSlots;
      }
    }

    // Remove duplicates and update reactive variables
    enabledDates.assignAll(tempEnabledDates.toSet().toList());
    availableSlots.assignAll(tempAvailableSlots);

    enabledDates.refresh();
    availableSlots.refresh();

    log("Enabled Dates: $enabledDates");
    log("Available Slots: $availableSlots");

    update(); // If you are in a controller and using GetX
  }

  getDoctorDetails(String id) {
    BaseApiService()
        .get(apiEndPoint: "${ApiEndPoints().doctorDetails}$id")
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          DoctorDetailsResponse response =
              DoctorDetailsResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            doctorsAvailability?.value =
                (response.doctorsAvailability?.availableDates ?? []).isNotEmpty
                    ? (response.doctorsAvailability?.availableDates ?? [])
                    : [];
            doctorDetails?.value = response.doctors ?? DoctorDetails();
            doctorCategories?.value = response.doctorCategories ?? [];
            doctorCategories?.refresh();
            doctorDetails?.refresh();
            doctorsAvailability?.refresh();
            processAvailabilityDataFromModel(response.doctorsAvailability);
            update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          log("$e");
          showSnackBar(subtitle: "$e");
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  createAppointment({
    required String doctorId,
    required String date,
  }) {
    List<Map<String, dynamic>> slots = [];
    selectedSlots.map((element) {
      slots.add({
        "start_time": element.split("-")[0].trim(),
        "end_time": element.split("-")[1].trim(),
      });
      log("Selected Slot: $element");
    }).toList();
    List preexistingDiseases = [];
    selectedDisease.map((element) {
      preexistingDiseases.add(element.id?.toString() ?? "");
    }).toList();
    log("Selected Categories: $preexistingDiseases");
    Map<String, dynamic> data = {
      "doctor_id": doctorId,
      "category_id": [selectedCategory.value.id?.toString() ?? ""],
      "preExistDiseases_id": preexistingDiseases,
      "status": "Pending",
      "description": "description",
      "date": date,
      "slot": slots,
      "appointment_type": selectedCondition.value,
      "is_delete": false
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().addAppointment, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            showBaseDialgueBox(
                title: const Center(
                  child: Text(
                    "Terminbestätigung",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Bitte warten Sie mindestens 15 Minuten vor Ihrem Termin. Wenn Sie den Termin verschieben müssen, rufen Sie uns bitte an.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                    buildSizeHeight(15),
                    CustomButton(
                        text: "Continue".tr,
                        onPressed: () {
                          Get.offAll(() => const DashBoardView());
                          Get.to(const ApppointmentListView());
                        })
                  ],
                ));

            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  @override
  onInit() {
    getCategoryList();
    getConditionList();
    getDiseaseList();
    super.onInit();
  }

  RxList<CategoryDatum?> categoryList = <CategoryDatum>[].obs;

  Rx<DoctorCategory> selectedCategory = DoctorCategory().obs;
  RxString categorySlotDuration = "".obs;
  getCategoryList() async {
    BaseApiService()
        .get(apiEndPoint: ApiEndPoints().categoriesList)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          CategoryListResponse response =
              CategoryListResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            categoryList.value = response.data ?? [];
            categoryList.refresh();
            update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  RxList<ConditionDatum?> conditionList = <ConditionDatum>[].obs;
  RxString selectedCondition = "".obs;
  RxString selectedConditionId = "".obs;
  getConditionList() async {
    BaseApiService()
        .get(apiEndPoint: ApiEndPoints().conditionList)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          ConditionListResponse response =
              ConditionListResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            conditionList.value = response.data ?? [];
            conditionList.refresh();
            update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  RxList<DiseaseDatum?> diseaseList = <DiseaseDatum>[].obs;
  RxList<DiseaseDatum> selectedDisease = <DiseaseDatum>[].obs;

  getDiseaseList() async {
    BaseApiService().get(apiEndPoint: ApiEndPoints().diseaseList).then((value) {
      if (value?.statusCode == 200) {
        try {
          PreExistDiseaseListResponse response =
              PreExistDiseaseListResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            diseaseList.value = response.data ?? [];
            diseaseList.refresh();
            update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  //// For Filter
  List<SortingData> sortingData = [
    SortingData(title: "High to low", tag: "high_to_low"),
    SortingData(title: "Low to high", tag: "low_to_high"),
  ];

  Rx<SortingData?> selectedSorting = SortingData().obs;
  RxString selectedCategoriesFilter = "".obs;
  RxString selectedCategoriesIdFilter = "".obs;
  Rx<CategoryDatum> selectedCategoryFilter = CategoryDatum().obs;

  RxString filterStartDateValue = "".obs;
  RxString filterStartDateValueApi = "".obs;

  filterStartDate(BuildContext context) async {
    await showBaseDatePicker(context,
            isNoLastDate: true, showBeforeDates: false)
        .then((value) {
      if (value.isNotEmpty) {
        DateTime selectedDate = DateTime.parse(value); // Convert to DateTime

        if (filterEndDateValue.value.isNotEmpty) {
          DateTime endDate = DateTime.parse(filterEndDateValue.value);

          // Check if selected start date is after the end date
          if (selectedDate.isAfter(endDate)) {
            showSnackBar(subtitle: "Start date cannot be after the end date");
            return;
          }
        }
        filterStartDateValue.value = value;
        filterStartDateValueApi.value =
            "${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.year}";

        update();
      }
    });
  }

  RxString filterEndDateValue = "".obs;
  RxString filterEndDateValueApi = "".obs;
  filterEndDate(BuildContext context) async {
    await showBaseDatePicker(context,
            isNoLastDate: true, showBeforeDates: false)
        .then((value) {
      if (value.isNotEmpty) {
        DateTime selectedEndDate = DateTime.parse(value); // Convert to DateTime

        if (filterStartDateValue.value.isNotEmpty) {
          DateTime startDate = DateTime.parse(filterStartDateValue.value);

          // Check if end date is before the start date
          if (selectedEndDate.isBefore(startDate)) {
            showSnackBar(subtitle: "End date cannot be before the start date");
            return;
          }
        }

        filterEndDateValue.value = value;
        filterEndDateValueApi.value =
            "${selectedEndDate.month.toString().padLeft(2, '0')}-${selectedEndDate.day.toString().padLeft(2, '0')}-${selectedEndDate.year}";

        update();
      }
    });
  }

  initiateChats({required String doctorId}) async {
    Map<String, dynamic> data = {"userId": doctorId, "userType": "Doctor"};
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().initiateChat, data: data)
        .then((value) {
      if (value?.statusCode == 200 || value?.statusCode == 201) {
        try {
          InitiateChatResponse response =
              InitiateChatResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            Get.offAll(() => const DashBoardView(
                  index: 1,
                ));
            Get.to(() => ChatView(
                  chatUserId: doctorId,
                  userName: response.data?.name ?? "",
                  userImg: response.data?.profilePic ?? "",
                  userProfession: "",
                ));
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
          } else {
            // showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }
}

class SortingData {
  String? title;
  String? tag;
  SortingData({this.title, this.tag});
}
