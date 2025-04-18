import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/models/home_screen/home_screen_response.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_api_service.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_variables.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  RxBool isHomeLoading = true.obs;
  Rx<HomeScreenDatum?> homeScreenData = HomeScreenDatum().obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxList<Appointemnt> filteredAppointments = <Appointemnt>[].obs;
  getHomeScreenData() async {
    isHomeLoading.value = true;
    try {
      BaseApiService()
          .get(apiEndPoint: ApiEndPoints().dashboard, showLoader: false)
          .then((value) {
        isHomeLoading.value = false;
        refreshController.refreshCompleted();
        if (value?.statusCode == 200) {
          try {
            HomeScreenResponse response =
                HomeScreenResponse.fromJson(value?.data);
            if ((response.success ?? false)) {
              homeScreenData.value = response.data ?? HomeScreenDatum();
              filteredAppointments.value =
                  homeScreenData.value?.appointemnt ?? [];
              filteredAppointments.refresh();
              homeScreenData.refresh();
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
    } catch (e) {
      isHomeLoading.value = false;
      refreshController.refreshCompleted();
      showSnackBar(subtitle: "Something went wrong, please try again");
    }
  }

  void filterAppointments(String query) {
    final allAppointments = homeScreenData.value?.appointemnt ?? [];
    if (query.isEmpty) {
      filteredAppointments.value = allAppointments;
    } else {
      final lowerQuery = query.toLowerCase();
      filteredAppointments.value = allAppointments.where((appointment) {
        final fullName =
            "${appointment.doctorId?.firstName ?? ""} ${appointment.doctorId?.lastName ?? ""}"
                .toLowerCase();
        return fullName.contains(lowerQuery);
      }).toList();
    }
  }
}
