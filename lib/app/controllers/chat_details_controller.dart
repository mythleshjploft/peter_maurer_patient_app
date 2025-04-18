// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/models/chat_screen/chat_list_response.dart';
import 'package:peter_maurer_patients_app/app/models/chat_screen/message_list_response.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socket_io_client/socket_io_client.dart' as io_request;
import 'package:socket_io_client/socket_io_client.dart';

class ChatDetailsController extends GetxController {
// For Chat lIst Screen

  RefreshController chatListRefreshController =
      RefreshController(initialRefresh: false);

  @override
  onInit() {
    super.onInit();
    connectSocket();
    currentPage.value = 0;
    // scrollController.value.addListener(scrollListner);
    // scrollToBottom();
  }

  Rx<TextEditingController> searchTextController = TextEditingController().obs;

  io_request.Socket? socket;
  RxList<ChatListData?>? chatsList = <ChatListData>[].obs;
  RxList<ChatListData?> filteredChatsList = <ChatListData?>[].obs;

  // RxBool isChatListLoading = false.obs;
  RxBool isChatsLoading = true.obs;

  RxBool search = false.obs;
  RxBool isSocketInMemory = false.obs;
  // late Timer timer;
  RxBool isBlockResInMemory = false.obs;
  RxInt notificationCount = 0.obs;

  // emitIsUserBlocked(String userId) {
  //   timer = Timer.periodic(const Duration(seconds: 6), (timer) {
  //     try {
  //       socket?.emitWithAck("isUserBlocked", {"userId": userId}, ack: (data) {
  //         log("isUserBlocked:- $data");
  //       });
  //     } catch (e) {
  //       log("Exception....$e....");
  //     }
  //     if (isBlockResInMemory.value == false) {
  //       socket?.on(
  //         "isUserBlockedResponse",
  //         (data) {
  //           isBlockResInMemory.value = true;
  //           log("************-----------------------------*************");
  //           log("IsUserBlockedResponse RESPONSE:-   ${jsonEncode(data)}");
  //           IsUserBlockedResponse isUserBlockedResponse =
  //               IsUserBlockedResponse.fromJson(data);
  //           notificationCount.value = int.tryParse(
  //                   isUserBlockedResponse.data?.count?.toString() ?? "0") ??
  //               0;
  //           String userId =
  //               BaseStorage.read(StorageKeys.userId)?.toString() ?? "";
  //           if (isUserBlockedResponse.data?.success == false) {
  //             clearSessionData();
  //             timer.cancel();
  //             showSnackBar(
  //                 subtitle:
  //                     isUserBlockedResponse.data?.message?.toString() ?? "");
  //           } else {
  //             if ((isUserBlockedResponse.data?.matches ?? []).isNotEmpty) {
  //               log("Matches:- ${isUserBlockedResponse.data?.matches}");
  //               (isUserBlockedResponse.data?.matches ?? []).map((e) {
  //                 // to Check if userid is equals to my basetorage userid then push to ItsAMatchScreen with username and userimage but if the condition is true then pick username from lusername and userimage from luserimage
  //                 log("USERID:-${e.userId}--->$userId");
  //                 if ((e.userId?.toString() ?? userId) == userId) {
  //                   // Get.to(() => ItsAMatchScreen(
  //                   //       userImage: e.lavatar,
  //                   //       username: e.lusername,
  //                   //       matchId: e.id?.toString() ?? "",
  //                   //       isComingFromSocket: true,
  //                   //     ));
  //                   // // Get.toNamed("/its_a_match_screen", arguments: {
  //                   // //   "username": e.lusername,
  //                   // //   "userimage": e.lavatar,
  //                   // //   "userId": e.userId
  //                   // // });
  //                 } else {
  //                   Get.to(() => ItsAMatchScreen(
  //                         userImage: e.uavatar,
  //                         username: e.uusername,
  //                         matchId: e.id?.toString() ?? "",
  //                         isComingFromSocket: true,
  //                       ));
  //                 }
  //               }).toList();
  //             }
  //           }
  //         },
  //       );
  //     }
  //   });
  // }

  @override
  void dispose() {
    log("Timer Removed");
    // timer.cancel();
    scrollController.value.removeListener(scrollListner);
    scrollController.value.dispose();
    socket?.off("chatListResponse");
    socket?.off("sendMessageResponse");
    socket?.off("deleteMessageResponse");
    socket?.disconnect();
    socket?.dispose();
    socket?.destroy();
    Get.delete<ChatDetailsController>();
    super.dispose();
    super.dispose();
  }

