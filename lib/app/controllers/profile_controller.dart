import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/models/profile_screen/profile_details_response.dart';
import 'package:peter_maurer_patients_app/app/models/sign_up_screen/city_list_response.dart';
import 'package:peter_maurer_patients_app/app/models/sign_up_screen/country_list_response.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_api_service.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_responses/base_success_response.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_variables.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart' as dio;

class ProfileController extends GetxController {
  Rx<ProfileDatum?>? profileData = ProfileDatum().obs;
  RxBool isLoading = true.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  onInit() {
    super.onInit();
    getCountryList();
  }

  getProfileDetails() async {
    try {
      isLoading.value = true;
      BaseApiService()
          .get(apiEndPoint: ApiEndPoints().profileDetails, showLoader: false)
          .then((value) {
        refreshController.refreshCompleted();
        if (value?.statusCode == 200) {
          try {
            ProfileDetailResponse response =
                ProfileDetailResponse.fromJson(value?.data);
            if ((response.success ?? false)) {
              profileData?.value = response.data?.data ?? ProfileDatum();
              profileData?.refresh();
              isLoading.value = false;
              update();
            } else {
              showSnackBar(subtitle: response.message ?? "");
            }
          } catch (e) {
            showSnackBar(subtitle: "$e");
          }
        } else {
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      log("$e");
      refreshController.refreshCompleted();
    }
  }

  updateProfileImage({required File image}) async {
    dio.FormData data = dio.FormData.fromMap({});
    if ((image.path).isNotEmpty) {
      data.files.add(MapEntry(
          "image",
          await dio.MultipartFile.fromFile(image.path,
              filename: image.path.split("/").last)));
    }
    BaseApiService()
        .put(
      apiEndPoint: ApiEndPoints().updateProfile,
      headers: {
        "Authorization":
            "Bearer ${BaseStorage.read(StorageKeys.apiToken) ?? ""}"
      },
      data: data,
    )
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            getProfileDetails();
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

  ////// For Edit Screen

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  RxString countryCode = "+49".obs;
  TextEditingController countrySearchController = TextEditingController();
  TextEditingController citySearchController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxList<CountryDatum> countryList = <CountryDatum>[].obs;
  CountryDatum? selectedCountry;
  RxList<CityDatum> cityList = <CityDatum>[].obs;
  CityDatum? selectedCity;
  List<String> genderList = ["Male", "Female", "Other"];
  String? selectedGender;
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  RxBool isChecked = false.obs;

  selectDob(BuildContext context) async {
    await showBaseDatePicker(context, showDOBDates: true).then((value) {
      if (value.isNotEmpty) {
        dobController.text = value;
      }
    });
  }

  getCountryList() async {
    BaseApiService().get(apiEndPoint: ApiEndPoints().countryList).then((value) {
      if (value?.statusCode == 200) {
        try {
          CountryListResponse response =
              CountryListResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            countryList.value = response.data ?? [];
            countryList.refresh();
            update();
          } else {
            showSnackBar(subtitle: response.error ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  getCityList() async {
    BaseApiService()
        .get(
            apiEndPoint: ApiEndPoints().cityList +
                (selectedCountry?.id?.toString() ?? ""))
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          CityListResponse response = CityListResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            cityList.value = [];
            selectedCity = null;
            cityList.value = response.data ?? [];
            cityList.refresh();
            update();
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

  updateProfile() async {
    Map<String, dynamic> data = {
      "first_name": nameController.text.trim(),
      "last_name": lastNameController.text.trim(),
      "gender": selectedGender ?? "",
      "country_code": countryCode.value,
      "mobile_number": phoneController.text.trim(),
      "email": emailController.text.trim(),
      "dob": dobController.text.trim(),
      "country_id": selectedCountry?.id?.toString() ?? "",
      "city_id": selectedCity?.id?.toString() ?? "",
      "zip_code": zipCodeController.text.trim(),
    };
    BaseApiService()
        .put(apiEndPoint: ApiEndPoints().updateProfile, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.success ?? false) {
            getProfileDetails();
            Get.back();
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
