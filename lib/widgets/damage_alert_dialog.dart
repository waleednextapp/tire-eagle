import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void showDamageAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.w),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Close Button (top-right)
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  size: 5.w,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 1.h),

            /// Circle icon with 'i'
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

            /// Title
            customText(
              text: "Report Damage Alert",
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              fontFamily: "Barlow",
              color: Colors.black,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 1.5.h),

            /// Description
            customText(
              text:
              "Your report of the damage has been shared\nwith nearby fleet drivers.",
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              fontFamily: "Barlow",
              color: Colors.black87,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
