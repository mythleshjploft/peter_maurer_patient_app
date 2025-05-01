import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/controllers/chat_details_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar_doctor.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/models/chat_screen/chat_list_response.dart';
import 'package:peter_maurer_patients_app/app/modules/chat/chat_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_no_data.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final TextEditingController searchController = TextEditingController();
  ChatDetailsController controller = Get.put(ChatDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      appBar: CustomAppBarDoctor(
        backgroundColor: const Color(0xffF8F8F8),
        profileImagePath: BaseStorage.read(StorageKeys.userImage) ?? "",
        title: (BaseStorage.read(StorageKeys.firstName) ?? "") +
            " " +
            (BaseStorage.read(StorageKeys.lastName) ?? ""),
        isNetworkImage: true,
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
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
            const SizedBox(height: 18),
            CustomTextFieldWithoutText(
              hintText: "Search",
              controller: searchController,
              onChanged: (val) {
                controller.filterChats(val);
              },
            ),
            const SizedBox(height: 26),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(27),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: AppColors.borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Light shadow
                      spreadRadius: 2, // How much the shadow spreads
                      blurRadius: 8, // Softness of the shadow
                      offset:
                          const Offset(2, 4), // Position of the shadow (X, Y)
                    ),
                  ],
                ),
                child: SmartRefresher(
                  controller: controller.chatListRefreshController,
                  onRefresh: () {
                    searchController.clear();
                    controller.reloadChatList();
                  },
                  header: const WaterDropHeader(
                      waterDropColor: AppColors.primaryColor),
                  child: SingleChildScrollView(
                    child: Obx(() {
                      if (controller.isChatsLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (controller.filteredChatsList.isEmpty) {
                        return const BaseNoData(message: "No chat available");
                      }
                      return Column(
                        children: List.generate(
                            controller.filteredChatsList.length, (index) {
                          var chatData = controller.filteredChatsList[index] ??
                              ChatListData();
                          return InkWell(
                            onTap: () {
                              Get.to(() => ChatView(
                                    userImg: chatData.userDetails?.image
                                            ?.toString() ??
                                        "",
                                    userName:
                                        "${chatData.userDetails?.firstName?.toString() ?? ""} ${chatData.userDetails?.lastName?.toString() ?? ""}",
                                    chatUserId:
                                        chatData.userDetails?.id?.toString() ??
                                            "",
                                    userProfession: chatData
                                            .userDetails?.specialist
                                            ?.toString() ??
                                        "",
                                  ));
                            },
                            child: MessageTile(
                              name:
                                  "${chatData.userDetails?.firstName?.toString() ?? ""} ${chatData.userDetails?.lastName?.toString() ?? ""}",
                              message: "${chatData.lastMsg?.text ?? ""}",
                              time: getTimeAgo(
                                  "${chatData.lastMsg?.updatedAt ?? ""}"),
                              avatar:
                                  chatData.userDetails?.image?.toString() ?? "",
                              unreadMsgCount: int.tryParse(
                                      "${chatData.unseenMsg?.toString() ?? 0}") ??
                                  0,
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 26),
          ],
        ),
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
  final int unreadMsgCount;

  const MessageTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.unreadMsgCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cachedNetworkImage(
              image: avatar, width: 40, height: 40, borderRadius: 100),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
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
              if (unreadMsgCount != 0)
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff22C55E),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "$unreadMsgCount",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
