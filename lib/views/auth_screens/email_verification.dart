import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/forgot_password_controller.dart';
import 'package:tire_eagle/utils/helper_functions.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/custom_text_feild.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';

class EmailVerification extends StatelessWidget {
  EmailVerification({super.key});
  final ForgotPasswordController controller = Get.find<ForgotPasswordController>();
  GlobalKey<FormState> _emailVerification = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final String email = args["email"] ?? '';
    // Start 2-minute timer
    controller.startTimer();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: SingleChildScrollView(
          child: Form(
            key: _emailVerification,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.h, left: 0.5.w),
                  child: Image.asset(
                    "assets/png/eagle_logo.png",
                    height: 10.h,
                    width: 19.w,
                  ),
                ),
                SizedBox(height: 2.h),
                customText(
                  text: "Forgot Password",
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                  color: textBrownColor,
                ),
                SizedBox(height: 1.h),
                customText(
                  text: "An email has been sent to you with a verification code. Please enter it here.",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: textBrownColor,
                ),
                SizedBox(height: 3.h),
                customTextFeild(
                    "Verification Code",
                    "Enter verification code",
                    isPrefix: true,
                  controller: controller.otpController,
                  validator: (value)=> HelperFunction.otpValidator(value)
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 🔹 Timer display
                    Obx(() {
                      final minutes = (controller.remainingTime.value ~/ 60).toString().padLeft(2, '0');
                      final seconds = (controller.remainingTime.value % 60).toString().padLeft(2, '0');
                      return customText(
                        text: "Resending in $minutes:$seconds",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: verificationGreyColor,
                      );
                    }),

                    // 🔹 Resend Code button
                    Obx(() {
                      final isActive = controller.remainingTime.value == 0;
                      return GestureDetector(
                        onTap: isActive
                            ? () {
                          controller.startTimer(); // Reset timer
                          // TODO: Call your resend API here
                          controller.emailVerification(resentemail: email);
                        }
                            : null, // disabled if timer > 0
                        child: customText(
                          text: "Resend Code",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: isActive ? yellowColor : Colors.grey, // show disabled color
                          txtDecoration: TextDecoration.underline,
                          height: 0.1.h,
                          decorationColor: isActive ? yellowColor : Colors.grey,
                        ),
                      );
                    }),
                  ],
                ),

                SizedBox(height: 3.h),
                buttonWidget(
                  "Continue",
                  whiteColor,
                  colors: buttonColor,
                  height: 6.h,
                  onTap: () {
                    if(_emailVerification.currentState!.validate()){
                      controller.verifyOtp(email);
                    }
                  },
                ),
                SizedBox(height: 3.h),
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
                        color: forgotGreyColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

