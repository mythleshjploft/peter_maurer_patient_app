// import 'dart:developer';

// import 'package:get/get.dart';
// import 'package:peter_maurer_patients_app/app/models/chat_screen/chat_list_response.dart';
// import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
// import 'package:peter_maurer_patients_app/app/services/backend/base_api_service.dart';
// import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class ChatController extends GetxController {
//   RxBool isLoading = true.obs;
//   RefreshController refreshController =
//       RefreshController(initialRefresh: false);

//   RxList<ChatUserData> chatList = <ChatUserData>[].obs;

//   getChatList() async {
//     try {
//       Map<String, dynamic> body = {
//         "userType": "User",
//       };
//       isLoading.value = true;
//       BaseApiService()
//           .post(
//               apiEndPoint: ApiEndPoints().chatList,
//               data: body,
//               showLoader: false)
//           .then((value) {
//         refreshController.refreshCompleted();
//         if (value?.statusCode == 200) {
//           try {
//             ChatListResponse response = ChatListResponse.fromJson(value?.data);
//             if ((response.success ?? false)) {
//               chatList.value = response.data ?? [];
//               chatList.refresh();

//               isLoading.value = false;
//               update();
//             } else {
//               // showSnackBar(subtitle: response.message ?? "");
//             }
//           } catch (e) {
//             showSnackBar(subtitle: "$e");
//           }
//         } else {
//           showSnackBar(subtitle: "Something went wrong, please try again");
//         }
//       });
//     } on Exception catch (e) {
//       log("$e");
//       refreshController.refreshCompleted();
//     }
//   }
// }
