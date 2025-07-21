import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/custom_text_feild.dart';
import 'package:tire_eagle/widgets/social_icon_widget.dart';

import '../../constants/constants_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.h,left: 0.5.w),
              child: Image.asset("assets/png/eagle_logo.png",height: 10.h,width: 19.w),
            ),
            SizedBox(height: 2.h),
            customText(
              text: "Sign In to your\nAccount",
              height: 0.15.h,
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
            customTextFeild("Email Address", "Enter Your Email Address"),
            SizedBox(height: 2.h),
            customTextFeild("Password", "Enter Your Password",isPassword: true),
            SizedBox(height: 2.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 2.5.h,
                      width: 5.2.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        border: Border.all(
                          color: rowColor,
                          width: 0.3.w
                        )
                      ),
                    ),
                    SizedBox(width: 4.w),
                    customText(
                        text: "Remember me",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: rowColor
                    ),
                  ],

                ),
                customText(
                    text: "Forget Password?",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: rowColor,
                  txtDecoration: TextDecoration.underline
                ),
              ],
            ),
            SizedBox(height: 3.h),
            buttonWidget("Sign In", whiteColor,colors: buttonColor,height: 6.h,onTap: (){
              Get.toNamed("bottomnavbar");
            }),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(child: Divider()),
                SizedBox(width: 3.w),
                customText(
                    text: "or Sign In with",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: customGreyColor,
                ),
                SizedBox(width: 3.w),
                Expanded(child: Divider()),

              ],
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                socialIconWidget("Google", "assets/png/google_logo.png",borderColor: Colors.grey.shade300,borderWidth: 0.2.w),
                socialIconWidget("Apple", "assets/png/apple_logo.png",borderColor: Colors.grey.shade300,borderWidth: 0.2.w),
              ],
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(
                  text: "Don’t have an account?",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: loginGreyColor,
                ),
                SizedBox(width: 1.w),
                GestureDetector(
                  onTap: (){
                    Get.toNamed("signupscreen");
                  },
                  child: customText(
                    text: "Sign Up",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: buttonColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
