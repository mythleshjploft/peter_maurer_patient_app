import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/controllers/forgot_password_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordController controller = Get.put(ForgotPasswordController());

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
                                CustomTextField(
                                  hintText: "Email",
                                  controller: controller.emailController,
                                  validator: (val) {
                                    if ((val ?? "").isEmpty) {
                                      return "Please Fill this field";
                                    } else if (!(GetUtils.isEmail(val ?? ""))) {
                                      return "Please enter valid email";
                                    }
                                    return null;
                                  },
                                ),
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
                                      controller.forgotPassword();
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
