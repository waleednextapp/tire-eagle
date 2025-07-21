import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import '../constants/constants_widgets.dart';

Widget customTextFeild(
    String title,
    String hintText, {
      bool isPassword = false,
      TextEditingController? controller,
      void Function(String)? onChanged,
      void Function(String)? onSubmitted,
    }) {
  final authController = Get.find<AuthController>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customText(
        text: title,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: greyTextColor,
      ),
      SizedBox(height: 1.h),

      // Wrap only TextField with Obx if isPassword is true
      isPassword
          ? Obx(() => TextField(
        controller: controller,
        cursorColor: yellowColor,
        obscureText: authController.isObscure.value,
        style: TextStyle(
          fontSize: 16.sp,
          color: customGreyColor,
          fontFamily: "Barlow",
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey.shade300,
            fontFamily: 'Barlow',
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          filled: true,
          fillColor: whiteColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide:
            BorderSide(color: Colors.grey.shade300, width: 0.2.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: yellowColor, width: 2),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: IconButton(
              icon: Icon(
                authController.isObscure.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey.shade300,
                size: 19.sp,
              ),
              onPressed: () =>
                  authController.toggleObscure(), // Toggle password
            ),
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ))
          : TextField(
        controller: controller,
        cursorColor: yellowColor,
        obscureText: false,
        style: TextStyle(
          fontSize: 16.sp,
          color: yellowColor,
          fontFamily: "Barlow",
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey.shade300,
            fontFamily: 'Barlow',
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          filled: true,
          fillColor: whiteColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide:
            BorderSide(color: Colors.grey.shade300, width: 0.2.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: yellowColor, width: 2),
          ),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    ],
  );
}
