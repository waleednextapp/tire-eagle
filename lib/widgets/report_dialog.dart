import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void reportDialog(
    BuildContext context, {
      bool? isPuncture,
      String? serialNo,
      String? mountedPosition,
      String? puncture,
      String? cut,
      String? bulge,
      double? serviceFees,
      double? totalAmount,
      String? dateReported
    }) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close icon
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  Get.back();
                },
                child: Icon(Icons.close, size: 20.sp),
              ),
            ),

            SizedBox(height: 1.h),

            // Circular image at top
            Container(
              height: 20.w,
              width: 20.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  "assets/png/report_rethread.png", // Your image path
                  height: 15.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Title
            customText(
              text: isPuncture == true ? "Puncture Report" : "Retread Report",
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),

            SizedBox(height: 2.h),

            // Report details
            reportRow(isPuncture == true ? "Serial Number":"Date Reported", isPuncture == true ? serialNo ?? '':dateReported ?? ''),
            Divider(),
            reportRow(isPuncture == true ? "Mounted Position":"Serial Number", isPuncture == true ? mountedPosition ?? '':serialNo ?? ''),
            Divider(),
            reportRow(isPuncture == true ? "Puncture":"Position", isPuncture == true ? puncture ?? '': mountedPosition ?? ''),
            isPuncture == true ? Column(
              children: [
                Divider(),
                reportRow("Cuts", cut ?? ''),
              ],
            ): SizedBox.shrink(),
            isPuncture == true ? Column(
              children: [
                Divider(),
                reportRow("Bulge", bulge ?? ''),
              ],
            ):SizedBox.shrink(),

            Divider(),

            // reportRow(
            //   "Service Fee",
            //   "\$${serviceFees?.toStringAsFixed(0) ?? "0"}",
            // ),
            // reportRow("Logistic Charges", "\$0"),
            // reportRow("Bank Fee", "\$0"),
            //
            // Divider(),

            reportRow(
              "Total Amount",
              "\$${totalAmount?.toStringAsFixed(0) ?? "0"}",
              fontSize: 20.sp,
              fontweigh: FontWeight.w700,
            ),

            SizedBox(height: 1.h),
          ],
        ),
      ),
    ),
  );
}

Widget reportRow(String title, String description,
    {double? fontSize, FontWeight? fontweigh}) {
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
        fontWeight: fontweigh ?? FontWeight.w400,
        fontSize: fontSize ?? 15.5.sp,
        color: blackColor,
        fontFamily: "Barlow",
      ),
    ],
  );
}
