// ignore_for_file: non_constant_identifier_names
import 'dart:io';

// import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/modules/login/login_view.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_variables.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';
import 'package:url_launcher/url_launcher.dart';

triggerHapticFeedback() {
  HapticFeedback.lightImpact();
}

String formatBackendDate(String dateString, {bool? getDayFirst}) {
  if (dateString.isNotEmpty && dateString != "null") {
    DateTime date = DateTime.parse(dateString);
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString().substring(0);
    if (getDayFirst ?? false) {
      return '$day-$month-$year';
    } else {
      return '$year-$month-$day';
    }
  } else {
    return "";
  }
}

String formatEventDate(String dateString) {
  if (dateString.isNotEmpty && dateString != "null") {
    // Parse the input string to a DateTime object
    DateTime date = DateTime.parse(dateString);
    DateTime today = DateTime.now();

    // Format the date based on the year
    if (date.year == today.year) {
      return "${_monthName(date.month)} ${date.day}";
    } else {
      return "${_monthName(date.month)} ${date.day} ${date.year}";
    }
  } else {
    return "";
  }
}

// Helper function to get the month name
String _monthName(int month) {
  const List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return months[month - 1];
}

// To build sized boxes

SizedBox buildSizeHeight(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox buildSizeWidth(double width) {
  return SizedBox(
    width: width,
  );
}

// Show Dialogou Box

showBaseDialgueBox(
    {Widget? content,
    Widget? title,
    List<Widget>? actions,
    Widget? icon,
    double? horizontalPadding,
    double? verticalPadding,
    Color? backgroundColor,
    Color? barrierColor,
    bool? barrierdismissible}) {
  FocusManager.instance.primaryFocus?.unfocus();
  return Get.dialog(
      SizedBox(
        width: MediaQuery.of(Get.context!).size.width * 0.9,
        child: AlertDialog(
          contentPadding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 20,
              vertical: verticalPadding ?? 10),
          backgroundColor: backgroundColor ?? Colors.white,
          surfaceTintColor: backgroundColor ?? Colors.white,
          content: content,
          title: title,
          actions: actions,
          icon: icon,
        ),
      ),
      barrierColor: barrierColor,
      barrierDismissible: barrierdismissible ?? true);
}
// show Time picker

Future<String> showBaseTimePicker(BuildContext context) async {
  FocusManager.instance.primaryFocus?.unfocus();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: selectedTime,
    // initialEntryMode: TimePickerEntryMode.dialOnly,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryColor,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: AppColors.primaryColor,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
  );

  if (pickedTime != null) {
    selectedTime = pickedTime;
    return formatTime(selectedTime);
  } else {
    return "";
  }
}

//Show Date picker
Future<String> showBaseDatePicker(
  BuildContext context, {
  bool? isNoLastDate,
  bool? showBeforeDates,
  DateTime? selectedDate,
  bool? showDOBDates,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  // Determine the initial date
  DateTime initialDate = selectedDate ?? DateTime.now();
  if (showDOBDates ?? false) {
    // If showDOBDates is true, set initial date to 18 years back
    initialDate = DateTime.now().subtract(const Duration(days: (365 * 18) + 5));
  }
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    firstDate: (showBeforeDates ?? true) ? DateTime(1900) : DateTime.now(),
    // initialEntryMode: DatePickerEntryMode.calendarOnly,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryColor,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: AppColors.primaryColor,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
    lastDate: isNoLastDate ?? false
        ? DateTime(2100)
        : (showDOBDates ?? false)
            ? initialDate
            : DateTime.now(),
  );

  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
    if (showDOBDates ?? false) {
      return "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
    } else {
      return "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  } else {
    return "";
  }
}

//format time
String formatTime(TimeOfDay time) {
  int hour = time.hourOfPeriod;
  int minute = time.minute;
  String period = time.period == DayPeriod.am ? 'AM' : 'PM';

  return '$hour:${minute.toString().padLeft(2, '0')} $period';
}

//Logout dialogue

