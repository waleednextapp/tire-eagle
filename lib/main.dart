import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/dismount_controller.dart';
import 'package:tire_eagle/controllers/splash_controller.dart';
import 'package:tire_eagle/utils/App_Routing.dart';
import 'package:tire_eagle/utils/init_binding.dart';

void main() {
Get.put(SplashController());
Get.put(AuthController());
Get.put(DashboardController());
Get.put(DismountController());
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
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
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

