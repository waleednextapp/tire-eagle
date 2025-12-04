import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
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
      String? path,
    }) {

  double finalRadius = radius ?? 8.sp;

  return Material(
    color: colors ?? whiteColor,               // <-- FIX
    borderRadius: BorderRadius.circular(finalRadius),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(finalRadius),
      splashColor: Colors.black12,             // optional but visible
      highlightColor: Colors.black12,          // optional
      child: Container(
        height: height ?? 5.5.h,
        width: width ?? 100.w,
        decoration: BoxDecoration(
          color: Colors.transparent,           // <-- background already on Material
          borderRadius: BorderRadius.circular(finalRadius),
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
    ),
  );

}
