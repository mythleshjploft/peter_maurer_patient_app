import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/profile_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_button.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_dropdown.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_phone_field.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/models/sign_up_screen/city_list_response.dart';
import 'package:peter_maurer_patients_app/app/models/sign_up_screen/country_list_response.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_colors.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  ProfileController controller = Get.find<ProfileController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Personal info",
        onActionPress: () {},
      ),
      body: Form(
        key: formKey,
        child: GetBuilder<ProfileController>(builder: (logic) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
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
                                  fontSize: 16, fontWeight: FontWeight.w400),
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
                            builder: (FormFieldState<String> state) => Column(
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
                                )),
                        const SizedBox(height: 18),
                        const Row(
                          children: [
                            Text(
                              "Phone no",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
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
                            builder: (FormFieldState<String> state) => Column(
                                  children: [
                                    CustomIntlPhoneField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 32, vertical: 16),
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
                                                  ? BaseColors.errorColor
                                                  : AppColors.primaryColor),
                                        ),
                                      ),
                                      validator: (val) {
                                        if ((val?.number ?? "").isEmpty) {
                                          return "Please Fill this field";
                                        }
                                        return null;
                                      },
                                      disableLengthCheck: true,
                                      controller: controller.phoneController,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(15)
                                      ], // Only numbers can be entered
                                      dropdownIcon: const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 25,
                                        color: AppColors.grayMedium,
                                      ),
                                      pickerDialogStyle: PickerDialogStyle(
                                          backgroundColor: Colors.white),
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
                                  fontSize: 16, fontWeight: FontWeight.w400),
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
                          builder: (FormFieldState<String> state) => Column(
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
                                  fontSize: 16, fontWeight: FontWeight.w400),
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
                          builder: (FormFieldState<String> state) => Column(
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
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomButton(
                      text: "Login",
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          controller.updateProfile();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 22),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
