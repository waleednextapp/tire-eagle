import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/custom_text_feild.dart';
import 'package:tire_eagle/widgets/social_icon_widget.dart';

import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final AuthController controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.h,left: 0.5.w),
                child: Image.asset("assets/png/eagle_logo.png",height: 10.h,width: 19.w),
              ),
              SizedBox(height: 2.h),
              customText(
                  text: "Create Your Account",
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                  color: textBrownColor
              ),
              SizedBox(height: 1.h),
              customText(
                  text: "Enter your credentials to continue",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: textBrownColor
              ),
              SizedBox(height: 3.h),
              customTextFeild("Full Name", "Enter Your Full Name"),
              SizedBox(height: 2.h),
              customTextFeild("Email Address", "Enter Your Email Address"),
              SizedBox(height: 2.h),
              customPhoneTextField(
                title: "Phone Number",
                hintText: "Enter Your Phone Number",
                controller: controller.phoneController,
              ),
              SizedBox(height: 2.h),
              customTextFeild("New Password", "Enter Your Password",isPassword: true),
              SizedBox(height: 2.h),
              customTextFeild("Confirm Password", "Enter Your Password",isPassword: true),
              SizedBox(height: 3.h),
              buttonWidget("Sign Up", whiteColor,colors: buttonColor,height: 6.h),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText(
                    text: "Already have an account?",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: loginGreyColor,
                  ),
                  SizedBox(width: 1.w),
                  customText(
                    text: "Sign In",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: buttonColor,
                  ),

                ],
              ),
              SizedBox(height: 7.h),
            ],
          ),
        ),
      ),
    );
  }
}
