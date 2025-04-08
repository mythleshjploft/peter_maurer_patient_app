import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peter_maurer_patients_app/app/controllers/home_controller.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/category_list_response.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/condition_list_response.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/doctor_details_response.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/doctor_list_response.dart';
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
  RxBool isLoading = true.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  getDoctorList() async {
    isLoading.value = true;
    try {
      BaseApiService()
          .get(apiEndPoint: ApiEndPoints().doctorList, showLoader: false)
          .then((value) {
        isLoading.value = false;
        refreshController.refreshCompleted();
        if (value?.statusCode == 200) {
          try {
            DoctorListResponse response =
                DoctorListResponse.fromJson(value?.data);
            if ((response.success ?? false)) {
              doctorList?.value = response.data?.docs ?? [];
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

    Set<String> weekDays = {};
    DateTime today = DateTime.now();
    DateTime oneYearLater = today.add(const Duration(days: 365));

    final RxMap<String, List<String>> tempAvailableSlots =
        <String, List<String>>{}.obs;
    final RxList<String> tempEnabledDates = <String>[].obs;
    final Map<String, List<String>> tempWeeklySlots = {};

    for (var dateEntry in availabilityData.availableDates ?? []) {
      final String? availabilityType = dateEntry.availabilityType;
      final String? date = dateEntry.date;

      final List<AvailableTimeSlot> slots = dateEntry.availableTimeSlot ?? [];

      final List<String> timeSlots = slots
          .map((slot) => "${slot.startTime ?? ""} - ${slot.endTime ?? ""}")
          .toList();

      if (availabilityType == "Every Week") {
        // Get weekday name (e.g., "Monday") from the date
        final DateTime? dateObj = DateTime.tryParse(date ?? "");
        if (dateObj != null) {
          String weekDay = DateFormat('EEEE').format(dateObj);
          weekDays.add(weekDay);

          tempWeeklySlots[weekDay] ??= [];
          tempWeeklySlots[weekDay]?.addAll(timeSlots);
        }
      } else if (availabilityType == "Specific Dates") {
        if (date != null) {
          tempEnabledDates.add(date);
          tempAvailableSlots[date] ??= [];
          tempAvailableSlots[date]?.addAll(timeSlots);
        }
      }
    }

    // Fill available slots for recurring weekly availability for the next year
    for (var day = today;
        day.isBefore(oneYearLater);
        day = day.add(const Duration(days: 1))) {
      final String weekdayName = DateFormat('EEEE').format(day);
      if (weekDays.contains(weekdayName)) {
        final String key =
            "${day.month}-${day.day < 10 ? "0${day.day}" : "${day.day}"}-${day.year}";
        tempEnabledDates.add(key);
        tempAvailableSlots[key] = tempWeeklySlots[weekdayName]?.toList() ?? [];
      }
    }

    // Update reactive values
    enabledDates
        .assignAll(tempEnabledDates.toSet().toList()); // to avoid duplicates
    availableSlots.assignAll(tempAvailableSlots);
    enabledDates.refresh();
    availableSlots.refresh();

    log("Enabled Dates: $enabledDates");
    log("Available Slots: $availableSlots");

    update();
  }

  getDoctorDetails(String id) {
    BaseApiService()
        .get(apiEndPoint: "${ApiEndPoints().doctorDetails}new/$id")
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
    List categories = [];
    selectedCategoriesList.map((element) {
      categories.add(element.id?.toString() ?? "");
    }).toList();
    log("Selected Categories: $categories");
    Map<String, dynamic> data = {
      "doctor_id": doctorId,
      "category_id": categories,
      "preExistDiseases_id":
          BaseStorage.read(StorageKeys.preExistingDisease) ?? "",
      "status": "Pending",
      "description": "description",
      "date": date,
      "slot": slots,
      "appointment_type": selectedConditionId.value,
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
            Get.back();
            Get.find<HomeController>().getHomeScreenData();
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
    super.onInit();
  }

  RxList<CategoryDatum?> categoryList = <CategoryDatum>[].obs;
  RxString selectedCategories = "".obs;
  RxString selectedCategoriesId = "".obs;
  RxList<DoctorCategory> selectedCategoriesList = <DoctorCategory>[].obs;
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
}
