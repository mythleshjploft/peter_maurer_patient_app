import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:peter_maurer_patients_app/app/controllers/base_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/dashboard_view.dart';
import 'package:peter_maurer_patients_app/app/modules/onbording/onbording_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/firebase_service.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  BaseController controller = Get.put(BaseController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      await initGetStorage();
      if (Platform.isIOS) {
        await Firebase.initializeApp();
      } else {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyDW2PBJshaoyPxWTY988fM9tpriLAYEECE',
            appId: '1:467194117630:android:f0b9fce6feba6726f954af',
            messagingSenderId: '467194117630',
            projectId: 'mkg-maurer',
          ),
        );
      }
      getFcmToken();
      initMessaging();
      if (mounted) {
        FocusManager.instance.primaryFocus?.unfocus();
      }

      if (mounted) {
        FocusManager.instance.primaryFocus?.unfocus();
      }

      Future.delayed(const Duration(seconds: 3), () {
        if ((BaseStorage.read(StorageKeys.isLoggedIn, showLog: true) ??
                false) ==
            true) {
          Get.offAll(() => const DashBoardView());
        } else {
          Get.offAll(() => const OnboardingScreen());
        }
      });
    });
  }

  initGetStorage() async {
    await GetStorage.init('MyStorage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/splash_background_img.png', // Replace with your background image path
            fit: BoxFit.cover,
          ),

          // Logo
          Center(
            child: Image.asset(
              'assets/images/logo_img.png', // Replace with your logo image path
              width: 257,
            ),
          ),
        ],
      ),
    );
  }
}
