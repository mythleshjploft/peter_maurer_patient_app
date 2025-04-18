import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peter_maurer_patients_app/app/models/appointment_screen/appointment_history_reponse.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/doctor_details_response.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_api_service.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_responses/base_success_response.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_variables.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';

class AppointmentController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getAppointmentList();
  }

  RxInt selectedTab = 0.obs;

  RxList<AppointmentData> appointmentList = <AppointmentData>[].obs;
  RxList<AppointmentData> filteredAppointmentList = <AppointmentData>[].obs;
  RxBool isAppointmentLoading = true.obs;

  Rx<EventController> eventController = EventController().obs;

  getAppointmentList() {
    String filter = "";
    if (selectedTab.value == 0) {
      filter = "Upcoming";
    } else if (selectedTab.value == 1) {
      filter = "Completed";
    } else {
      filter = "Canceled";
    }
    isAppointmentLoading.value = true;
    BaseApiService()
        .get(apiEndPoint: "${ApiEndPoints().appointmentList}?filter=$filter")
        .then((value) {
      isAppointmentLoading.value = false;
      if (value?.statusCode == 200) {
        try {
          AppointmentHistoryResponse response =
              AppointmentHistoryResponse.fromJson(value?.data);
          if ((response.success ?? true)) {
            appointmentList.clear();
            filteredAppointmentList.clear();
            appointmentList.value = response.data?.docs ?? [];
            filteredAppointmentList.value = appointmentList;
            eventController.value = EventController();
            appointmentList.map((e) {
              eventController.value.add(
                CalendarEventData(
                  date: DateTime.parse(e.date?.toString() ?? ""),
                  event:
                      "${e.doctorId?.toString() ?? ""} ${e.doctorId?.lastName?.toString() ?? ""}",
                  title:
                      "${e.doctorId?.firstName?.toString() ?? ""} ${e.doctorId?.lastName?.toString() ?? ""}",
                  description: e.description,
                  startTime: getEventDateTime(
                      "${e.date} ${e.slot?.startTime?.toString() ?? "00:00"}"),
                  endTime: getEventDateTime(
                      "${e.date} ${e.slot?.endTime?.toString() ?? "00:00"}"),
                  color: selectedTab.value == 0
                      ? Colors.blue
                      : selectedTab.value == 1
                          ? Colors.green
                          : Colors.red,
                ),
              );
            }).toList();

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

  void filterAppointments(String query) {
    if (query.isEmpty) {
      filteredAppointmentList.value = appointmentList;
    } else {
      final lowerQuery = query.toLowerCase();
      filteredAppointmentList.value = appointmentList.where((appointment) {
        final doctorName =
            "${appointment.doctorId?.firstName ?? ""} ${appointment.doctorId?.lastName ?? ""}"
                .toLowerCase();
        return doctorName.contains(lowerQuery);
      }).toList();
    }
  }

  getEventDateTime(String input) {
    log("input: $input");
    DateTime parsedDate = DateTime.parse(input.replaceFirst(' ', 'T'));
    return parsedDate;
  }

  updateStatus({required String id, required String status}) {
    Map<String, dynamic> data = {"status": status};
    BaseApiService()
        .put(
            apiEndPoint: "${ApiEndPoints().changeAppointmentStatus}$id",
            data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if ((response.success ?? true)) {
            getAppointmentList();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
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

  RxBool isSlotLoading = true.obs;
  // getDoctorDetails() {
  //   isSlotLoading.value = true;
  //   BaseApiService()
  //       .get(apiEndPoint: ApiEndPoints().addAppointment)
  //       .then((value) {
  //     isSlotLoading.value = false;
  //     if (value?.statusCode == 200) {
  //       try {
  //         AvailabilityListResponse response =
  //             AvailabilityListResponse.fromJson(value?.data);
  //         if ((response.success ?? true)) {
  //           doctorsAvailability?.value =
  //               (response.availability?.availableDates ?? []).isNotEmpty
  //                   ? (response.availability?.availableDates ?? [])
  //                   : [];
  //           doctorsAvailability?.refresh();
  //           processAvailabilityData();
  //           update();
  //         } else {
  //           showSnackBar(subtitle: response.message ?? "");
  //         }
  //       } catch (e) {
  //         log("$e");
  //         showSnackBar(subtitle: "$e");
  //       }
  //     } else {
  //       showSnackBar(subtitle: "Something went wrong, please try again");
  //     }
  //   });
  // }

  // RxList<AvailableDate>? doctorsAvailability = <AvailableDate>[].obs;

  // final DateTime selectedDay = DateTime.now();
  // final RxMap<String, List<String>> availableSlots =
  //     <String, List<String>>{}.obs; // Stores slots for each available date
  // final RxList<String> enabledDates = <String>[].obs;
  // // RxString selectedSlot = "".obs;
  // RxList<String> selectedSlots = <String>[].obs;
  // Map<String, List<String>> weeklySlots = {};
  // void processAvailabilityData() {
  //   Set<String> weekDays = {};
  //   DateTime today = DateTime.now();
  //   DateTime oneYearLater = today.add(const Duration(days: 365));

  //   final RxMap<String, List<String>> tempAvailableSlots =
  //       <String, List<String>>{}.obs;
  //   final RxList<String> tempEnabledDates = <String>[].obs;
  //   final Map<String, List<String>> tempWeeklySlots = {};

  //   for (var dateEntry in doctorsAvailability ?? []) {
  //     final String? availabilityType = dateEntry.availabilityType;
  //     final String? date = dateEntry.date;

  //     final List<AvailableTimeSlot> slots = dateEntry.availableTimeSlot ?? [];

  //     final List<String> timeSlots = slots
  //         .map((slot) => "${slot.startTime ?? ""} - ${slot.endTime ?? ""}")
  //         .toList();

  //     if (availabilityType == "Every Week") {
  //       // Get weekday name (e.g., "Monday") from the date
  //       final DateTime? dateObj = DateTime.tryParse(date ?? "");
  //       if (dateObj != null) {
  //         String weekDay = DateFormat('EEEE').format(dateObj);
  //         weekDays.add(weekDay);

  //         tempWeeklySlots[weekDay] ??= [];
  //         tempWeeklySlots[weekDay]?.addAll(timeSlots);
  //       }
  //     } else if (availabilityType == "Specific Dates") {
  //       if (date != null) {
  //         tempEnabledDates.add(date);
  //         tempAvailableSlots[date] ??= [];
  //         tempAvailableSlots[date]?.addAll(timeSlots);
  //       }
  //     }
  //   }

  //   // Fill available slots for recurring weekly availability for the next year
  //   for (var day = today;
  //       day.isBefore(oneYearLater);
  //       day = day.add(const Duration(days: 1))) {
  //     final String weekdayName = DateFormat('EEEE').format(day);
  //     if (weekDays.contains(weekdayName)) {
  //       final String key =
  //           "${day.month}-${day.day < 10 ? "0${day.day}" : "${day.day}"}-${day.year}";
  //       tempEnabledDates.add(key);
  //       tempAvailableSlots[key] = tempWeeklySlots[weekdayName]?.toList() ?? [];
  //     }
  //   }

  //   // Update reactive values
  //   enabledDates
  //       .assignAll(tempEnabledDates.toSet().toList()); // to avoid duplicates
  //   availableSlots.assignAll(tempAvailableSlots);
  //   enabledDates.refresh();
  //   availableSlots.refresh();

  //   log("Enabled Dates: $enabledDates");
  //   log("Available Slots: $availableSlots");

  //   update();
  // }

  updateAppointment({
    required String patientId,
    required String date,
    required String appointmentId,
  }) {
    List<Map<String, dynamic>> slots = [];
    selectedSlots.map((element) {
      slots.add({
        "start_time": element.split("-")[0].trim(),
        "end_time": element.split("-")[1].trim(),
      });
      log("Selected Slot: $element");
    }).toList();

    Map<String, dynamic> data = {
      "doctor_id": BaseStorage.read(StorageKeys.userId) ?? "",
      "patient_id": patientId,
      "appointment_id": appointmentId,
      "date": date,
      "slot": slots,
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().rescheduleAppointment, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            Get.back();
            getAppointmentList();
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
}
