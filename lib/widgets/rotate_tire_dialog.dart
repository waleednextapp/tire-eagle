import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/rotation_complete_dialog.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void showRotateTireDialog(BuildContext context) {
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
          // 👈 Add this line
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 0.8.h),
              customText(
                text: "Rotate Tire",
                fontWeight: FontWeight.w600,
                fontSize: 19.sp,
                fontFamily: "Barlow",
              ),
              SizedBox(height: 0.6.h),
              Divider(color: Colors.grey.shade300, thickness: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: lightBlueColor,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 1.h,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/png/car.png", width: 5.w),
                                SizedBox(width: 3.w),
                                customText(
                                  text: "YXU - 5689",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  fontFamily: "Barlow",
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customText(
                                        text: "Current Position:",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                        color: rotateTireGreyColor,
                                        fontFamily: "Barlow",
                                      ),
                                      SizedBox(height: 0.3.h),
                                      customText(
                                        text: "F-Right",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        fontFamily: "Barlow",
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customText(
                                        text: "Tire Type:",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                        color: rotateTireGreyColor,
                                        fontFamily: "Barlow",
                                      ),
                                      SizedBox(height: 0.3.h),
                                      customText(
                                        text: "Michelin XDE2+",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        fontFamily: "Barlow",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: "New Position",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: rotateTireGreyColor,
                          fontFamily: "Barlow",
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: rotateTireTextFeildColor),
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                          child: Obx(
                            () => DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey.shade600,
                                  size: 17.sp,
                                ),
                                value:
                                    controller.selectedPosition.value.isEmpty
                                        ? null
                                        : controller.selectedPosition.value,
                                hint: customText(
                                  text: "Select position",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  fontFamily: "Barlow",
                                  color: blackColor,
                                ),
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.selectedPosition.value = value;
                                  }
                                },
                                items:
                                    controller.positions.map((position) {
                                      return DropdownMenuItem<String>(
                                        value: position,
                                        child: customText(
                                          text: position,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Barlow",
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Container(
                          decoration: BoxDecoration(
                            color: rotateTireLightOrangeColor,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 1.h,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 0.8.h),
                                  // Slight adjustment
                                  child: Image.asset(
                                    "assets/png/warning.png",
                                    width: 2.5.w,
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: customText(
                                    text:
                                        "Warning: Steer tires should not be placed in drive positions unless specified by manufacturer.",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: rotateTireOrangeTextColor,
                                    fontFamily: "Barlow",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Row(
                          children: [
                            Expanded(
                              child: buttonWidget(
                                "Cancel",
                                blackColor,
                                borderColor: rotateTireTextFeildColor,
                                height: 4.5.h,
                                radius: 10.sp,
                                fontsize: 15.sp,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: buttonWidget(
                                "Confirm Rotation",
                                whiteColor,
                                colors: greenColor,
                                height: 4.5.h,
                                radius: 10.sp,
                                fontsize: 15.sp,
                                onTap: () {
                                  showRotationComplete(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
  );
}
