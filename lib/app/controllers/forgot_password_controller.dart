import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/modules/login/login_view.dart';
import 'package:peter_maurer_patients_app/app/modules/registration/otp_view.dart';
import 'package:peter_maurer_patients_app/app/modules/registration/reset_password.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_api_service.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_responses/base_success_response.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_variables.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  forgotPassword() async {
    Map<String, dynamic> data = {
      "email": emailController.text.trim().toLowerCase(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().forgotPassword, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            Get.to(() => const OtpView(
                  isForgotPassword: true,
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

  resendOtp() async {
    Map<String, dynamic> data = {
      "email": emailController.text.trim(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().resendOtp, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
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

  verifyForgotPasswordOtp() async {
    Map<String, dynamic> data = {
      "otp": otpController.text.trim(),
      "email": emailController.text.trim().toLowerCase(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().verifyOtp, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);

            Get.to(() => const ResetPasswordScreen());
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

  resetPassword() async {
    Map<String, dynamic> data = {
      "email": emailController.text.trim().toLowerCase(),
      "password": passwordController.text,
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().resetPassword, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            Get.offAll(() => const LoginView());
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
