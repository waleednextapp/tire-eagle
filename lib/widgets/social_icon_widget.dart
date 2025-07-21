import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget socialIconWidget(
    String text,
    String path, {
      double? height,
      double? width,
      Color? borderColor,
      double borderWidth = 1.0,
    }) {
  return Container(
    height: height ?? 5.5.h,
    width: width ?? 42.w,
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.sp),
      color: whiteColor,
      border: borderColor != null
          ? Border.all(color: borderColor, width: borderWidth)
          : null,
    ),
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min, // shrink to fit
        children: [
          Image.asset(path, height: 4.h, width: 4.w),
          SizedBox(width: 3.w),
          customText(
            text: text,
            fontSize: 16.sp,
            fontFamily: "Barlow",
          ),
        ],
      ),
    ),
  );
}

