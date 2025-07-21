import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';

class TireDetail extends StatelessWidget {
  TireDetail({super.key});

  final List<Map<String, String>> remainder = [
    {"title": "Vehical", "content": "Truck #YXU - 5689"},
    {"title": "Size", "content": "22.5"},
    {"title": "Position", "content": "F-Right"},
    {"title": "Serial Number", "content": "DOT 5478 DC89"},
    {"title": "Last Update", "content": "April 25, 2025"},
    {"title": "Install Date", "content": "Feb 20, 2024"},
    {"title": "Maintenance Report::", "content": "3 Punctures"},
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
            text: "Notifications & Alerts",
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
                    Image.asset(
                      "assets/png/wheel_detail_banner.png",
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
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
                              color: Colors.green,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                              child: customText(
                                text: "In Use",
                                fontSize: 14.sp,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: remainder.length,
                      itemBuilder: (context, index) {
                        return vehicaldetail(
                          remainder[index]["title"]!,
                          remainder[index]["content"]!,
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Row(
                        children: [
                          customText(
                            text: "Wheel Condition (0/10):",
                            fontSize: 14.sp,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(width: 6.w),
                          customText(
                            text: "9.5",
                            fontSize: 14.sp,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                          ),
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
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Button 1"),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Button 2"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),

                  // Separate button under the row
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Separate Button"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget vehicaldetail(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 6.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // aligns both columns top-to-top
        children: [
          // First column
          Expanded(
            flex: 4, // 3 parts for title
            child: customText(
              text: title,
              fontSize: 16.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w500,
            ),

          ),
          // Spacer
          SizedBox(width: 6.w),

          // Second column
          Expanded(
            flex: 5, // 5 parts for content
            child: customText(
              text: content,
              fontSize: 14.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w400,
            ),
          ),



        ],

      ),

    );
  }

}
