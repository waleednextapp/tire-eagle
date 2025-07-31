import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void showRotationComplete(BuildContext context) {
  final DashboardController controller = Get.find<DashboardController>();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder:
        (_) => Dialog(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset(
                    "assets/png/rotation_tick_image.png",
                    // Replace with actual image path
                    width: 16.w,
                    height: 16.w,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 1.h),
                Center(
                  child: customText(
                    text: "Rotation Complete",
                    fontWeight: FontWeight.w600,
                    fontSize: 19.sp,
                    fontFamily: "Barlow",
                  ),
                ),
                Center(
                  child: customText(
                    text: "Tire has been successfully rotated",
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    color: rotateTireGreyColor,
                    fontFamily: "Barlow",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 1.h),
                Divider(color: Colors.grey.shade300, thickness: 1),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: rotateTireLightOrangeColor,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          rotationRow("Tire ID", "T-10492"),
                          rotationRow("From Position", "F-Right"),
                          rotationRow("To Position", "R-Left"),
                          rotationRow("Date", "24 July 2025"),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "History Log Entry",
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: blackColor,
                        fontFamily: "Barlow",
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(
                            width: 0.1.w,
                            color: rotationBorderColor,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/png/log_entry.png",width: 9.w),
                              SizedBox(width: 2.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    text: "Rotated from F-Right to R-Left",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: blackColor,
                                    fontFamily: "Barlow",
                                  ),
                                  customText(
                                    text: "24 July 2025 • 10:23 AM",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp,
                                    color: rotationGreyColor1,
                                    fontFamily: "Barlow",
                                  ),
                                  customText(
                                    text: "Technician notes: Regular maintenance\nrotation",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: rotationGreyColor2,
                                    fontFamily: "Barlow",
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      buttonWidget("Done", whiteColor,colors: brownColor,height: 5.h,fontsize: 15.sp,radius: 12.sp,onTap: (){
                        Get.back();
                      }),
                      SizedBox(height: 1.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}

Widget rotationRow(String title, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 0.5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customText(
          text: title,
          fontWeight: FontWeight.w400,
          fontSize: 15.sp,
          color: rotateTireGreyColor,
          fontFamily: "Barlow",
        ),
        customText(
          text: text,
          fontWeight: FontWeight.w500,
          fontSize: 15.sp,
          color: blackColor,
          fontFamily: "Barlow",
        ),
      ],
    ),
  );
}
