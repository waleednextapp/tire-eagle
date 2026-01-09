import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';
import '../controllers/billing_and_invoice_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/dismount_controller.dart';
import '../controllers/dispose_controller.dart';
import '../controllers/forgot_password_controller.dart';
import '../controllers/reminder_controller.dart';
import '../controllers/setting_controller.dart';
import '../controllers/total_tire_controller.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.putAsync<SharedPreferences>(() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    }, permanent: true);
    // Auth related should usually stay put or lazyPut
    // Get.lazyPut(() => AuthController(), fenix: true);
    // Get.lazyPut(() => ForgotPasswordController(), fenix: true);
    //
    // // Dashboard and Inventory
    // Get.lazyPut(() => DashboardController(), fenix: true);
    // Get.lazyPut(() => TotalTireController(), fenix: true);
    //
    // // Operations
    // Get.lazyPut(() => DismountController(), fenix: true);
    // Get.lazyPut(() => DisposeController(), fenix: true);
    //
    // // Management and Settings
    // Get.lazyPut(() => SettingController(), fenix: true);
    // Get.lazyPut(() => BillingAndInvoiceController(), fenix: true);
    // Get.lazyPut(() => ReminderController(), fenix: true);
  }
}
