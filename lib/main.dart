import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/dismount_controller.dart';
import 'package:tire_eagle/controllers/dispose_controller.dart';
import 'package:tire_eagle/controllers/forgot_password_controller.dart';
import 'package:tire_eagle/controllers/setting_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/models/user_get_all_tire_model.dart';
import 'package:tire_eagle/utils/App_Routing.dart';
import 'package:tire_eagle/utils/init_binding.dart';

import 'controllers/billing_and_invoice_controller.dart';
import 'controllers/reminder_controller.dart';
import 'controllers/user_dashboard_controller.dart';
import 'controllers/user_tire_wheel_controller.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(prefs, permanent: true);
Get.put(AuthController());
Get.put(ForgotPasswordController());
Get.put(DashboardController());
Get.put(TotalTireController());
Get.put(DismountController());
Get.put(SettingController());
Get.put(DisposeController());
Get.put(BillingAndInvoiceController());
Get.put(ReminderController());
Get.put(UserDashboardController());
Get.put(UserTireWheelController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            initialBinding: Binding(),
            initialRoute: '/',
            getPages: AppRoutes.routes,
            builder: EasyLoading.init(),
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // showPerformanceOverlay: true,
            theme: ThemeData(
              scaffoldBackgroundColor: backgroundColor,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            // home: SplashScreen(),
            // home: CustomBottomNavBar(),
          );
        }
      );
    }
  }

