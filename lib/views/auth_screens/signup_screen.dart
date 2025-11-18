import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/custom_text_feild.dart';
import 'package:tire_eagle/widgets/social_icon_widget.dart';

import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/helper_functions.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final AuthController controller = Get.find<AuthController>();
  GlobalKey<FormState> _signupKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: SingleChildScrollView(
          child: Form(
            key: _signupKey,
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
                customTextFeild("Full Name", "Enter Your Full Name",controller: controller.nameController,
                  validator: (value) =>
            HelperFunction.ValidateName(value ?? '', fieldName: "First Name"),
                ),
                SizedBox(height: 2.h),
                customTextFeild("Email Address", "Enter Your Email Address",controller: controller.signupEmailController,
                  validator: (value) =>
                      HelperFunction.emailValidate(value),
                ),
                SizedBox(height: 2.h),
                // Use the customDropdownTextField inside Obx
                Obx(() => customDropdownTextField(
                  'Select Option',
                  context,
                  'Customer/Driver',
                  value: controller.roleSelectedItem.value,
                  onChanged: (String? newValue) {
                    controller.updateRoleSelectedItem(newValue);
                  },
                  dropdownItems: ['Fleet Manager', 'User'],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a role';
                    }
                    return null;
                  },
                 ),
                ),
                // customPhoneTextField(
                //   title: "Phone Number",
                //   hintText: "Enter Your Phone Number",
                //   controller: controller.phoneController,
                // ),

                SizedBox(height: 2.h),
                customTextFeild("New Password", "Enter Your Password",  isPassword: true,
                    obscureController: controller.isPasswordObscure,
                    toggleObscure: controller.togglePassword,
                  controller: controller.signupPasswordController,
                  validator: (value) => HelperFunction.passwordValidate(value ?? ''),
                ),

                SizedBox(height: 2.h),
                customTextFeild("Confirm Password", "Enter Your Password",  isPassword: true,
                    obscureController: controller.isConfirmObscure,
                    toggleObscure: controller.toggleConfirm,
                  controller: controller.signupConfirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm Password cannot be empty";
                    } else if (value != controller.signupPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 3.h),
                buttonWidget("Sign Up", whiteColor,colors: buttonColor,height: 6.h,onTap: () async {
                  if (_signupKey.currentState!.validate()) {
                    print("api hit");
                    await controller.signUp();   // ❗ No bool needed
                  } else {
                    print("Validation failed. API not hit.");
                  }
                }),
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
                    InkWell(
                      onTap: (){
                        Get.toNamed("loginscreen");
                      },
                      child: customText(
                        text: "Sign In",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: buttonColor,
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 7.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
