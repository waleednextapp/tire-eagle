import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/widgets/back_button.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Notifications & Alerts",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 1.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: TextField(
                style: TextStyle(fontSize: 13.sp, fontFamily: "Barlow"),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 1.2.h,
                    horizontal: 4.w,
                  ),
                  hintText: 'Search By Serial Number',
                  hintStyle: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: "Barlow",
                    color: textFeildTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: whiteColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                    borderSide: BorderSide(color: borderColor, width: 0.2.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                    borderSide: BorderSide(color: borderColor, width: 0.2.w),
                  ),
        
                  // 👇 Prefix icon instead of suffix
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 2.w),
                    child: Image.asset(
                      "assets/png/search_icon.png",
                      height: 2.h,
                      width: 2.h,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minHeight: 2.h,
                    minWidth: 2.h,
                  ),
                ),
              ),
            ),
            Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                child: Row(
                  children: List.generate(controller.notificationTabs.length, (
                    index,
                  ) {
                    bool isSelected = controller.selectedIndexTab.value == index;
                    bool isLastIndex =
                        index == controller.notificationTabs.length - 1;
        
                    return Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: GestureDetector(
                        onTap: () => controller.selectTabSearch(index),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
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
                                text: controller.notificationTabs[index],
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? whiteColor : brownColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 1.5.h,
                children: [
                  customText(
                    text: "Today",
                    fontSize: 16.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600,
                  ),
                  notificationWidget(
                    "assets/png/notifications_images/d2lo_img.png",
                    "Tread Below Legal Limit",
                    "Tire DOT 5478 DC89 (D2-Left-Outer) tread is\n 2/32\" – DOT violation risk. PARK NOW.",
                    "12:19 PM",
                  ),
                  notificationWidget(
                    "assets/png/notifications_images/alert_image.png",
                    "Aging Tire Alert",
                    "Tire #9015 is 5 years old. Rubber degrades\nover time – inspect for cracks.",
                    "12:19 PM",
                  ),
                  notificationWidget(
                    "assets/png/notifications_images/alert_image.png",
                    "Position-Specific Failure Trend",
                    "3+ punctures on Trailer Right tires in 2\nmonths – inspect axle/wheel well.",
                    "12:19 PM",
                  ),
                  notificationWidget(
                    "assets/png/notifications_images/d2lo_img.png",
                    "Cost-Saving Opportunity",
                    "Retreading Tire DOT 5478 DC89 could save\n\$380 vs. new purchase. Deadline: Mar 15",
                    "12:19 PM",
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 1.5.h,
                children: [
                  customText(
                    text: "Yesterday",
                    fontSize: 16.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600,
                  ),
                  notificationWidget(
                      "assets/png/notifications_images/d2lo_img.png",
                      "Tread Below Legal Limit",
                      "Tire DOT 5478 DC89 (D2-Left-Outer) tread is\n 2/32\" – DOT violation risk. PARK NOW.",
                      "12:19 PM"
                  ),notificationWidget(
                      "assets/png/notifications_images/alert_image.png",
                      "Aging Tire Alert",
                      "Tire #9015 is 5 years old. Rubber degrades\nover time – inspect for cracks.",
                      "12:19 PM"
                  ),notificationWidget(
                      "assets/png/notifications_images/alert_image.png",
                      "Position-Specific Failure Trend",
                      "3+ punctures on Trailer Right tires in 2\nmonths – inspect axle/wheel well.",
                      "12:19 PM"
                  ),
                  notificationWidget(
                      "assets/png/notifications_images/d2lo_img.png",
                      "Cost-Saving Opportunity",
                      "Retreading Tire DOT 5478 DC89 could save\n\$380 vs. new purchase. Deadline: Mar 15",
                      "12:19 PM"
                  ),
        
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 1.5.h,
                children: [
                  customText(
                    text: "April 22, 2025",
                    fontSize: 16.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600,
                  ),
                  notificationWidget(
                      "assets/png/notifications_images/d2lo_img.png",
                      "Tread Below Legal Limit",
                      "Tire DOT 5478 DC89 (D2-Left-Outer) tread is\n 2/32\" – DOT violation risk. PARK NOW.",
                      "12:19 PM"
                  ),notificationWidget(
                      "assets/png/notifications_images/alert_image.png",
                      "Aging Tire Alert",
                      "Tire #9015 is 5 years old. Rubber degrades\nover time – inspect for cracks.",
                      "12:19 PM"
                  ),notificationWidget(
                      "assets/png/notifications_images/alert_image.png",
                      "Position-Specific Failure Trend",
                      "3+ punctures on Trailer Right tires in 2\nmonths – inspect axle/wheel well.",
                      "12:19 PM"
                  ),
                  notificationWidget(
                      "assets/png/notifications_images/d2lo_img.png",
                      "Cost-Saving Opportunity",
                      "Retreading Tire DOT 5478 DC89 could save\n\$380 vs. new purchase. Deadline: Mar 15",
                      "12:19 PM"
                  ),
        SizedBox(height: 5.h,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget notificationWidget(
    String path,
    String title,
    String message,
    String time,
  ) {
    return Row(
      children: [
        Image.asset(path, width: 14.w),
        SizedBox(width: 2.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: customText(
                      text: title,
                      fontSize: 15.sp,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  customText(
                    text: time,
                    fontSize: 14.sp,
                    fontFamily: "Barlow",
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(height: 0.5.h),
              customText(
                text: message,
                fontSize: 14.sp,
                fontFamily: "Barlow",
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
