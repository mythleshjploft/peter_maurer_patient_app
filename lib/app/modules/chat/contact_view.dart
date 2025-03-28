import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar_doctor.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_textfiled.dart';
import 'package:peter_maurer_patients_app/app/modules/chat/chat_view.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
       appBar: CustomAppBarDoctor(
         backgroundColor: const Color(0xffF8F8F8),
        
        showBackButton: false,
       
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
           SizedBox(height: 16,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
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
                      offset: Offset(2, 4), // Position of the shadow (X, Y)
                    ),
                  ],
                ),
                child:  SingleChildScrollView(
                  child: Column(
                    children: List.generate(12, (index){
                      return InkWell(
                        onTap: (){
                          Get.to(ChatView());
                        },
                        child: const MessageTile(
                          name: "Angela",
                          message: "Me: thank you...",
                          time: "Just Now",
                          avatar: 'assets/images/temp_profile_img.png',
                          isUnread: true,
                        ),
                      );
                    }) ,
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
        Row(
          children: [
            const ProfileAvatar(imagePath: 'assets/images/temp_profile_img.png'),
            const SizedBox(width: 8),
            const Text(
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
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    message,
                    style: TextStyle(
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
                style: const TextStyle(fontSize: 12, color: Color(0xff94A3B8), fontWeight: FontWeight.w400),
              ),
              SizedBox(
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
                  child: Text(
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
