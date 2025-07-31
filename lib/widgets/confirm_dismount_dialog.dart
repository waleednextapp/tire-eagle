import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void confirmDismountDialog(BuildContext context) {
  final DashboardController controller = Get.find<DashboardController>();
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 6.w), // 👈 Add this line
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 1.h),
            child: Column(
              children: [
                SizedBox(height: 2.h),
                Container(
                  height: 12.w,
                  width: 12.w,
                  decoration: BoxDecoration(
                    color: lightRedColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/png/confirm_dismount.png",
                      width: 7.w, // Smaller than container size
                      height: 7.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 1.h),
                    customText(
                      text: "Confirm Dismount",
                      fontWeight: FontWeight.w600,
                      fontSize: 19.sp,
                      fontFamily: "Barlow",
                    ),
                    SizedBox(height: 0.3.h),
                    customText(
                      text: "Are you sure you want to dismount\nthis tire from position F-Right?",
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                      color: rotateTireGreyColor,
                      fontFamily: "Barlow",
                      textAlign: TextAlign.center
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(child: buttonWidget("Cancel", blackColor,borderColor: rotateTireTextFeildColor,radius: 10.sp,fontsize: 15.sp,height: 4.5.h,onTap: (){
                          Get.back();
                        })),
                        SizedBox(width: 3.w),
                        Expanded(child: buttonWidget("Dismount", whiteColor,colors: redColor,radius: 10.sp,height: 4.5.h,fontsize: 15.sp,onTap: (){
                          Get.toNamed("selectdismountreason");
                        }))
                      ],
                    ),
                    SizedBox(height: 1.5.h),
                  ],
                )

              ],
            ),
          )
        ],
      ),
    ),
  );
}