/////////////////////////////
String inFormat = "yyyy-MM-dd HH:mm:ss";
String IsoFormat = "yyyy-MM-ddThh:mm:ss";
String outFormat = "dd MMM yyyy";
String inFormat1 = "yyyy-MM-dd";
String outFormat1 = "dd-MM-yyyy";
String outFormat2 = "dd MMM";
String outFormat3 = "dd MMM yyyy, HH:mm a";
String outFormat4 = "dd MMM yyyy, hh:mm a";
String outFormat5 = "dd MMM yyyy, h:mm a";
String F12_Hours = "h:mm a";
String outFormat6 = "dd MMM yyyy • h:mm a";
String time = "dd MMM, h:mm a";
formatDateFromString(String? date, {String? input, String? output}) {
  if ((date ?? "").isEmpty) return "";
  var inputDate =
      DateFormat(input ?? inFormat).parse(date.toString(), true).toLocal();
  var outputDate = DateFormat(output ?? outFormat).format(inputDate);
  return outputDate.toString();
}

extension IsUser on String {
  bool isUser() {
    if (this == BaseStorage.read(StorageKeys.userId)) {
      return true;
    }
    return false;
  }
}

/////////////////////////////
Future<void> baseLaunchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

Future<File?> showMediaPicker(
    {bool? isCropEnabled, bool? showGalleryOption}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  XFile? pickedFile = XFile("");
  await Get.bottomSheet(
    Container(
        alignment: Alignment.center,
        height: 130,
        margin: const EdgeInsets.symmetric(
            horizontal: horizontalScreenPadding,
            vertical: horizontalScreenPadding),
        padding: const EdgeInsets.only(
            top: 5,
            right: horizontalScreenPadding,
            left: horizontalScreenPadding),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: (showGalleryOption ?? true)
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      await chooseCameraFile(isCropEnabled).then((value) {
                        if (value != null) {
                          pickedFile = XFile(value.path);
                        }
                        if (Get.isBottomSheetOpen ?? false) {
                          Get.back();
                        }
                      });
                      // await ImagePicker().pickImage(source: ImageSource.camera).then((value) {
                      //   pickedFile = value;
                      //   if (Get.isBottomSheetOpen??false) {
                      //     Get.back();
                      //   }
                      // });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.camera_alt_outlined,
                            color: AppColors.primaryColor, size: 60),
                        buildSizeHeight(10),
                        const Text("Camera",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: showGalleryOption ?? true,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        await chooseGalleryFile(isCropEnabled).then((value) {
                          if (value != null) {
                            pickedFile = XFile(value.path);
                          }
                          if (Get.isBottomSheetOpen ?? false) {
                            Get.back();
                          }
                        });
                        // await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
                        //   pickedFile = value;
                        //   if (Get.isBottomSheetOpen??false) {
                        //     Get.back();
                        //   }
                        // });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.photo_library_outlined,
                              color: AppColors.primaryColor, size: 60),
                          buildSizeHeight(10),
                          const Text("Gallery",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
    backgroundColor: Colors.transparent,
  );
  return File(pickedFile?.path ?? "");
}

Future<File?> chooseCameraFile(bool? isCropEnabled) async {
  final imgPicker = ImagePicker();
  File? files;
  dynamic choosenFile;
  await imgPicker.pickImage(source: ImageSource.camera).then((value) async {
    if (value != null) {
      // if (isCropEnabled ?? false) {
      //   choosenFile = await cropImage(
      //     File(value.path),
      //   );
      // } else {
      choosenFile = File(value.path);
      // }
    }
  });
  if (choosenFile != null) {
    files = File(choosenFile?.path ?? "");
  }
  return files;
}

Future<File?> chooseGalleryFile(bool? isCropEnabled) async {
  final imgPicker = ImagePicker();
  File? files;
  dynamic choosenFile;
  await imgPicker.pickImage(source: ImageSource.gallery).then((value) async {
    if (value != null) {
      // if (isCropEnabled ?? false) {
      //   choosenFile = await cropImage(
      //     File(value.path),
      //   );
      // } else {
      choosenFile = File(value.path);
      // }
    }
  });
  if (choosenFile != null) {
    files = File(choosenFile?.path ?? "");
  }
  return files;
}

// Future<CroppedFile?> cropImage(File imageFile) async {
//   CroppedFile? croppedFile;
//   await ImageCropper()
//       .cropImage(
//     sourcePath: imageFile.path,
//     aspectRatioPresets: [CropAspectRatioPreset.square],
//     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//     uiSettings: [
//       AndroidUiSettings(
//         toolbarTitle: 'Maccha Cropper',
//         activeControlsWidgetColor: Colors.black,
//         toolbarColor: CupertinoColors.white,
//         toolbarWidgetColor: Colors.black,
//         initAspectRatio: CropAspectRatioPreset.original,
//         // lockAspectRatio: true,
//         // hideBottomControls: false
//       ),
//       IOSUiSettings(
//         title: 'Maccha Cropper',
//         rotateButtonsHidden: true,
//         resetButtonHidden: true,
//         // aspectRatioPickerButtonHidden: true,
//         // aspectRatioLockDimensionSwapEnabled: true,
//         // resetAspectRatioEnabled: true,
//         // aspectRatioLockEnabled: true
//       ),
//     ],
//   )
//       .then((value) {
//     croppedFile = value;
//   });
//   return croppedFile;
// }

// Show Media Picker for video

Future<File?> showVideoPicker({bool? showGalleryOption}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  XFile? pickedFile = XFile("");
  await Get.bottomSheet(
    Container(
        alignment: Alignment.center,
        height: 130,
        margin: const EdgeInsets.symmetric(
            horizontal: horizontalScreenPadding,
            vertical: horizontalScreenPadding),
        padding: const EdgeInsets.only(
            top: 5,
            right: horizontalScreenPadding,
            left: horizontalScreenPadding),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: (showGalleryOption ?? true)
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      await ImagePicker()
                          .pickVideo(
                        source: ImageSource.camera,
                        maxDuration: const Duration(seconds: 30),
                      )
                          .then((value) {
                        pickedFile = value;
                        if (Get.isBottomSheetOpen ?? false) {
                          Get.back();
                        }
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.camera_alt_outlined,
                            color: AppColors.primaryColor, size: 60),
                        buildSizeHeight(10),
                        const Text("Camera",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: showGalleryOption ?? true,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        await ImagePicker()
                            .pickVideo(
                          source: ImageSource.gallery,
                          maxDuration: const Duration(seconds: 30),
                        )
                            .then((value) {
                          pickedFile = value;
                          if (Get.isBottomSheetOpen ?? false) {
                            Get.back();
                          }
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.photo_library_outlined,
                              color: AppColors.primaryColor, size: 60),
                          buildSizeHeight(10),
                          const Text("Gallery",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
    backgroundColor: Colors.transparent,
  );
  return File(pickedFile?.path ?? "");
}

void showBaseLoader({bool? showLoader, bool? isHideAfterTimeOut}) {
  if (showLoader ?? true) {
    Get.context!.loaderOverlay.show();
    if (isHideAfterTimeOut ?? true) {
      Future.delayed(const Duration(seconds: apiTimeOut), () {
        Get.context!.loaderOverlay.hide();
      });
    }
  }
}

void dismissBaseLoader({bool? showLoader}) {
  if (showLoader ?? true) {
    Get.context!.loaderOverlay.hide();
  }
}

showSnackBar({
  bool? isSuccess,
  String? title,
  String? subtitle,
  BuildContext? context,
  bool? removeFast,
  // bool? removeOnShowOther
}) {
  if (Get.isSnackbarOpen) {
    // log("$subtitle");
    // if (removeOnShowOther ?? false) {
    //   Get.closeAllSnackbars();
    // }
  } else {
    Get.snackbar(
      duration: removeFast ?? false
          ? const Duration(seconds: 1)
          : const Duration(seconds: 2),
      "",
      "",
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      titleText: Row(
        children: [
          Expanded(
            child: Text(
                (title ?? "").isEmpty
                    ? (isSuccess ?? false)
                        ? "Success!"
                        : "Error!"
                    : title ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                )),
          ),
          GestureDetector(
            onTap: () {
              triggerHapticFeedback();
              Get.closeCurrentSnackbar();
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
      messageText: Text(
        subtitle ?? "",
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(
          right: horizontalScreenPadding,
          left: horizontalScreenPadding,
          top: 18),
      backgroundColor: (isSuccess ?? false)
          ? Colors.green.shade900.withOpacity(0.8)
          : Colors.red.shade600.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  // final snackBar = SnackBar(
  //   elevation: 0,
  //   margin: EdgeInsets.only(right: horizontalScreenPadding, left: ),
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: Colors.transparent,
  //   content: AwesomeSnackbarContent(
  //     title: (title??"").isEmpty ? (isSuccess??false) ? "Success!" : "Error!" : title??"",
  //     message: subtitle??"",
  //     contentType: (isSuccess??false) ? ContentType.success : ContentType.failure,
  //   ),
  // );
  //
  // ScaffoldMessenger.of(context??Get.context!)
  //   ..hideCurrentSnackBar()
  //   ..showSnackBar(snackBar);
}

Widget customCheckBox(
    {required bool value,
    required Function(bool?) onChanged,
    Color? borderColor}) {
  return Checkbox(
    value: value,
    onChanged: onChanged,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    side: WidgetStateBorderSide.resolveWith((states) {
      return BorderSide(
          color: borderColor != null
              ? value
                  ? AppColors.primaryColor
                  : borderColor
              : AppColors.primaryColor,
          width: 1.5);
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
      side:
          BorderSide(color: borderColor ?? AppColors.primaryColor, width: 1.0),
    ),
    checkColor: AppColors.primaryColor,
    fillColor: const WidgetStatePropertyAll(AppColors.white),
  );
}

String getMaskedEmail(String email) {
  try {
    List<String> splittedEmail = email.split("@");
    String maskedEmail = "${"*" * splittedEmail[0].length}@${splittedEmail[1]}";

    return maskedEmail;
  } catch (e) {
    return email;
  }
}

String getAddressTypeNameByID({required String addressTypeID}) {
  switch (addressTypeID) {
    case "1":
      return "Home";
    case "2":
      return "Work";
    case "3":
      return "Friends & Family";
    case "4":
      return "Other";
    default:
      return "Home";
  }
}

String getAddressTypeNumber({required String getAddressTypeName}) {
  switch (getAddressTypeName) {
    case "Home":
      return "1";
    case "Work":
      return "2";
    case "Friends & Family":
      return "3";
    case "Other":
      return "4";
    default:
      return "1";
  }
}

String getBookingDetailsStatusTitle(
    {required String bookingDetailStatusNumber}) {
  switch (bookingDetailStatusNumber) {
    case "0":
      return "Not Accepted";
    case "1":
      return "Not Accepted";
    case "2":
      return "Pick-Up!";
    case "3":
      return "On The Way";
    case "4":
      return "Deliver Back To Home";
    case "5":
      return "Completed";
    default:
      return "Not Accepted";
  }
}

void clearSessionData() {
  triggerHapticFeedback();
  BaseStorage.box.erase();
  Get.offAll(() => const LoginView());
}

Widget cachedNetworkImage(
    {required String image,
    BoxFit? fit,
    Alignment? alignment,
    double? height,
    double? width,
    double? borderRadius}) {
  // log("Img Url--->>> ${ApiEndPoints().imgBaseUrl + image}");
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius ?? 0),
    child: CachedNetworkImage(
        imageUrl:
            //  image.trim(),
            image.contains("https")
                ? image
                : (ApiEndPoints().imgBaseUrl + image),
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.topCenter,
        height: height ?? 100,
        width: width ?? 100,
        // progressIndicatorBuilder: (context, url, progress) => BaseShimmer(
        //       height: height ?? 100,
        //       width: width ?? 100,
        //     ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        repeat: ImageRepeat.noRepeat,
        errorWidget: (context, url, error) => Container(
              height: height ?? 100,
              width: width ?? 100,
              decoration: const BoxDecoration(color: AppColors.grayMedium),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: height ?? 100,
                ),
              ),
            )),
  );
}

String getTimeAgo(dateInString) {
  final now = DateTime.now();
  if (dateInString != "") {
    DateTime date = DateTime.parse(dateInString);
    final difference = now.difference(date);

    // final formatter = DateFormat('yMd');
    // final formattedDate = formatter.format(date);

    final timeAgo = _timeAgo(difference);
    // log('$formattedDate, $timeAgo');
    return timeAgo;
  } else {
    return "";
  }
}

String _timeAgo(Duration duration) {
  if (duration.inDays >= 365) {
    final years = (duration.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  } else if (duration.inDays >= 30) {
    final months = (duration.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else if (duration.inDays >= 1) {
    return '${duration.inDays} ${duration.inDays == 1 ? 'day' : 'days'} ago';
  } else if (duration.inHours >= 1) {
    return '${duration.inHours} ${duration.inHours == 1 ? 'hr' : 'hrs'} ago';
  } else if (duration.inMinutes >= 1) {
    return '${duration.inMinutes} ${duration.inMinutes == 1 ? 'min' : 'min'} ago';
  } else {
    return 'just now';
  }
}

String calculateAge(String dateString) {
  if (dateString.isNotEmpty && dateString != "null") {
    try {
      DateTime birthDate = DateTime.parse(dateString);
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      int month1 = currentDate.month;
      int month2 = birthDate.month;
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = birthDate.day;
        if (day2 > day1) {
          age--;
        }
      }
      if (age <= 0) {
        return "";
      } else {
        return age.toString();
      }
    } catch (e) {
      return "";
    }
  } else {
    return "";
  }
}

// date time format
String monthYearDateFormat(String dateTimeString) {
  DateTime dateTime = DateTime.tryParse(dateTimeString) ?? DateTime.now();
  String formattedDate =
      "${_getDaySuffix(dateTime.day)} ${getMonthName(dateTime.month)} ${dateTime.year}";
  return formattedDate;
}

/// Get Day of a date
String getDayOfWeek(String date) {
  if (date != "" && date != "null") {
    try {
      // Parse the input string into a DateTime object
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);

      // Get the name of the day (e.g., Monday, Tuesday)
      String dayOfWeek = DateFormat('EEEE').format(parsedDate);

      return dayOfWeek;
    } catch (e) {
      return 'Invalid date format. Please use yyyy-MM-dd.';
    }
  } else {
    return "";
  }
}

Widget buildSVG(
    {required String svg, Color? color, double? height, double? width}) {
  return SvgPicture.asset(
    svg,
    height: height,
    width: width,
    colorFilter: color != null
        ? ColorFilter.mode(
            color,
            BlendMode.srcIn,
          )
        : null,
  );
}

String _getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return "${day}th";
  }
  switch (day % 10) {
    case 1:
      return "${day}st";
    case 2:
      return "${day}nd";
    case 3:
      return "${day}rd";
    default:
      return "${day}th";
  }
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "";
  }
}

String formatDuration(int seconds) {
  Duration duration = Duration(seconds: seconds);
  int minutes = duration.inMinutes;
  int remainingSeconds = seconds % 60;

  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = remainingSeconds.toString().padLeft(2, '0');

  return '$minutesStr:$secondsStr';
}

// to check if the text has only one letter and is an emoji

bool isSingleEmoji(String text) {
  if (text.isEmpty) {
    return false;
  }

  // Check if the character is an emoji
  final emojiRegex = RegExp(
    r'^[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{1F700}-\u{1F77F}\u{1F780}-\u{1F7FF}\u{1F800}-\u{1F8FF}\u{1F900}-\u{1F9FF}\u{1FA00}-\u{1FA6F}\u{2600}-\u{26FF}\u{2700}-\u{27BF}\u{2300}-\u{23FF}\u{2B50}\u{2B55}\u{2000}-\u{2BFF}\u{20D0}-\u{20FF}\u{FE00}-\u{FE0F}\u{E0020}-\u{E007F}\u{FE0E}\u{FE0F}]',
    unicode: true,
  );
  if (!emojiRegex.hasMatch(text)) {
    return false;
  }
  // Check if the text consists of only one character
  if (text.length != 2) {
    return false;
  }

  return true;
}

String formatLikes(int likeCount) {
  if (likeCount < 1000) {
    return likeCount.toString();
  } else if (likeCount < 1000000) {
    double count = likeCount / 1000;
    return '${count.toStringAsFixed(count.truncateToDouble() == count ? 0 : 1)} K';
  } else if (likeCount < 1000000000) {
    double count = likeCount / 1000000;
    return '${count.toStringAsFixed(count.truncateToDouble() == count ? 0 : 1)} M';
  } else {
    double count = likeCount / 1000000000;
    return '${count.toStringAsFixed(count.truncateToDouble() == count ? 0 : 1)} B';
  }
}

String changeDateFormatToNew(String inputDate) {
  // Parse the input date
  DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(inputDate);

  // Format it into dd/MM/yyyy format
  String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

  return formattedDate;
}

String changeDateFormatToOld(String inputDate) {
  // Parse the input date
  DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(inputDate);

  // Format it into yyyy-MM-dd format
  String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

  return formattedDate;
}
