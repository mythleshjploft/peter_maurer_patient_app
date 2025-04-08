import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/models/appointment_screen/appointment_list_response.dart';
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
}
