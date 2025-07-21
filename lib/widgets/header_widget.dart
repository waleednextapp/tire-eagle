import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget headerWidget(String title,VoidCallback ontap,String hinttext){
  return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText(
              text: title,
              fontSize: 19.sp,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
            ),
            InkWell(
              child: Image.asset(
                "assets/png/home_screen_images/notification_bell.png",
                width: 5.w,
              ),
              onTap: (){
                Get.toNamed("notification");
              },
            ),
          ],
        ),
        SizedBox(height: 2.h),
        TextField(
          style: TextStyle(fontSize: 13.sp, fontFamily: "Barlow"),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 1.2.h,
              horizontal: 4.w,
            ),
            hintText: hinttext,
            hintStyle: TextStyle(
              fontSize: 15.sp,
              fontFamily: "Barlow",
              color: textFeildTextColor,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: whiteColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.sp),
              borderSide: BorderSide(color: borderColor, width: 0.2.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.sp),
              borderSide: BorderSide(color: borderColor, width: 0.2.w),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 4.w, right: 2.w),
              child: Image.asset(
                "assets/png/search_icon.png",
                height: 2.h,
                width: 2.h,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minHeight: 2.h,
              minWidth: 2.h,
            ),
          ),
        ),
      ]
  );
}
