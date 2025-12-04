import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';

class DisposedHistory extends StatelessWidget {
  const DisposedHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Disposed History",
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
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: customText(
                text: "22 April 2025",
                fontSize: 15.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
            ),
               disposedWidget("Serial Number", "5478 DC89", "D2-Left-Outer", "2nd Puncture", "2nd Cuts", "DOT 5478 DC89","22 April 2025","\$00.00", (){
                 //Get.toNamed("punctureform");
               }),
            disposedWidget("Serial Number", "5478 DC89", "D2-Left-Outer", "2nd Puncture", "2nd Cuts", "DOT 5478 DC89","22 April 2025","\$00.00", (){
            }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 0.4.h),
              child: customText(
                text: "22 April 2025",
                fontSize: 15.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
            ),
            disposedWidget("Serial Number", "5478 DC89", "D2-Left-Outer", "2nd Puncture", "2nd Cuts", "DOT 5478 DC89","22 April 2025","\$00.00", (){
            }),
            disposedWidget("Serial Number", "5478 DC89", "D2-Left-Outer", "2nd Puncture", "2nd Cuts", "DOT 5478 DC89","22 April 2025","\$00.00", (){
            }),
          ],
        ),
      ),
    );
  }
}

Widget disposedWidget(
    String name,
    String model,
    String mountedPosition,
    String puncture,
    String cut,
    String date,
    String bulge,
    String cost,
    VoidCallback ontap,
    ) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.5.h),
    child: InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity, // Full width
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.sp,
              offset: Offset(0, 2.sp),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row with name and model
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: name,
                        fontSize: 17.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                      ),
                      customText(
                        text: model,
                        fontSize: 15.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 1.h),

              // Details row
              Row(
                children: [
                  // Left Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Mounted Position",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: mountedPosition,
                        fontSize: 13.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.5.h),
                      customText(
                        text: "Cuts",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        fontSize: 13.sp,
                        text: cut,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.5.h),
                      customText(
                        text: "Date of Puncture",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        fontSize: 13.sp,
                        text: date,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(width: 15.w),
                  // Right Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Puncture",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: puncture,
                        fontSize: 13.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.5.h),
                      customText(
                        text: "Bulge",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: bulge,
                        fontSize: 13.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.5.h),
                      customText(
                        text: "Cost",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: cost,
                        fontSize: 13.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


