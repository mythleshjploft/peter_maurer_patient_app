import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/models/notification_screen/notification_list_response.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_api_service.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_responses/base_success_response.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_variables.dart';

class BaseController extends GetxController {
  RxList<NoticationData> notificationList = <NoticationData>[].obs;
  RxBool isNotificationLoading = true.obs;
  getNotificationList() async {
    isNotificationLoading.value = true;
    BaseApiService()
        .get(apiEndPoint: ApiEndPoints().notificationList, showLoader: false)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          NotificationListResponse response =
              NotificationListResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            notificationList.value = response.data?.docs ?? [];
            notificationList.refresh();
            update();
            isNotificationLoading.value = false;
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
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

  readNotification(String id) async {
    BaseApiService()
        .post(apiEndPoint: "${ApiEndPoints().notificationList}/$id")
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            getNotificationList();
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

  deleteNotification() async {
    BaseApiService()
        .delete(apiEndPoint: ApiEndPoints().notificationList)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            getNotificationList();
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
