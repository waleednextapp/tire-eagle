import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/controllers/user_dashboard_controller.dart';
import 'package:tire_eagle/controllers/user_tire_wheel_controller.dart';
import 'package:tire_eagle/views/dashboard_screens/fleet_home_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/inventory_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/report_damage_screens/report_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/scan_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/user_dashboard_screens/user_dashboard_screen.dart';
import 'package:tire_eagle/views/setting_screens/setting_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/store_screen.dart';

import '../../constants/constants_widgets.dart';
import '../../utils/shared_prefrences_methods.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final DashboardController controller = Get.find<DashboardController>();
  final TotalTireController totalTireController = Get.find<TotalTireController>();
  final UserDashboardController userDashboardController = Get.find<UserDashboardController>();
  final UserTireWheelController userTireWheelController = Get.find<UserTireWheelController>();
  late PageController _pageController;
  final prefs = SharedPreferencesMethod.storage;

  @override
  void initState() {
    super.initState();

    // 💡 Har dafa fresh value check karein
    bool currentStatus = prefs.getBool('isUser') ?? false;
    totalTireController.isUser.value = currentStatus;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("API TRIGGERED FOR ISUSER: $currentStatus");
      if (currentStatus == false) {
        controller.home();
        totalTireController.GetAllTireInventory();
        totalTireController.GetAllWheelInventory();
        controller.GetHistoryAndReport(quickRange: "lastWeek");
      } else {
        userTireWheelController.GetAllWheel();
        userTireWheelController.GetAllTire();
        userDashboardController.GetUserHome();
      }
    });

    _pageController = PageController(initialPage: controller.currentIndex.value);
    controller.setPageController(_pageController);

    controller.currentIndex.listen((index) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // 💡 Controller se reactive value lein
      bool isUserAccount = totalTireController.isUser.value;

      return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            isUserAccount ? UserDashboardScreen() : HomeScreen(),
            InventoryScreen(),
            ReportScreen(),
            SettingScreen(),
            StoreScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 10.h,
          color: whiteColor,
          child: isUserAccount == false
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem("assets/png/dashboard_icon/home.png", 0, 'Home'),
              navItem("assets/png/dashboard_icon/inventory.png", 1, 'Inventory'),
              navItem("assets/png/dashboard_icon/report.png", 2, 'Report'),
              navItem("assets/png/dashboard_icon/setting.png", 3, 'Setting'),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem("assets/png/dashboard_icon/home.png", 0, 'Home'),
              navItem("assets/png/dashboard_icon/store.png", 4, 'Store'),
              navItem("assets/png/dashboard_icon/setting.png", 3, 'Setting'),
            ],
          ),
        ),
      );
    });
  }

  Widget navItem(String iconPath, int index, String label) {
    return Obx(() {
      bool isSelected = controller.currentIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changePage(index),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(iconPath, height: 20.sp, color: isSelected ? yellowColor : navBarColor),
              SizedBox(height: 0.5.h),
              customText(
                text: label,
                fontSize: 13.sp,
                color: isSelected ? yellowColor : navBarColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      );
    });
  }
}

