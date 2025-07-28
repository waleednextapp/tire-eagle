import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/views/dashboard_screens/home_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/inventory_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/report_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/scan_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/setting_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/store_screen.dart';

import '../../constants/constants_widgets.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final DashboardController controller = Get.find<DashboardController>();
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
      initialPage: controller.currentIndex.value,
    );
    controller.setPageController(_pageController);
    controller.currentIndex.listen((index) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(index);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> pages = [
    HomeScreen(),
    StoreScreen(),
    InventoryScreen(),
    ReportScreen(),
    SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: Container(
        height: 10.h,
        color: whiteColor,
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem("assets/png/dashboard_icon/home.png", 0, 'Home'),
            navItem("assets/png/dashboard_icon/store.png", 1, 'Store'),
            navItem("assets/png/dashboard_icon/inventory.png", 2, 'Inventory'),
            navItem("assets/png/dashboard_icon/report.png", 3, 'Report'),
            navItem("assets/png/dashboard_icon/setting.png", 4, 'Setting'),
          ],
        )),
      ),
    );
  }
  Widget navItem(String iconPath, int index, String label) {
    bool isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 20.sp, color: isSelected ? blackColor : navBarColor),
            SizedBox(height: 0.5.h),
            customText(
              text: label,
              fontSize: 13.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w600,
              color: isSelected ? blackColor : navBarColor

            ),
          ],
        ),
      ),
    );
  }
}

