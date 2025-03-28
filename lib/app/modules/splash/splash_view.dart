import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/dashboard_view.dart';
import 'package:peter_maurer_patients_app/app/modules/onbording/onbording_view.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      await initGetStorage();
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
