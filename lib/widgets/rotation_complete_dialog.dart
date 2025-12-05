import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void showRotationComplete(BuildContext context,{String? id,String? serialNumber, String? fromPosition, String? toPosition, String? date, String? note, String? time, bool? isWheel = false}) {
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
                    text: isWheel == false ? "Tire has been successfully rotated": "Wheel has been successfully rotated",
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
                          rotationRow(isWheel == false ? "Tire ID" : "Wheel ID", serialNumber ?? 'NA'),

                          rotationRow("From Position", fromPosition ?? 'NA'),
                          rotationRow("To Position", toPosition ?? 'NA'),
                          rotationRow("Date", date ?? "NA"),
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
                                  // Rotated from X to Y → ellipsis if too long
                                  Text(
                                    "Rotated from ${fromPosition} to ${toPosition}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                      color: blackColor,
                                      fontFamily: "Barlow",
                                    ),
                                    overflow: TextOverflow.ellipsis, // ← ellipsis
                                    maxLines: 1,
                                  ),

                                  SizedBox(height: 0.5.h),

                                  // Date & Time
                                  customText(

                                    text: "${date} • 10:23 AM",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                      color: rotationGreyColor1,
                                      fontFamily: "Barlow",
                                  ),

                                  SizedBox(height: 0.5.h),

                                  // Technician notes → wrap to next line
                                  Text(
                                    "Technician notes: ${note ?? ''}",
                                    style: TextStyle(
                                      overflow: TextOverflow.visible,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                      color: rotationGreyColor2,
                                      fontFamily: "Barlow",
                                    ),
                                    softWrap: true, // ← ensures wrapping
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                      // ... (Code above remains the same)

// ... (Inside the showRotationComplete function)

                      SizedBox(height: 2.h),
                      buttonWidget(
                        "Done",
                        whiteColor,
                        colors: brownColor,
                        height: 5.h,
                        fontsize: 15.sp,
                        radius: 12.sp,
                        onTap: () {
                          Get.back();
                          Get.back();

                        },
                      ),
                      SizedBox(height: 1.h),
// ... (Code below remains the same)
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