  connectSocket() async {
    final String accessToken = BaseStorage.read(StorageKeys.apiToken) ?? "";
    final String userId = BaseStorage.read(StorageKeys.userId) ?? "";
    log("calling socket $accessToken");
    socket = io_request.io(
      ApiEndPoints().socketUrl,
      OptionBuilder().setTransports(['websocket']).setAuth(
              {"token": accessToken, "userType": "User"}) // optional
          .build(),
    );
    socket?.connect();
    socket?.onConnect(
      (data) {
        log("CHATLISTUSERID:-accessToken-->$accessToken-->");
        try {
          socket?.emitWithAck("sidebar", {
            userId,
          }, ack: (data) {
            log("chatList:- $data");
          });
        } catch (e) {
          log("Exception....$e....");
        }
      },
    );

    if (isSocketInMemory.value == false) {
      socket?.on(
        "conversation",
        (data) {
          isSocketInMemory.value = true;
          log("************-----------------------------*************");
          log("USER data LIST RESPONSE:-   ${jsonEncode(data)}");
          try {
            ChatListResponse inboxUserResponse =
                ChatListResponse.fromJson(data);
            chatsList?.value = inboxUserResponse.data ?? [];
            chatsList?.refresh();
            filteredChatsList.value = chatsList!;
            filteredChatsList.refresh();
            isChatsLoading.value = false;
            chatListRefreshController.refreshCompleted();
          } catch (e) {
            showSnackBar(subtitle: "$e");
          }
        },
      );
    }

    socket?.onDisconnect((e) {
      log("Socket Disconnect");
    });
    socket?.onConnectError((e) {
      log("Socket Connection Error: $e");
      // connectSocket();
    });
    socket?.on('error', (data) {
      log(data + "_________");
    });
  }

  void filterChats(String query) {
    final List<ChatListData?> allChats = chatsList ?? [];
    if (query.isEmpty) {
      filteredChatsList.value = allChats;
    } else {
      final lowerQuery = query.toLowerCase();
      filteredChatsList.value = allChats.where((chat) {
        final name =
            "${chat?.userDetails?.firstName ?? ""} ${chat?.userDetails?.lastName ?? ""}"
                .toLowerCase();
        return name.contains(lowerQuery);
      }).toList();
    }
  }
  // searchChatList() {
  //   final String userId = BaseStorage.read(StorageKeys.userId) ?? "";
  //   try {
  //     socket?.emitWithAck("chatlist", {
  //       "userId": userId,
  //       "search": searchTextController.value.text.trim()
  //     }, ack: (data) {
  //       log("threads:- $data");
  //     });
  //   } catch (e) {
  //     log("Exception....$e....");
  //   }
  // }

  reloadChatList() {
    isChatsLoading.value = true;
    final String userId = BaseStorage.read(StorageKeys.userId) ?? "";
    try {
      socket?.emitWithAck("sidebar", {
        userId,
      }, ack: (data) {
        log("chatList:- $data");
      });
    } catch (e) {
      log("Exception....$e....");
    }
  }

  updateLastMessage() {
    final String userId = BaseStorage.read(StorageKeys.userId) ?? "";
    try {
      socket?.emitWithAck("sidebar", {
        userId,
      }, ack: (data) {
        log("chatList:- $data");
      });
    } catch (e) {
      log("Exception....$e....");
    }
  }

  RxBool isRoomOnInMemory = false.obs;
////////////// Sockets And APi Work

  //////
  RxBool isUserBlocked = false.obs;
  RxBool isUserMuted = false.obs;

  RxBool emojiShowing = false.obs;

  Rx<ScrollController> scrollController = ScrollController().obs;

  RxBool isRecoding = false.obs;
  RxBool showMicButton = true.obs;
  RxBool isAudioPlaying = false.obs;
  RxInt playerIndex = (-1).obs;
  RxBool isFirstMessageSent = false.obs;
  RxBool isMessageListLoading = true.obs;
  // RxBool isSendMessage = false.obs;
  // RxBool isNextPageRequested = false.obs;
  RxBool isChatListInMemory = false.obs;

  Rx<TextEditingController> messageController = TextEditingController().obs;
  RxString chatUserIdForPaging = "".obs;
  RxString chatUserName = "".obs;

  // Pagination Constants
  RxBool getNextPage = false.obs;
  RxInt pageNo = 1.obs;
  RxBool isPaginationLoading = false.obs;

  scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.value.position
          .animateTo(
            scrollController.value.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 500),
          )
          .then((value) => update());
      update();
    });
  }

  scrollListner() async {
    if (scrollController.value.position.minScrollExtent ==
        scrollController.value.offset) {
      // isSendMessage.value = false;
      // isNextPageRequested.value = true;
      final String userId = BaseStorage.read(StorageKeys.userId) ?? "";
      log("check: $getNextPage");
      if (getNextPage.value) {
        isPaginationLoading.value = true;
        pageNo.value++;
        socket?.emitWithAck("chatdetail", {
          "userId": userId, //userId,
          "chatUserId": chatUserIdForPaging.value,
          "page": pageNo.value.toString()
        }, ack: (data) {
          log("chatList:- $data");
        });
        // await getUserChatDetail(pageNo: pageNo, roomId: roomId);
      }
    }
  }

  // io_request.Socket? socket;

  RxInt currentPage = 0.obs;
  RxBool error = false.obs;
  RxBool hasMore = true.obs;
  RxBool getFirstFlag = true.obs;

  RxInt calledTime = 1.obs;

  RxList<MessageListDatum?>? messageList = <MessageListDatum>[].obs;

  getChatDetails({required String chatUserId}) async {
    final String userId = BaseStorage.read(StorageKeys.userId) ?? "";

    log("USERID:=>>>>>> $userId");
    log("CHATUSERID:=>>>>>> $chatUserId");

    socket?.emitWithAck("message-page", chatUserId, ack: (data) {
      log("chatList:- $data");
    });
    socket?.emitWithAck("seen", chatUserId, //userId,
        ack: (data) {
      log("seen:- $data");
    });
    log("=========>>>>$chatUserId");

    if (pageNo.value == 1) {
      getNextPage.value = true;
      messageList?.clear();
    }
    if (isChatListInMemory.value == false) {
      socket?.on("message", (data) {
        isChatListInMemory.value = true;
        log("message:- ${jsonEncode(data)}");
        log("************-----------------------------*************");

        if (pageNo.value == 1) {
          scrollToBottom();
        }
        MessageListResponse messageListResponse =
            MessageListResponse.fromJson(data);
        List<MessageListDatum> dataList = messageListResponse.data ?? [];

        if (dataList.isNotEmpty) {
          if (isPaginationLoading.value == true) {
            getNextPage.value = true;
            messageList?.addAll(dataList);
            messageList?.refresh();
            update();
          } else {
            messageList?.clear();
            messageList?.value = dataList;
            messageList?.refresh();
            update();
          }
        } else {
          getNextPage.value = false;
        }
        isPaginationLoading.value = false;
        isMessageListLoading.value = false;
        update();

        log(">>>-----------------------------> ${currentPage.value.toString()} >>>----------------------------->");
      });
    }

    socket?.onDisconnect((_) {
      log("Socket Disconnect");
      // connectSocketAndGetChatDetails(chatUserId: chatUserId);
    });
    socket?.onConnectError((_) {
      log("Socket Connection Error: ");
      // connectSocket();
    });
    socket?.on('error', (data) {
      log(data + "_________");
    });
  }

  getMessages({required String roomId}) {
    try {
      socket?.emitWithAck("chatList", {
        "room_id": roomId, //userId,
      }, ack: (data) {
        log("chatList:- $data");
      });
    } catch (_) {
      log("Exception........");
    }
  }

  Future<void> sendMessages(
      {required String receiverId,
      required String message,
      required String type}) async {
    final String userId = BaseStorage.read(StorageKeys.userId) ?? "";
    messageController.value.clear();
    // isSendMessage.value = true;
    // isNextPageRequested.value = false;
    pageNo.value = 1;
    getNextPage.value = true;

    messageList?.insert(
        0,
        MessageListDatum(
          text: message,
          // type: type,
          senderId: userId,
          receiverId: receiverId,
          createdAt: DateTime.now().toString(),
        ));
    messageList?.refresh();
    scrollToBottom();
    try {
      socket?.emitWithAck("new message", {
        "sender": userId,
        "receiver": receiverId,
        "text": message,
        "imageUrl": '',
        "videoUrl": '',
        "msgByUserId": userId,
        // "type": type
      }, ack: (data) {
        log("sendMessage:- $data");
        log(receiverId);
        log(userId);
      });

      currentPage.value = 0;
      hasMore.value = true;
    } catch (_) {
      log("Exception........");
    }
  }

////// Create Poll Module

  RxBool isFirstMessageDeleted = false.obs;
}
