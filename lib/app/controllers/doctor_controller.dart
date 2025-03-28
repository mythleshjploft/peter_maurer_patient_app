import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/models/doctor_screen/doctor_list_response.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/backend/base_api_service.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_variables.dart';

class DoctorController extends GetxController {
  RxList<DoctorDatum?>? doctorList = <DoctorDatum>[].obs;

  getDoctorList() async {
    BaseApiService().get(apiEndPoint: ApiEndPoints().doctorList).then((value) {
      if (value?.statusCode == 200) {
        try {
          DoctorListResponse response =
              DoctorListResponse.fromJson(value?.data);
          if ((response.success ?? false)) {
            doctorList?.value = response.data?.docs ?? [];
            doctorList?.refresh();
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
