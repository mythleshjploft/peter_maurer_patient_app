import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/controllers/forgot_password_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ForgotPasswordController controller = Get.find<ForgotPasswordController>();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/splash_background_img.png', // Replace with your background image path
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo_img.png', // Replace with your logo image path
                    width: 257,
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: -20,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    Center(child: Image.asset('assets/images/card_login.png')),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Obx(() => CustomTextField(
                                      hintText: "Password",
                                      controller: controller.passwordController,
                                      validator: (val) {
                                        if ((val?.trim() ?? "").isEmpty) {
                                          return "Please Fill this field";
                                        } else if (val!.length < 6) {
                                          return "Password must be at least 6 characters";
                                        }
                                        return null;
                                      },
                                      isPassword:
                                          controller.obscurePassword.value,
                                      suffixIcon:
                                          controller.obscurePassword.value
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                      onSuffixTap: () {
                                        controller.obscurePassword.value =
                                            !controller.obscurePassword.value;
                                        controller.update();
                                      },
                                    )),
                                const SizedBox(height: 18),
                                Obx(() => CustomTextField(
                                      hintText: "Confirm password",
                                      controller:
                                          controller.confirmPasswordController,
                                      validator: (val) {
                                        if ((val ?? "").isEmpty) {
                                          return "Please Fill this field";
                                        } else if (controller
                                                .passwordController.text !=
                                            controller.confirmPasswordController
                                                .text) {
                                          return "Password does not match";
                                        }
                                        return null;
                                      },
                                      isPassword: controller
                                          .obscureConfirmPassword.value,
                                      suffixIcon: controller
                                              .obscureConfirmPassword.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      onSuffixTap: () {
                                        controller
                                                .obscureConfirmPassword.value =
                                            !controller
                                                .obscureConfirmPassword.value;
                                        controller.update();
                                      },
                                    )),
                                const SizedBox(height: 15),
                                // CustomTextField(
                                //   hintText: "Password",
                                //   controller: controller.passwordController,
                                //   isPassword: !isPasswordVisible,
                                //   validator: (val) {
                                //     if ((val ?? "").isEmpty) {
                                //       return "Please Fill this field";
                                //     } else if ((val ?? "").length < 6) {
                                //       return "Password must be at least 6 characters";
                                //     }
                                //     return null;
                                //   },
                                //   suffixIcon: isPasswordVisible
                                //       ? Icons.visibility
                                //       : Icons.visibility_off,
                                //   onSuffixTap: () {
                                //     setState(() {
                                //       isPasswordVisible = !isPasswordVisible;
                                //     });
                                //   },
                                // ),

                                const SizedBox(height: 10),
                                CustomButton(
                                  text: "Continue".tr,
                                  onPressed: () {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      controller.resetPassword();
                                      // controller.login();
                                    }
                                    // Get.to(const BaseView());
                                  },
                                ),
                                buildSizeHeight(250)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
