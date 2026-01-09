import 'package:get/get.dart';
import 'package:tire_eagle/views/auth_screens/email_verification.dart';
import 'package:tire_eagle/views/auth_screens/forgot_password.dart';
import 'package:tire_eagle/views/auth_screens/login_screen.dart';
import 'package:tire_eagle/views/auth_screens/set_password.dart';
import 'package:tire_eagle/views/auth_screens/signup_screen.dart';
import 'package:tire_eagle/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:tire_eagle/views/dashboard_screens/invoice_detail_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/nearest_supplier.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_screens/add_new_tire.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_screens/user_tire_detail.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_screens/add_new_wheel.dart';
import 'package:tire_eagle/views/dashboard_screens/disposed_history.dart';
import 'package:tire_eagle/views/dashboard_screens/inventory_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/notification_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/puncture_form.dart';
import 'package:tire_eagle/views/dashboard_screens/remainder.dart';
import 'package:tire_eagle/views/dashboard_screens/report_damage_screens/report_damage.dart';
import 'package:tire_eagle/views/dashboard_screens/scan_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/send_for_rethread.dart';
import 'package:tire_eagle/views/setting_screens/allow_notifications.dart';
import 'package:tire_eagle/views/setting_screens/billing_and_invoices.dart';
import 'package:tire_eagle/views/setting_screens/my_detail.dart';
import 'package:tire_eagle/views/setting_screens/password_and_security.dart';
import 'package:tire_eagle/views/setting_screens/setting_screen.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_screens/tire_detail.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_screens/total_tires.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_screens/total_wheels.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_screens/wheel_detail.dart';
import 'package:tire_eagle/views/splash_screens/splash_one.dart';
import 'package:tire_eagle/views/splash_screens/splash_two.dart';

import '../views/dashboard_screens/assign_storage_location.dart';
import '../views/dashboard_screens/assign_storage_location_one.dart';
import '../views/dashboard_screens/select_dismount_reason.dart';
import '../views/dashboard_screens/wheel_screens/user_wheel_detail.dart';
class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(name: '/', page: () => SplashOne()),
    GetPage(name: '/splashtwo', page: () => SplashTwo()),
    GetPage(name: '/loginscreen', page: () => LoginScreen()),
    GetPage(name: '/signupscreen', page: () => SignupScreen()),
    GetPage(name: '/forgotpassword', page: () => ForgotPassword()),
    GetPage(name: '/emailverification', page: () => EmailVerification()),
    GetPage(name: '/setpassword', page: () => SetPassword()),
    GetPage(name: '/setting', page: () => SettingScreen()),
    GetPage(name: '/notification', page: () => NotificationScreen()),
    GetPage(name: '/addnewtire', page: () => AddNewTire()),
    // GetPage(name: '/addnewwheel', page: () => AddNewWheel()),
    GetPage(name: '/reportdamage', page: () => ReportDamage()),
    GetPage(name: '/totaltires', page: () => TotalTires()),
    GetPage(name: '/totalwheel', page: () => TotalWheels()),
    GetPage(name: '/mydetails', page: () => MyDetail()),
    GetPage(name: '/allownotifications', page: () => AllowNotifications()),
    GetPage(name: '/billing', page: () => BillingAndInvoices()),
    GetPage(name: '/password', page: () => PasswordAndSecurity()),
    GetPage(name: '/disposedhistory', page: () => DisposedHistory()),
    GetPage(name: '/punctureform', page: () => PunctureForm()),
    GetPage(name: '/bottomnavbar', page: () => BottomNavBar()),
    GetPage(name: '/wheeldetails', page: () => WheelDetail()),
    GetPage(name: '/near', page: () => NearestSupplier()),
    GetPage(name: '/remainder', page: () => Remainder()),
    GetPage(name: '/scan', page: () => ScanScreen()),
    GetPage(name: '/tire', page: () => TireDetail()),
    GetPage(name: '/invoice', page: () => InvoiceDetailScreen()),
    GetPage(name: '/rethread', page: () => SendForRethread()),
    GetPage(name: '/selectdismountreason', page: () => SelectDismountReason()),
    GetPage(name: '/assignstoragelocation', page: () => AssignStorageLocation()),
    GetPage(name: '/assignstoragelocationone', page: () => AssignStorageLocationOne()),
    GetPage(name: '/usergettirebyid', page: () => UserTireDetail()),
    GetPage(name: '/usergetwheelbyid', page: () => UserWheelDetail()),

    //
  ];
}
