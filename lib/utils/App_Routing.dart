import 'package:get/get.dart';
import 'package:tire_eagle/views/auth_screens/login_screen.dart';
import 'package:tire_eagle/views/auth_screens/signup_screen.dart';
import 'package:tire_eagle/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:tire_eagle/views/dashboard_screens/add_new_tire.dart';
import 'package:tire_eagle/views/dashboard_screens/add_new_wheel.dart';
import 'package:tire_eagle/views/dashboard_screens/inventory_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/notification_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/remainder.dart';
import 'package:tire_eagle/views/dashboard_screens/report_damage.dart';
import 'package:tire_eagle/views/dashboard_screens/scan_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/send_for_rethread.dart';
import 'package:tire_eagle/views/dashboard_screens/setting_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_detail.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_detail.dart';
import 'package:tire_eagle/views/splash_screens/splash_one.dart';
import 'package:tire_eagle/views/splash_screens/splash_two.dart';

import '../views/dashboard_screens/assign_storage_location.dart';
import '../views/dashboard_screens/assign_storage_location_one.dart';
import '../views/dashboard_screens/select_dismount_reason.dart';
class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(name: '/', page: () => SplashOne()),
    GetPage(name: '/splashtwo', page: () => SplashTwo()),
    GetPage(name: '/loginscreen', page: () => LoginScreen()),
    GetPage(name: '/signupscreen', page: () => SignupScreen()),
    GetPage(name: '/setting', page: () => SettingScreen()),
    GetPage(name: '/notification', page: () => NotificationScreen()),
    GetPage(name: '/addnewtire', page: () => AddNewTire()),
    // GetPage(name: '/addnewwheel', page: () => AddNewWheel()),
    GetPage(name: '/reportdamage', page: () => ReportDamage()),
    GetPage(name: '/bottomnavbar', page: () => BottomNavBar()),
    GetPage(name: '/wheeldetails', page: () => WheelDetail()),
    GetPage(name: '/remainder', page: () => Remainder()),
    GetPage(name: '/scan', page: () => ScanScreen()),
    GetPage(name: '/tire', page: () => TireDetail()),
    GetPage(name: '/rethread', page: () => SendForRethread()),
    GetPage(name: '/selectdismountreason', page: () => SelectDismountReason()),
    GetPage(name: '/assignstoragelocation', page: () => AssignStorageLocation()),
    GetPage(name: '/assignstoragelocationone', page: () => AssignStorageLocationOne()),

    //
  ];
}
