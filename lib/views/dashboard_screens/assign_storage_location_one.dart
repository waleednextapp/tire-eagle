import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:tire_eagle/views/dashboard_screens/select_dismount_reason.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/dismount_controller.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';
import 'assign_storage_location.dart';

class AssignStorageLocationOne extends StatelessWidget {
  AssignStorageLocationOne({super.key});
  final DismountController controller = Get.find<DismountController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Assign Storage Location",
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
                    child: dismountProgressWidget(containerColor: yellowColor,textColor: blackColor, containerColor3: yellowColor,textColor3: blackColor,centerContainerColor: yellowColor),
                  ),
                  Divider(color: Colors.grey, thickness: 0.3),

                  Center(
                    child: customText(
                      text: "Confirmation",
                      fontSize: 15.sp,
                      fontFamily: "Barlow",
                      fontWeight: FontWeight.w500,
                      color: textBrownColor,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: lightgreenContainerColor,
                        border: Border.all(
                          color: lightYellowBorderColor,
                          width: 0.3.w,
                        ),
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Column(
                          children: [
                            Container(
                              height: 6.h,
                              width: 6.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: mediumgreenContainerColor,
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/png/dismount_images/green_completion_tick.png",
                                  height: 3.h,
                                  width: 3.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            customText(
                              text: "Success! Tire Sent for Retread",
                              fontSize: 18.sp,
                              fontFamily: "Barlow",
                              fontWeight: FontWeight.w600,
                            ),
                            customText(
                              text: "Your request has been processed successfully",
                              fontSize: 15.sp,
                              fontFamily: "Barlow",
                              fontWeight: FontWeight.w400,
                              color: rotateTireGreyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),
                        Container(
                          decoration: BoxDecoration(
                            color: lightBlueColor,
                            border: Border.all(
                              color: textFeildBorderColor,
                              width: 0.3.w,
                            ),
                            borderRadius: BorderRadius.circular(12.sp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                  text: "Tire Detail",
                                  fontSize: 15.sp,
                                  fontFamily: "Barlow",
                                  fontWeight: FontWeight.w500,
                                  color: blackColor,
                                ),
                                SizedBox(height: 0.5.h),
                                tireInfromation("ID:", "YXU - 5689"),
                                tireInfromation("Model:", "Michelin XDE2+"),
                                SizedBox(height: 0.5.h),
                                customText(
                                  text: "Status Change",
                                  fontSize: 15.sp,
                                  fontFamily: "Barlow",
                                  fontWeight: FontWeight.w500,
                                  color: blackColor,
                                ),
                                SizedBox(height: 0.7.h),
                                Row(
                                  children: [
                                    Container(
                                      height: 2.h,
                                      width: 2.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: rotationBorderColor
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    customText(
                                      text: "In Use",
                                      fontSize: 15.sp,
                                      fontFamily: "Barlow",
                                      fontWeight: FontWeight.w400,
                                      color: rotateTireGreyColor,
                                      txtDecoration: TextDecoration.lineThrough
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.w),
                                      child: Container(
                                        height: 2.2.h,
                                        width: 0.6.w,
                                        decoration: BoxDecoration(
                                          color: blueBorderColor
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 0.2.h),
                                Row(
                                  children: [
                                    Container(
                                      height: 2.h,
                                      width: 2.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: blueBorderColor
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    customText(
                                        text: "In Retread",
                                        fontSize: 15.sp,
                                        fontFamily: "Barlow",
                                        fontWeight: FontWeight.w400,
                                        color: blueBorderColor,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 0.5.h),
                                customText(
                                  text: "Tracking Information",
                                  fontSize: 15.sp,
                                  fontFamily: "Barlow",
                                  fontWeight: FontWeight.w500,
                                  color: blackColor,
                                ),
                                SizedBox(height: 0.5.h),
                                tireInfromation("Facility:", "Premium Retreaders Inc."),
                                tireInfromation("Sent Date:", "Today"),
                                tireInfromation("Expected Return:", "July 24, 2025"),
                                tireInfromation("Estimated Cost:", "\$210"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Center(
                          child: customText(
                            text: "You'll receive notifications about the retread progress.",
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w500,
                            color: rotateTireGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),

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
                SizedBox(height: 0.5.h),
                SizedBox(
                  width: double.infinity,
                  child: buttonWidget(
                    "View Tracking Details",
                    whiteColor,
                    fontsize: 15.sp,
                    colors: brownColor,
                    height: 4.7.h,
                    radius: 12.sp,
                    fontfaimly: 'Roboto',
                    fontweight: FontWeight.w600,
                    onTap: (){
                      Get.toNamed("tire");
                    }
                  ),
                ),
                SizedBox(height: 1.5.h),
                SizedBox(

                  width: double.infinity,
                  child: buttonWidget(
                      "Done",
                      blackColor,
                      fontsize: 15.sp,
                      colors: whiteColor,
                      height: 4.7.h,
                      radius: 12.sp,
                      fontfaimly: 'Roboto',
                      fontweight: FontWeight.w600,
                      borderColor: textFeildBorderColor,
                    onTap: (){
                      final controller = Get.find<DashboardController>();
                      controller.changePage(1); // Navigate to Store tab
                      Get.offAll(() => BottomNavBar());
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

