import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/views/dashboard_screens/remainder.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_detail.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';

class TireDetail extends StatelessWidget {
  TireDetail({super.key});

  final List<Map<String, String>> remainder = [
    {"title": "Vehical", "content": "Truck #YXU - 5689"},
    {"title": "Size", "content": "22.5"},
    {"title": "Position", "content": "F-Right"},
    {"title": "Serial Number", "content": "DOT 5478 DC89"},
    {"title": "Last Update", "content": "April 25, 2025"},
    {"title": "Install Date", "content": "Feb 20, 2024"},
    {"title": "Maintenance Report:", "content": "3 Punctures"},
    {"title": "Tire Health:", "content": "8/32 ---- 🟡 (Check Soon)"},
    {"title": "Current Mileage:", "content": "12,450 mi"},
    {"title": "Total Spending:", "content": "420 \$"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Tire Details",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("assets/png/wheel_detail_banner.png"),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 1.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                text: "YXU - 5689",
                                fontSize: 19.sp,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w600,
                              ),
                              customText(
                                text: "Michelin XDE2+",
                                fontSize: 14.sp,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),
                              color: containerGreenColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 0.8.h,
                              ),
                              child: customText(
                                text: "In Use",
                                fontSize: 15.sp,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                                color: textGreenColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      height: 32.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: remainder.length,
                        itemBuilder: (context, index) {
                          return vehicaldetail(
                            remainder[index]["title"]!,
                            remainder[index]["content"]!,
                            index: index,
                          );
                        },
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 1.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            text: "Tread Depth History",
                            fontSize: 17.sp,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                          ),
                          customText(
                            text: "8/32",
                            fontSize: 17.sp,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                            color: wheelDetailOrangeColor,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 1.h,
                      ),
                      child: Column(
                        children: [
                          threadDepthWidget("Punctures", 0.75, barOrangeColor, 02),
                          threadDepthWidget("Cuts", 0.32, barredColor, 01),
                          threadDepthWidget("Bulge", 0.01, bargreenColor, 00),
                        ],
                      ),
                    ),
                    Divider(),
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
                                  height: 66.7.h, // or any fixed/expanded height
                                  child: timelineIndicator(),

                                ),
                                SizedBox(
                                  height: 65.h, // or any fixed/expanded height
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
                                  buttoncheaque: false,
                                damagetype: "Cut",
                                spend: "105 \$",lastupdate: "22 April 2025",
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
                                  buttoncheaque: false,
                                inusesize: 13.sp,
                                  damagetype: "Puncture",
                                  spend: "105 \$",lastupdate: "22 April 2025",
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
                                  buttoncheaque: false,
                                  damagetype: "Cut",
                                  spend: "105 \$",lastupdate: "22 April 2025",
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
                                buttoncheaque: false,
                                  damagetype: "Puncture",
                                  spend: "105 \$",lastupdate: "22 April 2025",
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
            ),

            // Bottom fixed Container inside body
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row with 2 buttons
                  Row(
                    children: [
                      Expanded(
                        child: buttonWidget(
                          "Rotate",
                          whiteColor,
                          fontsize: 14.sp,
                          colors: buttonBlueColor,
                          height: 4.7.h,
                          radius: 12.sp,
                          fontfaimly: 'Roboto',
                          fontweight: FontWeight.w600,
                          path: "assets/png/wheel_detail/rotate.png",
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: buttonWidget(
                          "Dismount",
                          whiteColor,
                          fontsize: 14.sp,
                          colors: buttonRedColor,
                          height: 4.7.h,
                          radius: 12.sp,
                          fontfaimly: 'Roboto',
                          fontweight: FontWeight.w600,
                          path: "assets/png/wheel_detail/dismount.png",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),

                  // Separate button under the row
                  SizedBox(
                    width: double.infinity,
                    child: buttonWidget(
                      "Send for Retread",
                      whiteColor,
                      fontsize: 14.sp,
                      colors: buttonPurpleColor,
                      height: 4.7.h,
                      radius: 12.sp,
                      fontfaimly: 'Roboto',
                      fontweight: FontWeight.w600,
                      path: "assets/png/wheel_detail/rethread.png",
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget threadDepthWidget(
      String title,
      double? value,
      Color color,
      int amount,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Fixed-width label
          SizedBox(
            width: 22.w, // ✅ Equal width for all labels
            child: customText(
              text: title,
              fontSize: 14.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 3.w),

          // Progress bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.sp),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 3.h,
              ),
            ),
          ),

          SizedBox(width: 3.w),

          // Amount (fixed width helps too if you want)
          SizedBox(
            width: 8.w,
            child: customText(
              text: amount < 10 ? "0$amount" : "$amount",
              fontSize: 14.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
Widget timelineIndicator({Color color = taglinegreyColor}) {
  return Column(
    children: [
      // Circle at the top
      Container(
        width: 4.w,
        height: 2.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 0.2.w),
          color: Colors.white,
        ),
      ),

      // Vertical line
      Expanded(
        child: Container(
          width: 0.3.w,
          color: color.withOpacity(0.5),
        ),
      ),
    ],
  );
}

