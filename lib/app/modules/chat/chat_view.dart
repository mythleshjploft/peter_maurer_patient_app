import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/chat_details_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar_doctor.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/models/chat_screen/message_list_response.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_no_data.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';

class ChatView extends StatefulWidget {
  const ChatView({
    super.key,
    required this.chatUserId,
    required this.userImg,
    required this.userName,
    required this.userProfession,
  });
  final String chatUserId;
  final String userName;
  final String userImg;
  final String userProfession;
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  ChatDetailsController chatScreenController =
      Get.isRegistered<ChatDetailsController>()
          ? Get.find<ChatDetailsController>()
          : Get.put(ChatDetailsController());

  @override
  void initState() {
    super.initState();
    chatScreenController.chatUserIdForPaging.value = widget.chatUserId;
    chatScreenController.chatUserName.value = widget.userName;
    chatScreenController.getChatDetails(chatUserId: widget.chatUserId);
    chatScreenController.scrollController.value
        .addListener(chatScreenController.scrollListner);
    chatScreenController.scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    String userId = BaseStorage.read(StorageKeys.userId) ?? "";
    return PopScope(
      onPopInvokedWithResult: ((didPop, val) {
        chatScreenController.updateLastMessage();
      }),
      child: Scaffold(
        backgroundColor: const Color(0xffF8F8F8),
        appBar: CustomAppBarDoctor(
          backgroundColor: const Color(0xffF8F8F8),
          showBackButton: true,
          profileImagePath: BaseStorage.read(StorageKeys.userImage) ?? "",
          title: (BaseStorage.read(StorageKeys.firstName) ?? "") +
              " " +
              (BaseStorage.read(StorageKeys.lastName) ?? ""),
          isNetworkImage: true,
          onPressed: () {
            Get.back();
            chatScreenController.updateLastMessage();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Messages",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 18),
              // CustomTextFieldWithoutText(
              //   hintText: "Search",
              //   controller: searchController,
              // ),
              const SizedBox(height: 26),
              Expanded(
                child: Center(
                  child: Container(
                    width: 350,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Header
                        Row(
                          children: [
                            cachedNetworkImage(
                                image: widget.userImg,
                                height: 40,
                                width: 40,
                                borderRadius: 100),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.userName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.userProfession,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),

                        // Messages List
                        Expanded(
                          child: Obx(() {
                            if (chatScreenController
                                .isMessageListLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if ((chatScreenController.messageList?.isEmpty ??
                                true)) {
                              return const BaseNoData(
                                  message: "No chat available");
                            }
                            return ListView.builder(
                              controller:
                                  chatScreenController.scrollController.value,
                              itemCount:
                                  chatScreenController.messageList?.length ?? 0,
                              itemBuilder: (context, index) {
                                final message =
                                    chatScreenController.messageList?[index] ??
                                        MessageListDatum();
                                return _buildMessageBubble(
                                    message.text?.toString() ?? "",
                                    (chatScreenController
                                                .messageList?[index]?.senderId
                                                ?.toString() ??
                                            "") ==
                                        userId);
                              },
                            );
                          }),
                        ),

                        // Input Field
                        _buildInputField(),
                      ],
                    ),
                  ),
                ),
              ),

              // Expanded(
              //   child: Container(
              //     padding: const EdgeInsets.all(27),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(32),
              //       border: Border.all(color: AppColors.borderColor),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.1), // Light shadow
              //           spreadRadius: 2, // How much the shadow spreads
              //           blurRadius: 8, // Softness of the shadow
              //           offset: Offset(2, 4), // Position of the shadow (X, Y)
              //         ),
              //       ],
              //     ),
              //     child: Column(
              //       children: [

              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min, // Prevents Row from taking full width
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns text and avatar properly
        children: [
          // Show avatar only for received messages
          if (!isUser)
            cachedNetworkImage(
                image: widget.userImg,
                height: 35,
                width: 35,
                borderRadius: 100),

          const SizedBox(width: 8), // Space between avatar and message

          Flexible(
            // Prevents overflow if text is too long
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    isUser ? Colors.lightBlue.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isUser
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: isUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffD8D8D8)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
              ),
            ),
          ),
          SvgPicture.asset("assets/icons/link.svg"),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset("assets/icons/image.svg"),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {
              if (textController.text.isNotEmpty) {
                chatScreenController.sendMessages(
                    message: textController.text,
                    receiverId: widget.chatUserId,
                    type: "Text");
                textController.clear();
              }
            },
            child: Container(
              width: 47,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: SvgPicture.asset("assets/icons/send_img.svg"),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying user profile avatars
class ProfileAvatar extends StatelessWidget {
  final String imagePath;
  final double size;

  const ProfileAvatar({super.key, required this.imagePath, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.asset(imagePath, width: size, height: size),
    );
  }
}

/// Header section with profile image and options icon
class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            ProfileAvatar(imagePath: 'assets/images/temp_profile_img.png'),
            SizedBox(width: 8),
            Text(
              "Angela",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SvgPicture.asset("assets/icons/options_icon.svg"),
      ],
    );
  }
}

/// Widget for message list item
class MessageTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final bool isUnread;

  const MessageTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ProfileAvatar(imagePath: avatar, size: 56),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff94A3B8),
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8,
              ),
              if (isUnread)
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff22C55E),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "1",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// class ChatScreen extends StatelessWidget {
//   ChatScreen({super.key});

//    final ChatController controller = Get.put(ChatController());
//   final TextEditingController textController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body:
//       Center(
//         child:
//         Container(
//           width: 350,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 8,
//                 spreadRadius: 2,
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               // Header
//               Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundImage: AssetImage('assets/avatar.png'),
//                     radius: 20,
//                   ),
//                   const SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         "Dr. Madelyn Ve...",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         "Dentist",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const Divider(),

//               // Messages List
//               Expanded(
//                 child: Obx(() => ListView.builder(
//                       itemCount: controller.messages.length,
//                       itemBuilder: (context, index) {
//                         final message = controller.messages[index];
//                         return _buildMessageBubble(message.text, message.isUser);
//                       },
//                     )),
//               ),

//               // Input Field
//               _buildInputField(),
//             ],
//           ),
//         ),
//       ),

//     );
//   }

//   Widget _buildMessageBubble(String text, bool isUser) {
//     return Align(
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isUser ? Colors.lightBlue.shade100 : Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(text),
//       ),
//     );
//   }

//   Widget _buildInputField() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.link),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.image),
//             onPressed: () {},
//           ),
//           Expanded(
//             child: TextField(
//               controller: textController,
//               decoration: const InputDecoration(
//                 hintText: "Type a message...",
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send, color: Colors.blue),
//             onPressed: () {
//               if (textController.text.isNotEmpty) {
//                 controller.sendMessage(textController.text, true);
//                 textController.clear();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

// }

// class ChatController extends GetxController {
//   var messages = <Message>[].obs; // Observable list of messages

//   void sendMessage(String text, bool isUser) {
//     if (text.trim().isEmpty) return;
//     messages.add(Message(text: text, isUser: isUser));

//     // Simulating a bot reply after a delay
//     if (isUser) {
//       Future.delayed(const Duration(seconds: 1), () {
//         messages.add(Message(text: "Thanks for your message!", isUser: false));
//       });
//     }
//   }
// }
