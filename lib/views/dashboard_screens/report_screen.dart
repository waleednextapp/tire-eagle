import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/views/dashboard_screens/remainder.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_detail.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/header_widget.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: whiteColor,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 7.h,
                  left: 6.w,
                  right: 6.w,
                  bottom: 2.h,
                ),
                child: Column(
                  children: [
                    headerWidget(
                      "History & Reports",
                          () {},
                      "Search By Serial Number",
                    ),
                    SizedBox(height: 2.h),
                    Obx(
                          () => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            controller.reportTabs.length,
                                (index) {
                              bool isSelected = controller.reportIndexTab.value == index;
                              bool isLastIndex =
                                  index == controller.reportTabs.length - 1;
                              return Padding(
                                padding: EdgeInsets.only(right: 2.w),
                                child: GestureDetector(
                                  onTap: () => controller.reportValuetoggle(index),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.3.w,
                                      vertical: 1.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? brownColor
                                          : brownColor.withAlpha(40),
                                      borderRadius: BorderRadius.circular(30.sp),
                                    ),
                                    child: Row(
                                      children: [
                                        if (isLastIndex) ...[
                                          Image.asset(
                                            'assets/png/filter_icon.png',
                                            height: 16.sp,
                                            width: 16.sp,
                                            color: isSelected ? whiteColor : brownColor,
                                          ),
                                          SizedBox(width: 2.w),
                                        ],
                                        customText(
                                          text: controller.reportTabs[index],
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: isSelected ? whiteColor : brownColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 1.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 6.w,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70.1.h, // or any fixed/expanded height
                          child: timelineIndicator(),
        
                        ),
                        SizedBox(
                          height: 75.h, // or any fixed/expanded height
                          child: timelineIndicator(),
        
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        width: 78.w,
                        namesize: 16.sp,
                        modelsize: 14.sp,
                        tirewidgetfontsize: 13.sp,
                        customheight: 26.h,
                          ontap: (){
                            Get.toNamed("tire");
                          }
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
                        width: 78.w,
                        namesize: 16.sp,
                        modelsize: 14.sp,
                        tirewidgetfontsize: 13.sp,
                        inusesize: 13.sp,
                        customheight: 29.h,
                          ontap: (){
                            Get.toNamed("tire");
                          }
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 1.1.h),
                        child: customText(
                          text: "22 April 2025",
                          fontSize: 14.sp,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                      reminderWidget(
                        "YXU - 5689",
                        "Michelin XDE2+",
                        "11R22.5",
                        "2nd Puncture",
                        "22 April 2025",
                        "F-Right",
                        "DOT 5478 DC89",
                        "4/32 ---- 🔴 (Replace Now)",
                        width: 78.w,
                        namesize: 16.sp,
                        modelsize: 14.sp,
                        tirewidgetfontsize: 13.sp,
                        customheight: 29.h,
                          ontap: (){
                            Get.toNamed("tire");
                          }
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
                        width: 78.w,
                        namesize: 16.sp,
                        modelsize: 14.sp,
                        tirewidgetfontsize: 13.sp,
                        inusesize: 13.sp,
                        customheight: 29.h,
                          ontap: (){
                            Get.toNamed("tire");
                          }
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
