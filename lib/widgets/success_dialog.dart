import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/widgets/button_widget.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void successDialog(
    BuildContext context, // OPTIONAL TITLE
    String description,
    String buttonText,
    VoidCallback onTap,
{String? title,bool? isLogout = false,String? buttonText2}
    ) {
  showDialog(
    context: context,
    barrierColor: Colors.grey.withOpacity(0.1),
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Stack(
            children: [

              /// MAIN DIALOG UI
              Container(
                width: 80.w,
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 2.h),

                    /// ICON
                    SizedBox(
                      height: 7.h,
                      width: 7.h,
                      child: isLogout == false ? Image.asset("assets/png/dialog_icon.png"): Image.asset('assets/png/oops.png'),
                    ),

                    SizedBox(height: 2.h),

                    /// OPTIONAL TITLE
                    if (title != null && title.trim().isNotEmpty)
                      Column(
                        children: [
                          customText(
                            text: title,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 1.5.h),
                        ],
                      ),

                    /// DESCRIPTION
                    customText(
                      text: description,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: loginGreyColor,
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 3.h),
                    isLogout == false ?
                    buttonWidget(
                      buttonText,
                      whiteColor,
                      colors: brownColor,
                      height: 5.h,
                      radius: 12.sp,
                      onTap: onTap,
                    ):Row(
                      children: [
                        Expanded(
                          child: buttonWidget(
                            buttonText,
                            brownColor,
                            colors: whiteColor,
                            borderColor: brownColor,
                            height: 5.h,
                            radius: 12.sp,
                            onTap: onTap,
                          )
                        ),
                        SizedBox(width: 2.w,),
                        Expanded(
                          child: buttonWidget(
                            buttonText2!,
                            whiteColor,
                            colors: brownColor,
                            height: 5.h,
                            radius: 12.sp,
                            onTap: onTap,
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),

              /// CLOSE ICON (Positioned)
              Positioned(
                right: 2.w,
                top: 1.5.h,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    height: 3.h,
                    width: 3.h,
                    child: Image.asset(
                      "assets/png/close_icon.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
