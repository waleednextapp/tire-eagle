import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
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
  final AuthController authController = Get.find<AuthController>();
  final TotalTireController totalTireController = Get.find<TotalTireController>();
  late PageController _pageController;
  final prefs = SharedPreferencesMethod.storage;
  bool? isUser;
  // WidgetsBinding.instance.addPostFrameCallback((_) {
  // dashboardController.home();
  // });
  @override
  void initState() {
    // TODO: implement initState
    isUser = prefs.getBool('isUser') ?? false;
    super.initState();
    if(isUser == false){
      controller.home();
      totalTireController.GetAllTireInventory();
      totalTireController.GetAllWheelInventory();
    }

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




  List<Widget> get pages => [
    isUser == true ? UserDashboardScreen() : HomeScreen(),
    InventoryScreen(),
    ReportScreen(),
    SettingScreen(),
    StoreScreen(),
  ];


  @override
  Widget build(BuildContext context) {
print(isUser);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: Container(
        height: 10.h,
        color: whiteColor,
        child: Obx(() =>
            isUser == false ?
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem("assets/png/dashboard_icon/home.png", 0, 'Home'),
            // navItem("assets/png/dashboard_icon/store.png", 1, 'Store'),
            navItem("assets/png/dashboard_icon/inventory.png", 1, 'Inventory'),
            navItem("assets/png/dashboard_icon/report.png", 2, 'Report'),
            navItem("assets/png/dashboard_icon/setting.png", 3, 'Setting'),
          ],
        ):
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                navItem("assets/png/dashboard_icon/home.png", 0, 'Home'),
                navItem("assets/png/dashboard_icon/store.png", 4, 'Store'),
                navItem("assets/png/dashboard_icon/setting.png", 3, 'Setting'),
              ],
            )
        ),
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
            Image.asset(iconPath, height: 20.sp, color: isSelected ? yellowColor : navBarColor),
            SizedBox(height: 0.5.h),
            customText(
              text: label,
              fontSize: 13.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w600,
              color: isSelected ? yellowColor : navBarColor

            ),
          ],
        ),
      ),
    );
  }
}

