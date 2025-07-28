import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants_widgets.dart';

Widget buttonWidget(
    String text,
    Color textColor, {
      Color? colors,
      double? height,
      double? width,
      VoidCallback? onTap,
      IconData? icon,
      Color? borderColor,
      double? fontsize,
      double? radius,
      FontWeight? fontweight,
      String? fontfaimly,
      String? path, // 👈 Path to asset image
    }) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 5.5.h,
      width: width ?? 100.w,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(radius ?? 8.sp),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1.2)
            : null,
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (path != null && path.isNotEmpty) ...[
              Image.asset(
                path,
                height: 16.sp,
                width: 16.sp,
                color: textColor,
              ),
              SizedBox(width: 2.w),
            ] else if (icon != null) ...[
              Icon(
                icon,
                color: textColor,
                size: 16.sp,
              ),
              SizedBox(width: 2.w),
            ],
            customText(
              text: text,
              fontSize: fontsize ?? 17.sp,
              fontFamily: fontfaimly ?? 'Barlow',
              color: textColor,
              fontWeight: fontweight ?? FontWeight.w600,
            ),
          ],
        ),
      ),
    ),
  );
}
