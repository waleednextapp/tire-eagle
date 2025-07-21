import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/widgets/button_widget.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';

class Remainder extends StatelessWidget {
  const Remainder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Reminder",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: customText(
                text: "22 April 2025",
                fontSize: 14.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 1.h),
            reminderWidget(
              "YXU - 5689",
              "Michelin XDE2+",
              "11R22.5",
              "2nd Puncture",
              "22 April 2025",
              "F-Right",
              "DOT 5478 DC89",
              "4/32 ---- 🔴 (Replace Now)",
            ),
            reminderWidget(
              "YXU - 3689",
              "Michelin XDE2+",
              "11R22.5",
              "2nd Puncture",
              "22 April 2025",
              "F-Right",
              "DOT 5478 DC89",
              "4/32 ---- 🔴 (Replace Now)",
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: customText(
                text: "20 April 2025",
                fontSize: 14.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 1.h),
            reminderWidget(
              "YXU - 6827",
              "Michelin XDE2+",
              "11R22.5",
              "2nd Puncture",
              "22 April 2025",
              "F-Right",
              "DOT 5478 DC89",
              "4/32 ---- 🔴 (Replace Now)",
            ),
            reminderWidget(
              "YXU - 3149",
              "Michelin XDE2+",
              "11R22.5",
              "2nd Puncture",
              "22 April 2025",
              "F-Right",
              "DOT 5478 DC89",
              "4/32 ---- 🔴 (Replace Now)",
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget reminderWidget(
    String name,
    String model,
    String size,
    String maintenance,
    String date,
    String position,
    String SerialNo,
    String TireHealth,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
      child: Container(
        height: 31.h,
        width: 120.w,

        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: name,
                        fontSize: 19.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                      ),
                      customText(
                        text: model,
                        fontSize: 14.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      color: remainderGreenColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 0.5.h,
                      ),
                      child: customText(
                        text: "In Use",
                        fontSize: 14.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Size",
                        fontSize: 14.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: size,
                        fontSize: 14.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.h),
                      customText(
                        text: "Maintenance",
                        fontSize: 14.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: maintenance,
                        fontSize: 14.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.h),
                      customText(
                        text: "Last Date",
                        fontSize: 14.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        fontSize: 14.sp,
                        text: date,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Position",
                        fontSize: 14.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: position,
                        fontSize: 14.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.h),
                      customText(
                        text: "Serial Number",
                        fontSize: 14.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: SerialNo,
                        fontSize: 14.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.h),
                      customText(
                        text: "Tire Health",
                        fontSize: 14.sp,
                        fontFamily: "",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        fontSize: 14.sp,
                        text: TireHealth,
                        color: redColor,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              buttonWidget(
                "View Detail",
                blackColor,
                colors: yellowColor,
                height: 3.5.h,
                width: double.infinity,
                fontsize: 13.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
