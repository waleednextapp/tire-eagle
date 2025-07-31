import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';

class SelectDismountReason extends StatelessWidget {
  const SelectDismountReason({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Select Dismount Reason",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: dismountProgressWidget(),
                  ),
                  Divider(color: Colors.grey, thickness: 0.3),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dismountBodyWidget(
                          "assets/png/dismount_images/tool.png",
                          "Low Tread",
                          "Tread below safety\nthreshold",
                        ),
                        SizedBox(width: 4.w),
                        dismountBodyWidget(
                          "assets/png/dismount_images/alert.png",
                          "Damaged",
                          "Significant tire damage",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dismountBodyWidget(
                          "assets/png/dismount_images/van.png",
                          "Vehicle Service",
                          "Removed during\nmaintenance",
                        ),
                        SizedBox(width: 4.w),
                        dismountBodyWidget(
                          "assets/png/dismount_images/recycle.png",
                          "Rotation",
                          "Regular tire rotation",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dismountBodyWidget(
                          "assets/png/dismount_images/bin.png",
                          "End of Life",
                          "Tread below safety\nthreshold",
                        ),
                        SizedBox(width: 4.w),
                        dismountBodyWidget(
                          "assets/png/dismount_images/add.png",
                          "Other",
                          "Custom reason",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h), // extra spacing before bottom container
                ],
              ),
            ),
          ),

          // Bottom fixed container
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // light shadow
                  offset: Offset(0, -2), // shadow above the container
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5.h),
                SizedBox(
                  width: double.infinity,
                  child: buttonWidget(
                    "Continue",
                    whiteColor,
                    fontsize: 15.sp,
                    colors: brownColor,
                    height: 4.7.h,
                    radius: 12.sp,
                    fontfaimly: 'Roboto',
                    fontweight: FontWeight.w600,
                    onTap: (){
                      Get.toNamed("assignstoragelocation");
                    }
                  ),
                ),
                SizedBox(height: 1.5.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget dismountProgressWidget({Color? containerColor,Color? textColor, Color? containerColor3, Color? textColor3,Color? centerContainerColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      progressContainerWidget(1, blackColor, yellowColor),
      SizedBox(width: 4.w),
      dashContainer(yellowColor),
      SizedBox(width: 4.w),
      progressContainerWidget(2, textColor ?? dismountGreyColor, containerColor ?? rotateTireTextFeildColor),
      SizedBox(width: 4.w),
      dashContainer(centerContainerColor ?? rotateTireTextFeildColor),
      SizedBox(width: 4.w),
      progressContainerWidget(3, textColor3 ?? dismountGreyColor, containerColor3 ?? rotateTireTextFeildColor),
    ],
  );
}

Widget progressContainerWidget(int num, Color color, Color containerColor) {
  return Container(
    width: 7.w,
    height: 7.w,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: containerColor,
    ),
    alignment: Alignment.center,
    child: customText(
      text: "$num",
      fontSize: 13.sp,
      fontFamily: "Barlow",
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );
}

Widget dashContainer(Color color) {
  return Container(
    width: 10.w,
    height: 0.5.h,
    decoration: BoxDecoration(color: color),
  );
}

Widget dismountBodyWidget(String path, String title, String msg) {
  return Container(
    width: 42.w,
    height: 16.h,
    padding: EdgeInsets.symmetric(vertical: 2.h),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12.sp),
      border: Border.all(
        width: 0.1.w,
        color: textFeildBorderColor,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 4.5.h,
          width: 4.5.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dismountContainerColor,
          ),
          child: Center(
            child: Image.asset(
              path,
              height: 2.h,
              width: 2.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 1.h),
        customText(
          text: title,
          fontSize: 15.sp,
          fontFamily: "Barlow",
          fontWeight: FontWeight.w500,
        ),
        customText(
          text: msg,
          fontSize: 13.sp,
          fontFamily: "Barlow",
          fontWeight: FontWeight.w700,
          color: dismountGreyColor,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
