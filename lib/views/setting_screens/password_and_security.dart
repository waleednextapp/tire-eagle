import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/controllers/setting_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/success_dialog.dart';

class PasswordAndSecurity extends StatelessWidget {
  PasswordAndSecurity({super.key});
    final SettingController controller = Get.find<SettingController>();
    final AuthController authcontroller = Get.find<AuthController>();
    final TotalTireController totalTireController = Get.find<TotalTireController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Password & Security",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
        child: Column(
          children: [
            SizedBox(height: 1.h),
            customTextFeildM("Old Password", "••••••••",
                isPassword: true,
              controller: controller.oldPassword,
              obscureController: controller.isOldPasswordObscure,
              toggleObscure: controller.toggleOldPassword,
            ),
            SizedBox(height: 1.h),
            customTextFeildM("New Password",
                "••••••••",
                isPassword: true,
              controller: controller.newPassword,
              obscureController: controller.isNewPasswordObscure,
              toggleObscure: controller.toggleNewPassword
            ),
            SizedBox(height: 1.h),
            customTextFeildM("Confirm Password",
                "••••••••", isPassword: true,
              controller: controller.confirmPassword,
                obscureController: controller.isConfirmObscure,
                toggleObscure: controller.toggleConfirmPassword
            ),

            // =============================
            // TWO FACTOR AUTH SECTION
            // =============================
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         Image.asset(
            //           "assets/png/setting_icon/2fa.png",
            //           width: 6.w,
            //         ),
            //         SizedBox(width: 2.w),
            //
            //         customText(
            //           text: "Two-Factor Verification",
            //           fontSize: 15.5.sp,
            //           fontFamily: "Barlow",
            //           fontWeight: FontWeight.w400,
            //         ),
            //       ],
            //     ),
            //
            //     // SWITCH
            //     Obx(() => Transform.scale(
            //       scale: 0.7,
            //       child: CupertinoSwitch(
            //         value: controller.twoFactorAuthentication.value,
            //         onChanged: controller.toggle2FA,
            //         activeColor: yellowColor,
            //         trackColor: Colors.grey.shade300,
            //       ),
            //     )),
            //   ],
            // ),
            // SizedBox(height: 1.h),
            // customTextFeildM(
            //   "Recovery Email",
            //   "harry.jonas@xyz.com",
            // ),
            SizedBox(height: 3.h),
            buttonWidget("Update", blackColor,height: 5.h,colors: yellowColor,onTap: (){
              // Check if any password field is empty
              if (controller.oldPassword.text.trim().isEmpty ||
                  controller.newPassword.text.trim().isEmpty ||
                  controller.confirmPassword.text.trim().isEmpty) {
                Get.snackbar(
                  "Error",
                  "Please fill all password fields",
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.all(10),
                  duration: const Duration(seconds: 2),
                );
                return; // Stop execution if validation fails
              }

              // Optional: Check if new password matches confirm password
              if (controller.newPassword.text.trim() !=
                  controller.confirmPassword.text.trim()) {
                Get.snackbar(
                  "Error",
                  "New password and confirm password do not match",
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.all(10),
                  duration: const Duration(seconds: 2),
                );
                return; // Stop execution
              }
               if(totalTireController.isUser == true){
                 controller.updateUserPassword(context);
               }
               else{
                 controller.updatePassword(context);
               }
              // All checks passed, call the update function

            }),
          ],
        ),
      ),
    );
  }
}
