import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/controllers/signup_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/modules/login/login_view.dart';
import 'package:peter_maurer_patients_app/app/modules/registration/step_progress_indicator.dart';

class CreateView extends StatefulWidget {
  const CreateView({super.key});
  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  SignupController controller = Get.find<SignupController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignupController>(builder: (logic) {
        return Form(
          key: formKey,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/splash_background_img.png', // Replace with your background image path
                fit: BoxFit.cover,
              ),
              const Positioned(
                top: 90,
                left: 0,
                right: 0,
                child: StepProgressIndicator(
                  currenStep: 3,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 140,
                child: Stack(
                  children: [
                    Center(
                        child:
                            Image.asset('assets/images/registration_card.png')),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        // color: Colors.red,
                        height: MediaQuery.of(context).size.height * 0.75,
                        margin: const EdgeInsets.only(top: 50),
                        child: SingleChildScrollView(
                          // Wrap your content with SingleChildScrollView
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Enter your password'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Kindly enter your password to confirm'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const LoginView());
                                },
                                child: Text(
                                  "Login here".tr,
                                  style:
                                      const TextStyle(color: Color(0xff2EB3D6)
                                          // Apply underline decoration
                                          ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CustomTextField(
                                hintText: "Password",
                                controller: controller.passwordController,
                                validator: (val) {
                                  if ((val?.trim() ?? "").isEmpty) {
                                    return "Please Fill this field";
                                  } else if (val!.length < 6) {
                                    return "Password must be at least 6 characters";
                                  } else if (!RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                      .hasMatch(
                                          controller.passwordController.text)) {
                                    return "Password must contain uppercase, lowercase, number and special character";
                                  }
                                  return null;
                                },
                                isPassword: controller.obscurePassword.value,
                                suffixIcon: controller.obscurePassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onSuffixTap: () {
                                  controller.obscurePassword.value =
                                      !controller.obscurePassword.value;
                                  controller.update();
                                },
                              ),
                              const SizedBox(height: 18),
                              CustomTextField(
                                hintText: "Confirm password",
                                controller:
                                    controller.confirmPasswordController,
                                validator: (val) {
                                  if ((val ?? "").isEmpty) {
                                    return "Please Fill this field";
                                  } else if (controller
                                          .passwordController.text !=
                                      controller
                                          .confirmPasswordController.text) {
                                    return "Password does not match";
                                  } else if (!RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                      .hasMatch(controller
                                          .confirmPasswordController.text)) {
                                    return "Password must contain uppercase, lowercase, number and special character";
                                  }
                                  return null;
                                },
                                isPassword:
                                    controller.obscureConfirmPassword.value,
                                suffixIcon:
                                    controller.obscureConfirmPassword.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                onSuffixTap: () {
                                  controller.obscureConfirmPassword.value =
                                      !controller.obscureConfirmPassword.value;
                                  controller.update();
                                },
                              ),
                              const SizedBox(height: 22),
                              CustomButton(
                                text: "Confirm",
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    controller.savePassword();
                                  }
                                  // Get.to(const LoginView());
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class TermsCheckbox extends StatefulWidget {
  const TermsCheckbox({super.key});

  @override
  State<TermsCheckbox> createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<TermsCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Checkbox
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),

        /// Terms Text
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, color: Colors.black),
              children: [
                TextSpan(text: "I have read and accept ".tr),
                _linkText("Terms of Use", () {
                  // Handle Terms of Use click
                }),
                const TextSpan(text: ", "),
                _linkText("Privacy Policy".tr, () {
                  // Handle Privacy Policy click
                }),
                const TextSpan(text: ", "),
                _linkText("Terms & Conditions".tr, () {
                  // Handle Terms & Conditions click
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Function to create a clickable link
  TextSpan _linkText(String text, VoidCallback onTap) {
    return TextSpan(
      text: text,
      style: const TextStyle(
        color: Color(0xff2EB3D6),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
}
