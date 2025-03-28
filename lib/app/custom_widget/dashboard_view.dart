import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/bottom_navigation_bar.dart';
import 'package:peter_maurer_patients_app/app/modules/chat/contact_view.dart';
import 'package:peter_maurer_patients_app/app/modules/dashboard/dashboard_view.dart';
import 'package:peter_maurer_patients_app/app/modules/notification/notification_view.dart';
import 'package:peter_maurer_patients_app/app/modules/profile/profile_view.dart';

class DashBoardView extends StatefulWidget {
  final int? index;
  const DashBoardView({super.key, this.index});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  PageController pageController = PageController();
  // final connectivityController = Get.put(ConnectivityController());
  int _currentIndex = 0;
  var isConnected = false.obs;
  @override
  void initState() {
    _currentIndex = widget.index ?? 0;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_currentIndex != 0) {
        pageController.jumpToPage(_currentIndex);
      }
      // ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
      // isConnected.value = (connectivityResult == ConnectivityResult.none);
    });
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   isConnected.value = result == ConnectivityResult.none;
    // });
  }

  DateTime? lastPressedAt;

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    if (lastPressedAt == null ||
        currentTime.difference(lastPressedAt!) > const Duration(seconds: 2)) {
      lastPressedAt = currentTime;
      // BaseOverlays().showInvalidUserIdToast(msg: 'Press back again to exit');
      return false;
    }
    return true;
  }

  List<Widget> screens = [
    const DashboardView(),
    const ContactView(),
    const NotificationView(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: screens[_currentIndex],
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex =
                  index; // Update the current index when an item is tapped
            });
          },
        ),
      ),
    );
  }
}
