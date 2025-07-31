import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void showRetreadDialog(BuildContext context) {
  final DashboardController controller = Get.find<DashboardController>();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.close, size: 20.sp),
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 22.w,
              width: 22.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  "assets/png/report_rethread.png", // Replace with actual image path
                  width: 18.w,
                  height: 18.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            customText(
              text: "Report Retread",
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
              color: blackColor,
              fontFamily: "Barlow",
            ),
            SizedBox(height: 1.h),
            customText(
              text: "Your retread data has been successfully\nadded to the tire history.",
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: rotateTireGreyColor,
              fontFamily: "Barlow",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}


