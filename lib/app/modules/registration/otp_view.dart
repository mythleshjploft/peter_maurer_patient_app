import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/controllers/signup_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/modules/login/login_view.dart';
import 'package:peter_maurer_patients_app/app/modules/registration/create_view.dart';
import 'package:peter_maurer_patients_app/app/modules/registration/step_progress_indicator.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});
  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  SignupController controller = Get.find<SignupController>();
  final formKey = GlobalKey<FormState>();
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
              top: 90,
              left: 0,
              right: 0,
              child: StepProgressIndicator(
                currenStep: 2,
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
                            const Text(
                              'An OTP has been sent your email',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              controller.emailController.text,
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
                              child: const Text(
                                "Login here",
                                style: TextStyle(color: Color(0xff2EB3D6)
                                    // Apply underline decoration
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                              hintText: "OTP",
                              controller: controller.otpController,
                              validator: (val) {
                                if (val?.isEmpty ?? true) {
                                  return "Please enter OTP";
                                } else if (val?.length != 6) {
                                  return "Please enter valid OTP";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            CustomButton(
                              text: "Verify",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  controller.verifyOtp();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Did not recieve code? 00:30s',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            InkWell(
                              onTap: () {
                                // Get.to(LoginView());
                              },
                              child: const Text(
                                "Resend OTP",
                                style: TextStyle(
                                  color: Color(0xff2EB3D6),
                                  decoration: TextDecoration.underline,
                                  // Apply underline decoration
                                ),
                              ),
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
      ),
    );
  }
}

class TermsCheckbox extends StatefulWidget {
  const TermsCheckbox({super.key});

  @override
  _TermsCheckboxState createState() => _TermsCheckboxState();
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
                const TextSpan(text: "I have read and accept 4Smile's "),
                _linkText("Terms of Use", () {
                  // Handle Terms of Use click
                }),
                const TextSpan(text: ", "),
                _linkText("Privacy Policy", () {
                  // Handle Privacy Policy click
                }),
                const TextSpan(text: ", "),
                _linkText("Terms & Conditions", () {
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
