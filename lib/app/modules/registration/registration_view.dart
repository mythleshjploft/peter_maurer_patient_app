import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/signup_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_dropdown.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_phone_field.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/models/sign_up_screen/city_list_response.dart';
import 'package:peter_maurer_patients_app/app/models/sign_up_screen/country_list_response.dart';
import 'package:peter_maurer_patients_app/app/modules/login/login_view.dart';
import 'package:peter_maurer_patients_app/app/modules/registration/otp_view.dart';
import 'package:peter_maurer_patients_app/app/modules/registration/step_progress_indicator.dart';

class PersonalInfoRegistrationView extends StatefulWidget {
  const PersonalInfoRegistrationView({super.key});
  @override
  State<PersonalInfoRegistrationView> createState() =>
      _PersonalInfoRegistrationViewState();
}

class _PersonalInfoRegistrationViewState
    extends State<PersonalInfoRegistrationView> {
  bool isPasswordVisible = false;

  SignupController controller = Get.put(SignupController());
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
              Positioned(
                top: 90,
                left: 0,
                right: 0,
                child: StepProgressIndicator(
                  currenStep: 1,
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
                                'Patient Registration',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'If you already have an account,',
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
                                hintText: "First Name",
                                controller: controller.nameController,
                                validator: (val) {
                                  if ((val ?? "").isEmpty) {
                                    return "Please Fill this field";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 18),
                              CustomTextField(
                                hintText: "Last name",
                                controller: controller.lastNameController,
                                validator: (val) {
                                  if ((val ?? "").isEmpty) {
                                    return "Please Fill this field";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 18),
                              const Row(
                                children: [
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FormField<String>(
                                  validator: (value) {
                                    if ((controller.selectedGender == null)) {
                                      return 'Please Select Gender'; // Custom validation message
                                    }
                                    return null;
                                  },
                                  builder: (FormFieldState<String> state) =>
                                      Column(
                                        children: [
                                          CustomDropdownButton2<String?>(
                                            hintText: "Select Gender",
                                            items: controller.genderList,
                                            value: controller.selectedGender,
                                            displayText: (item) => item ?? "",
                                            onChanged: (value) {
                                              controller.selectedGender = value;
                                              controller.update();
                                            },
                                            hasError: state.hasError,
                                          ),
                                          if (state.hasError)
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25.0, top: 10),
                                                  child: Text(
                                                    state.errorText ?? '',
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.errorColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ],
                                      )),
                              const SizedBox(height: 18),
                              const Row(
                                children: [
                                  Text(
                                    "Phone no",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FormField<String>(
                                  validator: (value) {
                                    if ((controller.phoneController.text
                                        .trim()
                                        .isEmpty)) {
                                      return 'Please fill this field'; // Custom validation message
                                    }
                                    return null;
                                  },
                                  builder: (FormFieldState<String> state) =>
                                      Column(
                                        children: [
                                          CustomIntlPhoneField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 32,
                                                      vertical: 16),
                                              hintText: "Phone no",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: state.hasError
                                                        ? AppColors.errorColor
                                                        : AppColors
                                                            .primaryColor),
                                              ),
                                            ),
                                            validator: (val) {
                                              if ((val?.number ?? "").isEmpty) {
                                                return "Please Fill this field";
                                              }
                                              return null;
                                            },
                                            disableLengthCheck: true,
                                            controller:
                                                controller.phoneController,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  15)
                                            ], // Only numbers can be entered
                                            dropdownIcon: const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              size: 25,
                                              color: AppColors.grayMedium,
                                            ),
                                            pickerDialogStyle:
                                                PickerDialogStyle(
                                                    backgroundColor:
                                                        Colors.white),
                                            flagsButtonPadding:
                                                const EdgeInsets.only(left: 7),
                                            initialCountryCode: 'DE',
                                            onCountryChanged: (val) {
                                              log(val.code);
                                              controller.countryCode.value =
                                                  val.dialCode;
                                            },
                                          ),
                                          if (state.hasError)
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25.0, top: 10),
                                                  child: Text(
                                                    state.errorText ?? '',
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.errorColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ],
                                      )),
                              const SizedBox(height: 22),
                              CustomTextField(
                                hintText: "Email",
                                controller: controller.emailController,
                                validator: (val) {
                                  if ((val ?? "").isEmpty) {
                                    return "Please Fill this field";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 22),
                              CustomTextField(
                                hintText: "Date of birth",
                                controller: controller.dobController,
                                readOnly: true,
                                onTap: () {
                                  controller.selectDob(context);
                                },
                                validator: (val) {
                                  if ((val ?? "").isEmpty) {
                                    return "Please Fill this field";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 22),
                              const Row(
                                children: [
                                  Text(
                                    "Country",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FormField<String>(
                                validator: (value) {
                                  if ((controller.selectedCountry == null)) {
                                    return 'Please fill this field'; // Custom validation message
                                  }
                                  return null;
                                },
                                builder: (FormFieldState<String> state) =>
                                    Column(
                                  children: [
                                    CustomDropdownButton2<CountryDatum?>(
                                      hintText: "Select Country",
                                      items: controller.countryList,
                                      value: controller.selectedCountry,
                                      displayText: (item) => item?.name ?? "",
                                      hasError: state.hasError,
                                      onChanged: (value) {
                                        controller.selectedCountry = value;
                                        controller.update();
                                        controller.getCityList();
                                      },
                                      searchHintText: "Search Country",
                                      searchController:
                                          controller.countrySearchController,
                                    ),
                                    if (state.hasError)
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0, top: 10),
                                            child: Text(
                                              state.errorText ?? '',
                                              style: const TextStyle(
                                                color: AppColors.errorColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22),
                              const Row(
                                children: [
                                  Text(
                                    "City",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FormField<String>(
                                validator: (value) {
                                  if ((controller.selectedCountry == null)) {
                                    return 'Please fill this field'; // Custom validation message
                                  }
                                  return null;
                                },
                                builder: (FormFieldState<String> state) =>
                                    Column(
                                  children: [
                                    CustomDropdownButton2<CityDatum?>(
                                      hintText: "Select City",
                                      items: controller.cityList,
                                      hasError: state.hasError,
                                      value: controller.selectedCity,
                                      displayText: (item) => item?.name ?? "",
                                      onChanged: (value) {
                                        controller.selectedCity = value;
                                        controller.update();
                                      },
                                      searchHintText: "Search City",
                                      searchController:
                                          controller.citySearchController,
                                    ),
                                    if (state.hasError)
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0, top: 10),
                                            child: Text(
                                              state.errorText ?? '',
                                              style: const TextStyle(
                                                color: AppColors.errorColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22),
                              CustomTextField(
                                hintText: "Zip code",
                                controller: controller.zipCodeController,
                                validator: (val) {
                                  if ((val ?? "").isEmpty) {
                                    return "Please Fill this field";
                                  }
                                  return null;
                                },
                              ),
                              // const SizedBox(height: 22),
                              // CustomTextField(
                              //   hintText: "Password",
                              //   controller: controller.passwordController,
                              //   validator: (val) {
                              //     if ((val?.trim() ?? "").isEmpty) {
                              //       return "Please Fill this field";
                              //     } else if (val!.length < 6) {
                              //       return "Password must be at least 6 characters";
                              //     }
                              //     return null;
                              //   },
                              //   isPassword: controller.obscurePassword.value,
                              //   suffixIcon: controller.obscurePassword.value
                              //       ? Icons.visibility
                              //       : Icons.visibility_off,
                              //   onSuffixTap: () {
                              //     controller.obscurePassword.value =
                              //         !controller.obscurePassword.value;
                              //     controller.update();
                              //   },
                              // ),
                              // const SizedBox(height: 22),
                              // CustomTextField(
                              //   hintText: "Confirm Password",
                              //   controller: controller.confirmPasswordController,
                              //   validator: (val) {
                              //     if ((val ?? "").isEmpty) {
                              //       return "Please Fill this field";
                              //     } else if (controller.passwordController.text !=
                              //         controller.confirmPasswordController.text) {
                              //       return "Password does not match";
                              //     }
                              //     return null;
                              //   },
                              //   isPassword:
                              //       controller.obscureConfirmPassword.value,
                              //   suffixIcon:
                              //       controller.obscureConfirmPassword.value
                              //           ? Icons.visibility
                              //           : Icons.visibility_off,
                              //   onSuffixTap: () {
                              //     controller.obscureConfirmPassword.value =
                              //         !controller.obscureConfirmPassword.value;
                              //     controller.update();
                              //   },
                              // ),
                              const SizedBox(height: 22),
                              const TermsCheckbox(),
                              const SizedBox(height: 22),
                              CustomButton(
                                  text: "sign Up",
                                  onPressed: () {
                                    if (controller.isChecked.value) {
                                      if (formKey.currentState?.validate() ??
                                          false) {
                                        controller.registerAccount();
                                      }
                                    }
                                  }),
                              const SizedBox(
                                height: 50,
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
  _TermsCheckboxState createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<TermsCheckbox> {
  SignupController controller = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Checkbox
        Checkbox(
          value: controller.isChecked.value,
          onChanged: (value) {
            setState(() {
              controller.isChecked.value = value!;
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
