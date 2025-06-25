import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/dashboard_view.dart';
import 'package:peter_maurer_patients_app/app/models/login_screen/login_response.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_api_service.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_variables.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isRemember = false.obs;

  login() async {
    String deviceToken = await BaseStorage.read(StorageKeys.fcmToken) ?? "";
    Map<String, dynamic> data = {
      "country_code": "",
      "mobile_number": "",
      "device_token": deviceToken,
      "device_type": Platform.isIOS ? "Ios" : "Android",
      "email": emailController.text.trim().toLowerCase(),
      "password": passwordController.text,
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().login, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          LoginResponse response = LoginResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            BaseStorage.write(
                StorageKeys.apiToken, response.data?.token?.toString() ?? "");
            BaseStorage.write(
                StorageKeys.userId, response.data?.user?.id?.toString() ?? "");
            BaseStorage.write(StorageKeys.firstName,
                response.data?.user?.firstName?.toString() ?? "");
            BaseStorage.write(StorageKeys.lastName,
                response.data?.user?.lastName?.toString() ?? "");
            BaseStorage.write(StorageKeys.isLoggedIn, true);
            if (isRemember.value) {
              BaseStorage.write(StorageKeys.isRememberMe, true);
              BaseStorage.write(StorageKeys.rememberEmail,
                  emailController.text.trim().toLowerCase());
              BaseStorage.write(
                  StorageKeys.rememberPassword, passwordController.text);
            } else {
              BaseStorage.write(StorageKeys.isRememberMe, false);
            }
            Get.offAll(() => const DashBoardView());
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
}
