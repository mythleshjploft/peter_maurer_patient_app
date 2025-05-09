import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/controllers/login_controller.dart';
import 'package:peter_maurer_patients_app/app/controllers/social_login_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_social_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/modules/registration/registration_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = Get.put(LoginController());
  SocialLoginController socialLoginController =
      Get.put(SocialLoginController());

  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 56,
                              ),
                              CustomTextField(
                                hintText: "Email or Name",
                                controller: controller.emailController,
                                validator: (val) {
                                  if ((val ?? "").isEmpty) {
                                    return "Please Fill this field";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomTextField(
                                hintText: "Password",
                                controller: controller.passwordController,
                                isPassword: !isPasswordVisible,
                                validator: (val) {
                                  if ((val ?? "").isEmpty) {
                                    return "Please Fill this field";
                                  } else if ((val ?? "").length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                                suffixIcon: isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onSuffixTap: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: false, onChanged: (value) {}),
                                      Text("Keep me login".tr),
                                    ],
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Forgot Password?".tr,
                                        style: const TextStyle(
                                          color: Colors
                                              .black, // Set the text color to black
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration
                                              .underline, // Apply underline decoration
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                              CustomButton(
                                text: "Login".tr,
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    controller.login();
                                  }
                                  // Get.to(const BaseView());
                                },
                              ),
                              const SizedBox(height: 22),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/devider_l.svg"),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text("or login with".tr),
                                  ),
                                  SvgPicture.asset("assets/icons/devider_r.svg")
                                ],
                              ),
                              const SizedBox(height: 24),
                              CustomSocialButton(
                                text: "Login with Google",
                                imagePath:
                                    "assets/icons/google_icon.svg", // Add your Google icon in assets
                                onPressed: () {
                                  showBaseLoader();
                                  socialLoginController
                                      .signInWithGoogle()
                                      .then((val) {
                                    dismissBaseLoader();
                                    if (val.isEmpty) {
                                      socialLoginController.socialLoginApi();
                                    }
                                  });
                                  // Handle Google login
                                },
                              ),
                              const SizedBox(height: 10),
                              Visibility(
                                visible: Platform.isIOS,
                                child: CustomSocialButton(
                                  text: "Login with Apple",
                                  imagePath:
                                      "assets/icons/apple_logo.svg", // Add your Facebook icon in assets
                                  onPressed: () {
                                    showBaseLoader();
                                    socialLoginController
                                        .signInWithApple()
                                        .then((val) {
                                      dismissBaseLoader();
                                      if (val.isEmpty) {
                                        socialLoginController.socialLoginApi();
                                      }
                                    });
                                    // Handle Facebook login
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don’t have an account?".tr),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(
                                          const PersonalInfoRegistrationView());
                                    },
                                    child: Text("Create new account".tr),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
