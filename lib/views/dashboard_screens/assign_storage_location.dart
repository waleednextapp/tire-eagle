import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/views/dashboard_screens/select_dismount_reason.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/dismount_controller.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';

class AssignStorageLocation extends StatelessWidget {
  AssignStorageLocation({super.key});
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
                    child: dismountProgressWidget(containerColor: yellowColor,textColor: blackColor),
                  ),
                  Divider(color: Colors.grey, thickness: 0.3),
                  SizedBox(height: 1.h),
                  Center(
                    child: customText(
                      text: "Where should this tire be stored after dismount?",
                      fontSize: 15.sp,
                      fontFamily: "Barlow",
                      fontWeight: FontWeight.w500,
                      color: textBrownColor,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      children: [
                        locationTile(
                            title: "Main Warehouse",
                            subtitle: "Bay A-12",
                            iconPath: "assets/png/dismount_images/house.png",
                            // isSelected: controller.selectedIndex == 0,
                            isSelected: true,
                            onTap: () {
                              controller.selectedIndex.value = 0;
                            }
                        ),
                        SizedBox(height: 1.h),
                        locationTile(
                            title: "Repair Shop",
                            subtitle: "Service Area",
                            iconPath: "assets/png/dismount_images/tool.png",
                            isSelected: false,
                            onTap: () {
                              controller.selectedIndex.value = 1;
                            }
                        ),
                        SizedBox(height: 1.h),
                        locationTile(
                            title: "Recycling Center",
                            subtitle: "Bay A-12",
                            iconPath: "assets/png/dismount_images/recycle.png",
                            isSelected: false,
                            onTap: () {
                              controller.selectedIndex.value = 2;
                            }
                        ),
                        SizedBox(height: 1.h),
                        locationTile(
                            title: "Main Warehouse",
                            subtitle: "Bay A-12",
                            iconPath: "assets/png/dismount_images/trolly.png",
                            isSelected: false,
                            onTap: () {
                              controller.selectedIndex.value = 3;
                            }
                        ),
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
                                  text: "Tire Information",
                                  fontSize: 15.sp,
                                  fontFamily: "Barlow",
                                  fontWeight: FontWeight.w500,
                                  color: textBrownColor,
                                ),
                                SizedBox(height: 0.5.h),
                                tireInfromation("ID:", "YXU - 5689"),
                                tireInfromation("Model:", "Michelin XDE2+"),
                                tireInfromation("Dismount Reason:", "Low Tread")
                              ],
                            ),
                          ),
                        )
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
                    "Confirm Location",
                    whiteColor,
                    fontsize: 15.sp,
                    colors: brownColor,
                    height: 4.7.h,
                    radius: 12.sp,
                    fontfaimly: 'Roboto',
                    fontweight: FontWeight.w600,
                    onTap: (){
                      Get.toNamed("assignstoragelocationone");
                    }
                  ),
                ),
                SizedBox(height: 1.5.h),
                SizedBox(
                  width: double.infinity,
                  child: buttonWidget(
                    "Skip This Step",
                    blackColor,
                    fontsize: 15.sp,
                    colors: whiteColor,
                    height: 4.7.h,
                    radius: 12.sp,
                    fontfaimly: 'Roboto',
                    fontweight: FontWeight.w600,
                    borderColor: textFeildBorderColor
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

Widget locationTile({
  required String title,
  required String subtitle,
  required String iconPath,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 9.h, // 👈 your desired fixed height
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(
          color: isSelected ? blueBorderColor : textFeildBorderColor,
          width: 0.3.w,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // 👈 vertically center items
        children: [
          // Circle icon
          Container(
            height: 6.h,
            width: 6.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? lightblueBorderColor : dismountContainerColor,
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                height: 2.h,
                width: 2.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 4.w),

          // Text Column
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 👈 center vertically inside column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: title,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: "Barlow",
                ),
                customText(
                  text: subtitle,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: dismountGreyColor,
                  fontFamily: "Barlow",
                ),
              ],
            ),
          ),

          // Selection circle
          isSelected
              ? Container(
            height: 2.8.h,
            width: 2.8.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(
                color: blueBorderColor,
                width: 0.6.w,
              ),
            ),
            child: Center(
              child: Container(
                height: 2.h,
                width: 2.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          )
              : Container(
            height: 2.8.h,
            width: 2.8.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: rotationBorderColor,
                width: 0.3.w,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
Widget tireInfromation(String title, String text) {
  return Row(
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
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
        color: blackColor,
        fontFamily: "Barlow",
      ),
    ],
  );
}

