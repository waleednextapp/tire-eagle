import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/custom_text_feild.dart';
import 'package:tire_eagle/widgets/social_icon_widget.dart';

import '../../constants/constants_widgets.dart';
import '../../utils/helper_functions.dart';
import '../../utils/shared_prefrences_methods.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController controller = Get.find<AuthController>();
  final RxBool isSelected = false.obs;
  final prefs = SharedPreferencesMethod.storage;

  // ✅ Global key for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
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
                text: "Sign In to your\nAccount",
                height: 0.13.h,
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
                color: textBrownColor,
              ),
              SizedBox(height: 1.h),
              customText(
                text: "Enter your credentials to continue",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: textBrownColor,
              ),
              SizedBox(height: 3.h),

              // Tabs for Customer/Driver vs Fleet Manager
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.loginUserIndex.value = 1;
                      controller.isUser.value = true;
                      prefs.setBool("isUser", controller.isUser.value);
                      var isUser = prefs.getBool('isUser');
                      print(isUser);
                      print(controller.isUser.value);
                    },
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customText(
                          text: "Sign In Customer/Driver",
                          fontSize: 15.sp,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: controller.loginUserIndex.value == 1
                              ? yellowColor
                              : inventoryGreyColor,
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          height: 0.1.h,
                          width: 43.w,
                          color: controller.loginUserIndex.value == 1
                              ? yellowColor
                              : inventoryContainerColor,
                        ),
                      ],
                    )),
                  ),
                  SizedBox(width: 2.w),
                  InkWell(
                    onTap: () {
                      controller.loginUserIndex.value = 2;
                      controller.isUser.value = false;
                      prefs.setBool("isUser", controller.isUser.value);
                      print(controller.isUser.value);
                    },
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customText(
                          text: "Sign In Fleet Manager",
                          fontSize: 15.sp,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: controller.loginUserIndex.value == 2
                              ? yellowColor
                              : inventoryGreyColor,
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          height: 0.1.h,
                          width: 43.w,
                          color: controller.loginUserIndex.value == 2
                              ? yellowColor
                              : inventoryContainerColor,
                        ),
                      ],
                    )),
                  ),
                ],
              ),

              // ✅ Conditional Form Fields
              Obx(() => controller.loginUserIndex.value == 1
                  ? Column(
                children: [
                  SizedBox(height: 3.h),
                  customTextFeild(
                    "Email Address",
                    "Enter Your Email Address",
                    controller: controller.loginEmailController,
                    // validator: (value) =>
                    //     HelperFunction.emailValidate(value ?? ''),
                  ),
                  SizedBox(height: 2.h),
                  customTextFeild(
                    "Password",
                    "Enter Your Password",
                    isPassword: true,
                    obscureController: controller.isPasswordObscure,
                    toggleObscure: controller.togglePassword,
                    controller: controller.loginPasswordController,
                    // validator: (value) =>
                    //     HelperFunction.passwordValidate(value ?? ''),
                  ),
                  SizedBox(height: 2.5.h),
                  // Remember me + Forget password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(() => GestureDetector(
                            onTap: () => isSelected.toggle(),
                            child: Container(
                              height: 2.5.h,
                              width: 5.2.w,
                              decoration: BoxDecoration(
                                color: isSelected.value
                                    ? brownColor
                                    : Colors.transparent,
                                borderRadius:
                                BorderRadius.circular(8.sp),
                                border: Border.all(
                                  color: rowColor,
                                  width: 0.3.w,
                                ),
                              ),
                              child: isSelected.value
                                  ? Icon(
                                Icons.check,
                                size: 16.sp,
                                color: Colors.white,
                              )
                                  : null,
                            ),
                          )),
                          SizedBox(width: 4.w),
                          customText(
                            text: "Remember me",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: rowColor,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed("forgotpassword");
                        },
                        child: customText(
                          text: "Forget Password?",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: rowColor,
                          txtDecoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  // ✅ Sign In Button with validation
                  buttonWidget(
                    "Sign In",
                    whiteColor,
                    colors: buttonColor,
                    height: 6.h,
                    onTap: () {
                      Get.offAllNamed('/bottomnavbar');
                    },
                  ),
                  SizedBox(height: 3.h),
                  // Social Login
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
                      socialIconWidget(
                        "Google",
                        "assets/png/google_logo.png",
                        borderColor: Colors.grey.shade300,
                        borderWidth: 0.2.w,
                      ),
                      socialIconWidget(
                        "Apple",
                        "assets/png/apple_logo.png",
                        borderColor: Colors.grey.shade300,
                        borderWidth: 0.2.w,
                      ),
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
                        onTap: () {
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
                  ),
                ],
              )
                  : Form(
                key: _formKey,
                    child: Column(
                                    children: [
                    SizedBox(height: 3.h),
                    customTextFeild(
                      "Email Address",
                      "Enter Your Email Address",
                      controller: controller.loginEmailController,
                      validator: (value) =>
                          HelperFunction.emailValidate(value ?? ''),
                    ),
                    SizedBox(height: 2.h),
                    customTextFeild(
                      "Password",
                      "Enter Your Password",
                      isPassword: true,
                      obscureController: controller.isPasswordObscure,
                      toggleObscure: controller.togglePassword,
                      controller: controller.loginPasswordController,
                      validator: (value) =>
                          HelperFunction.passwordValidate(value ?? ''),
                    ),
                    SizedBox(height: 2.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(() => GestureDetector(
                              onTap: () => isSelected.toggle(),
                              child: Container(
                                height: 2.5.h,
                                width: 5.2.w,
                                decoration: BoxDecoration(
                                  color: isSelected.value
                                      ? brownColor
                                      : Colors.transparent,
                                  borderRadius:
                                  BorderRadius.circular(8.sp),
                                  border: Border.all(
                                    color: rowColor,
                                    width: 0.3.w,
                                  ),
                                ),
                                child: isSelected.value
                                    ? Icon(
                                  Icons.check,
                                  size: 16.sp,
                                  color: Colors.white,
                                )
                                    : null,
                              ),
                            )),
                            SizedBox(width: 4.w),
                            customText(
                              text: "Remember me",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: rowColor,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed("forgotpassword");
                          },
                          child: customText(
                            text: "Forget Password?",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: rowColor,
                            txtDecoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    buttonWidget(
                      "Sign In",
                      whiteColor,
                      colors: buttonColor,
                      height: 6.h,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await controller.login();
                        }
                      },
                    ),
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
                        socialIconWidget(
                          "Google",
                          "assets/png/google_logo.png",
                          borderColor: Colors.grey.shade300,
                          borderWidth: 0.2.w,
                        ),
                        socialIconWidget(
                          "Apple",
                          "assets/png/apple_logo.png",
                          borderColor: Colors.grey.shade300,
                          borderWidth: 0.2.w,
                        ),
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
                          onTap: () {
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
                    ),
                                    ],
                                  ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
