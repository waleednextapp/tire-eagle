import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void reportDialog(BuildContext context,{bool? isPuncture}) {
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
            Container(
              height: 20.w,
              width: 20.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  "assets/png/report_rethread.png", // Replace with actual image path
                  height: 15.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            customText(
              text: isPuncture == false ? "Report Retread": "Puncture",
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: blackColor,
              fontFamily: "Barlow",
            ),
            isPuncture == false ?
            customText(
              text: "Invoice# 9571-1845",
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              color: reportGreyColor,
              fontFamily: "Barlow",
            ): SizedBox.shrink(),
            SizedBox(height: 3.h),
            reportRow(isPuncture == false ? "Date Reported:":"Serial Number", "February 11, 2025"),
            SizedBox(height: 0.2.h),
            Divider(),
            SizedBox(height: 0.2.h),
            reportRow(isPuncture == false ? "Service:":"Mounted Position ", "Maintenance"),
            SizedBox(height: 0.2.h),
            Divider(),
            SizedBox(height: 0.2.h),
            reportRow(isPuncture == false ? "Tire Serial Number:" : "Puncture", "DOT 5478 DC89"),
            SizedBox(height: 0.2.h),
            Divider(),
            SizedBox(height: 0.2.h),
            reportRow(isPuncture == false ? "Size":"Cuts", "11R22.5"),
            SizedBox(height: 0.2.h),
            Divider(),
            SizedBox(height: 0.2.h),
            reportRow(isPuncture == false ? "Position":"Bulge", "D2-Left-Outer"),
            SizedBox(height: 0.2.h),
            Divider(),
            SizedBox(height: 0.2.h),
            reportRow("Service Fee", "\$250"),
            SizedBox(height: 1.h),
            reportRow("Logistic Charges", "\$50.00"),
            SizedBox(height: 1.h),
            reportRow("Bank Fee", "\$3.00"),
            SizedBox(height: 0.2.h),
            Divider(),
            SizedBox(height: 0.2.h),
            reportRow("Total Amount", "\$303.00",fontSize: 20.sp,fontweigh: FontWeight.w700),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    ),
  );
}

Widget reportRow(String title,String description,{double? fontSize,FontWeight? fontweigh}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      customText(
        text: title,
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
        color: reportGreyColor,
        fontFamily: "Barlow",
      ),
      customText(
        text: description,
        fontWeight: fontweigh ?? FontWeight.w500,
        fontSize: fontSize ?? 15.5.sp,
        color: blackColor,
        fontFamily: "Barlow",
      ),
    ],
  );
}
