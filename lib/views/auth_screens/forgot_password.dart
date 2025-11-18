import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/utils/helper_functions.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/custom_text_feild.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/forgot_password_controller.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final ForgotPasswordController controller = Get.find<ForgotPasswordController>();
  GlobalKey<FormState> _forgotKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: SingleChildScrollView(
          child: Form(
            key: _forgotKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.h,left: 0.5.w),
                  child: Image.asset("assets/png/eagle_logo.png",height: 10.h,width: 19.w),
                ),
                SizedBox(height: 2.h),
                customText(
                    text: "Forgot Password",
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w600,
                    color: textBrownColor
                ),
                SizedBox(height: 1.h),
                customText(
                    text: "Enter an email address to receive a verification code.",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: textBrownColor
                ),

                SizedBox(height: 3.h),
                customTextFeild(
                    "Email Address",
                    "Enter Your Email Address",
                    controller: controller.emailController,
                  validator: (value)=> HelperFunction.emailValidate(value),
                ),
                // customPhoneTextField(
                //   title: "Phone Number",
                //   hintText: "Enter Your Phone Number",
                //   controller: controller.phoneController,
                // ),
                SizedBox(height: 3.h),
                buttonWidget("Continue", whiteColor,colors: buttonColor,height: 6.h,onTap: () async {
                  // Get.toNamed("emailverification");
                  if(_forgotKey.currentState!.validate()){
                    await controller.emailVerification();
                  }

                }),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(
                        text: "Back To",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: forgotGreyColor
                    ),
                    SizedBox(width: 1.w),
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: customText(
                          text: "Login",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: forgotGreyColor
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
