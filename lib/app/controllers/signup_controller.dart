import 'package:dio/dio.dart' as dio;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/dashboard_view.dart';
import 'package:peter_maurer_patients_app/app/models/sign_up_screen/city_list_response.dart';
import 'package:peter_maurer_patients_app/app/models/sign_up_screen/country_list_response.dart';
import 'package:peter_maurer_patients_app/app/models/sign_up_screen/sign_up_response.dart';
import 'package:peter_maurer_patients_app/app/modules/registration/create_view.dart';
import 'package:peter_maurer_patients_app/app/modules/registration/otp_view.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_api_service.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_responses/base_success_response.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_variables.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';

class SignupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController otpController = TextEditingController();
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

  @override
  onInit() {
    getCountryList();
    super.onInit();
  }

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

  verifyOtp() async {
    Map<String, dynamic> data = {
      "otp": otpController.text.trim(),
      "mobile_number": phoneController.text.trim(),
      "country_code": countryCode.value
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

            Get.to(() => const CreateView());
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

  savePassword() async {
    Map<String, dynamic> data = {
      "password": passwordController.text.trim(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().savePassword, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            BaseStorage.write(StorageKeys.isLoggedIn, true);
            Get.offAll(() => const DashBoardView());
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

  registerAccount() async {
    dio.FormData data = dio.FormData.fromMap({
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
      "device_token": "123456789",
    });
    // if ((selectedLicenseImage?.value?.path ?? '').isNotEmpty) {
    //   data.files.add(MapEntry(
    //       "license",
    //       await dio.MultipartFile.fromFile(selectedLicenseImage!.value!.path,
    //           filename: selectedLicenseImage!.value!.path.split("/").last)));
    // }
    BaseApiService().post(
        apiEndPoint: ApiEndPoints().registerAccount,
        data: data,
        headers: {}).then((value) {
      if (value?.statusCode == 200) {
        try {
          SignUpResponse response = SignUpResponse.fromJson(value?.data);
          if (response.success ?? false) {
            BaseStorage.write(
                StorageKeys.apiToken, response.data?.token?.toString() ?? "");
            BaseStorage.write(
                StorageKeys.userId, response.data?.user?.id?.toString() ?? "");
            BaseStorage.write(StorageKeys.firstName,
                response.data?.user?.firstName?.toString() ?? "");
            BaseStorage.write(StorageKeys.lastName,
                response.data?.user?.lastName?.toString() ?? "");

            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            Get.to(() => const OtpView());
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
