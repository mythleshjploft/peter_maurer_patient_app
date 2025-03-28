import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/models/appointment_screen/appointment_list_response.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_api_service.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_variables.dart';

class HomeController extends GetxController {
  RxList<AppointmentDatum?>? appointmentList = <AppointmentDatum>[].obs;
  getAppointmentList() async {
    BaseApiService()
        .get(apiEndPoint: ApiEndPoints().appointmentList)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          AppointmentListResponse response =
              AppointmentListResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            appointmentList?.value = response.data?.docs ?? [];
            appointmentList?.refresh();
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
}
