// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:peter_maurer_patients_app/app/models/chat_screen/chat_list_response.dart';
// import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
// import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
// import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
// import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;
// import 'package:socket_io_client/socket_io_client.dart';

// class ChatScreenController extends GetxController {
//   RefreshController chatListRefreshController =
//       RefreshController(initialRefresh: false);

//   @override
//   onInit() {
//     super.onInit();
//     connectSocket();
//   }

//   Rx<TextEditingController> searchTextController = TextEditingController().obs;

//   io.Socket? socket;
//   RxList<ChatListData?>? chatsList = <ChatListData>[].obs;

//   // RxBool isChatListLoading = false.obs;
//   RxBool isChatsLoading = true.obs;

//   RxBool search = false.obs;
//   RxBool isSocketInMemory = false.obs;
//   // late Timer timer;
//   RxBool isBlockResInMemory = false.obs;
//   RxInt notificationCount = 0.obs;

//   // emitIsUserBlocked(String userId) {
//   //   timer = Timer.periodic(const Duration(seconds: 6), (timer) {
//   //     try {
//   //       socket?.emitWithAck("isUserBlocked", {"userId": userId}, ack: (data) {
//   //         log("isUserBlocked:- $data");
//   //       });
//   //     } catch (e) {
//   //       log("Exception....$e....");
//   //     }
//   //     if (isBlockResInMemory.value == false) {
//   //       socket?.on(
//   //         "isUserBlockedResponse",
//   //         (data) {
//   //           isBlockResInMemory.value = true;
//   //           log("************-----------------------------*************");
//   //           log("IsUserBlockedResponse RESPONSE:-   ${jsonEncode(data)}");
//   //           IsUserBlockedResponse isUserBlockedResponse =
//   //               IsUserBlockedResponse.fromJson(data);
//   //           notificationCount.value = int.tryParse(
//   //                   isUserBlockedResponse.data?.count?.toString() ?? "0") ??
//   //               0;
//   //           String userId =
//   //               BaseStorage.read(StorageKeys.userId)?.toString() ?? "";
//   //           if (isUserBlockedResponse.data?.success == false) {
//   //             clearSessionData();
//   //             timer.cancel();
//   //             showSnackBar(
//   //                 subtitle:
//   //                     isUserBlockedResponse.data?.message?.toString() ?? "");
//   //           } else {
//   //             if ((isUserBlockedResponse.data?.matches ?? []).isNotEmpty) {
//   //               log("Matches:- ${isUserBlockedResponse.data?.matches}");
//   //               (isUserBlockedResponse.data?.matches ?? []).map((e) {
//   //                 // to Check if userid is equals to my basetorage userid then push to ItsAMatchScreen with username and userimage but if the condition is true then pick username from lusername and userimage from luserimage
//   //                 log("USERID:-${e.userId}--->$userId");
//   //                 if ((e.userId?.toString() ?? userId) == userId) {
//   //                   // Get.to(() => ItsAMatchScreen(
//   //                   //       userImage: e.lavatar,
//   //                   //       username: e.lusername,
//   //                   //       matchId: e.id?.toString() ?? "",
//   //                   //       isComingFromSocket: true,
//   //                   //     ));
//   //                   // // Get.toNamed("/its_a_match_screen", arguments: {
//   //                   // //   "username": e.lusername,
//   //                   // //   "userimage": e.lavatar,
//   //                   // //   "userId": e.userId
//   //                   // // });
//   //                 } else {
//   //                   Get.to(() => ItsAMatchScreen(
//   //                         userImage: e.uavatar,
//   //                         username: e.uusername,
//   //                         matchId: e.id?.toString() ?? "",
//   //                         isComingFromSocket: true,
//   //                       ));
//   //                 }
//   //               }).toList();
//   //             }
//   //           }
//   //         },
//   //       );
//   //     }
//   //   });
//   // }

//   @override
//   void dispose() {
//     log("Timer Removed");
//     // timer.cancel();
//     super.dispose();
//   }

//   connectSocket() async {
//     final String accessToken = BaseStorage.read(StorageKeys.apiToken) ?? "";
//     final String userId = BaseStorage.read(StorageKeys.userId) ?? "";
//     log("calling socket $accessToken");
//     socket = io.io(
//       ApiEndPoints().socketUrl,
//       OptionBuilder()
//           .setTransports(['websocket']) // for Flutter or Dart VM
//           .disableAutoConnect() // disable auto-connection
//           .setExtraHeaders(
//               {"token": accessToken, "userType": "Patient"}) // optional
//           .build(),
//       // <String, dynamic>{
//       //   'transports': ['websocket'],
//       //   'autoConnect': false,
//       //   "force new connection": true,
//       //   "reconnectionAttempt": "Infinity",
//       //   "timeout": 10000,

//       // },
//     );
//     socket?.connect();
//     socket?.onConnect(
//       (data) {
//         log("CHATLISTUSERID:-accessToken-->$accessToken-->");
//         try {
//           socket?.emitWithAck("sidebar", {
//             userId,
//           }, ack: (data) {
//             log("chatList:- $data");
//           });
//         } catch (e) {
//           log("Exception....$e....");
//         }
//       },
//     );

//     if (isSocketInMemory.value == false) {
//       socket?.on(
//         "conversation",
//         (data) {
//           isSocketInMemory.value = true;
//           log("************-----------------------------*************");
//           log("USER data LIST RESPONSE:-   ${jsonEncode(data)}");
//           try {
//             ChatListResponse inboxUserResponse =
//                 ChatListResponse.fromJson(data);
//             chatsList?.value = inboxUserResponse.data ?? [];
//             chatsList?.refresh();
//             isChatsLoading.value = false;
//             chatListRefreshController.refreshCompleted();
//           } catch (e) {
//             showSnackBar(subtitle: "$e");
//           }
//         },
//       );
//     }

//     socket?.onDisconnect((e) {
//       log("Socket Disconnect");
//     });
//     socket?.onConnectError((e) {
//       log("Socket Connection Error: $e");
//       // connectSocket();
//     });
//     socket?.on('error', (data) {
//       log(data + "_________");
//     });
//   }

//   // searchChatList() {
//   //   final String userId = BaseStorage.read(StorageKeys.userId) ?? "";
//   //   try {
//   //     socket?.emitWithAck("chatlist", {
//   //       "userId": userId,
//   //       "search": searchTextController.value.text.trim()
//   //     }, ack: (data) {
//   //       log("threads:- $data");
//   //     });
//   //   } catch (e) {
//   //     log("Exception....$e....");
//   //   }
//   // }

//   reloadChatList() {
//     isChatsLoading.value = true;
//     final String userId = BaseStorage.read(StorageKeys.userId) ?? "";
//     try {
//       socket?.emitWithAck("sidebar", {
//         userId,
//       }, ack: (data) {
//         log("chatList:- $data");
//       });
//     } catch (e) {
//       log("Exception....$e....");
//     }
//   }

//   updateLastMessage() {
//     final String userId = BaseStorage.read(StorageKeys.userId) ?? "";
//     try {
//       socket?.emitWithAck("sidebar", {
//         userId,
//       }, ack: (data) {
//         log("chatList:- $data");
//       });
//     } catch (e) {
//       log("Exception....$e....");
//     }
//   }

//   RxBool isRoomOnInMemory = false.obs;
// }
