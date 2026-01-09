import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/custom_text_feild.dart';
import 'package:tire_eagle/widgets/social_icon_widget.dart';

import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/forgot_password_controller.dart';
import '../../utils/helper_functions.dart';
import '../../widgets/success_dialog.dart';

class SetPassword extends StatelessWidget {
  SetPassword({super.key});

  final ForgotPasswordController controller = Get.find<ForgotPasswordController>();
  final AuthController authController = Get.find<AuthController>();
  GlobalKey<FormState> _resetPassword =  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final resetToken = args['resetToken'] ?? "";
    final email = args['email'] ?? "";
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: SingleChildScrollView(
          child: Form(
            key: _resetPassword,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Logo
                Padding(
                  padding: EdgeInsets.only(top: 8.h, left: 0.5.w),
                  child: Image.asset(
                    "assets/png/eagle_logo.png",
                    height: 10.h,
                    width: 19.w,
                  ),
                ),

                SizedBox(height: 2.h),

                /// Title
                customText(
                  text: "Forgot Password",
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                  color: textBrownColor,
                ),

                SizedBox(height: 1.h),

                customText(
                  text: "Set a new password for your account",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: textBrownColor,
                ),

                SizedBox(height: 3.h),

                /// Password Fields
                customTextFeild("New Password", "Enter Your Password",  isPassword: true,
                  obscureController: controller.isPasswordObscure,
                  toggleObscure: controller.togglePassword,
                  controller: controller.newPassword,
                  validator: (value) => HelperFunction.passwordValidate(value ?? ''),
                ),
                SizedBox(height: 2.h),
                customTextFeild("Confirm Password", "Enter Your Password",  isPassword: true,
                  obscureController: controller.isConfirmObscure,
                  toggleObscure: controller.toggleConfirm,
                  controller: controller.confirmPassword,
                  validator: (value) => HelperFunction.passwordValidate(value ?? ''),
                ),

                SizedBox(height: 3.h),
                /// Update Button
                buttonWidget(
                  "Update",
                  whiteColor,
                  colors: buttonColor,
                  height: 6.h,
                  onTap: () async {
                    if(_resetPassword.currentState!.validate()){
                      if(authController.loginUserIndex.value == 1){
                        await controller.resetUserPassword(resetToken,email,context);

                      }
                      else{
                        await controller.resetPassword(resetToken,email,context);
                      }

                    }

                    // successDialog(
                    //   context,
                    //   "Your password has been updated successfully.",
                    //   "Ok",
                    //       () {
                    //     Get.back();
                    //     // Get.offAllNamed("loginscreen");
                    //   },
                    // );
                  },
                ),

                SizedBox(height: 3.h),

                /// Back to Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(
                      text: "Back To",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: forgotGreyColor,
                    ),
                    SizedBox(width: 1.w),
                    InkWell(
                      onTap: () {
                        Get.toNamed("loginscreen");
                      },
                      child: customText(
                        text: "Login",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: buttonColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
