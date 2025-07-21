import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import '../../constants/constants_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              // Background container with bottom rounded corners
              Container(
                height: 23.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.sp),
                    bottomLeft: Radius.circular(20.sp),
                  ),
                ),
                child: Image.asset(
                  "assets/png/home_screen_images/home_design.png",
                  fit: BoxFit.cover,
                ),
              ),

              // Row with profile image and fleet number
              Positioned(
                top: 7.h,
                left: 6.w,
                right: 6.w,
                child: Row(
                  children: [
                    Image.asset("assets/png/profile_pic.png", width: 13.w),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                text: "Fleet Number",
                                fontSize: 14.sp,
                                fontFamily: "Barlow",
                                fontWeight: FontWeight.w500,
                                color: homeTextColor,
                              ),
                              Row(
                                children: [
                                  customText(
                                    text: "YXU - 5689",
                                    fontSize: 18.sp,
                                    fontFamily: "Barlow",
                                    fontWeight: FontWeight.w600,
                                    color: whiteColor,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 18.sp,
                                    color: whiteColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              Get.toNamed("notification");
                            },
                            child: Image.asset(
                              "assets/png/home_screen_images/notification_bell.png",
                              width: 5.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Search bar placed below the row
              Positioned(
                top: 15.h,
                left: 6.w,
                right: 6.w,
                child: TextField(
                  style: TextStyle(fontSize: 13.sp, fontFamily: "Barlow"),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 1.2.h,
                      horizontal: 4.w,
                    ),
                    hintText: 'Track Tire By Seriel Number',
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
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeWidget(
                      "Total Tires",
                      "assets/png/home_screen_images/tire.png",
                      24,
                    ),
                    homeWidget(
                      "Total Tires",
                      "assets/png/home_screen_images/wheel.png",
                      18,
                    ),
                    homeWidget(
                      "Total Tires",
                      "assets/png/home_screen_images/tool.png",
                      9,
                    ),
                    homeWidget(
                      "Total Tires",
                      "assets/png/home_screen_images/delde.png",
                      6,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: directionWidget(),
              ),
              SizedBox(height: 1.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 6.w), // Left padding
                    tireDetailWidget("DOT 5478 DC89", "Last Check 14 - 4 - 2025", Colors.red),
                    SizedBox(width: 1.w),
                    tireDetailWidget("DOT 1234 AB56", "Last Check 10 - 3 - 2025", Colors.green),
                    SizedBox(width: 1.w),
                    tireDetailWidget("DOT 9999 ZZ99", "Last Check 05 - 2 - 2025", Colors.orange),
                    SizedBox(width: 6.w), // Right padding (optional)
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: customText(
                  text: "Quick Actions",
                  fontSize: 17.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                ),

              ),
              SizedBox(height: 1.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    quickAction(
                      color: blueColor,
                      imagePath: 'assets/png/home_screen_images/add_icon.png',
                      text: 'Add Tire',
                      onTap: () {
                        Get.toNamed("addnewtire");
                      },
                    ),
                    quickAction(
                      color: greenColor,
                      imagePath: 'assets/png/home_screen_images/tire_icon.png',
                      text: 'Add New Wheel',
                      onTap: () {
                        Get.toNamed("addnewwheel");
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    quickAction(
                      color: purpleColor,
                      imagePath: 'assets/png/home_screen_images/remainder_icon.png',
                      text: 'Reminders',
                      onTap: () {
                        Get.toNamed("remainder");

                      },
                    ),
                    quickAction(
                      color: redColor,
                      imagePath: 'assets/png/home_screen_images/alert_icon.png',
                      text: 'Report Damage',
                      onTap: () {
                        Get.toNamed("reportdamage");

                      },
                    ),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget homeWidget(String title, String path, int amount) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2), // horizontal, vertical
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(path, width: 4.5.w),
            SizedBox(height: 0.3.h),
            customText(
              text: title,
              fontSize: 12.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w500,
              color: homeBlueTextColor,
            ),
            customText(
              text: "$amount",
              fontSize: 16.sp,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }

  Widget directionWidget() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(15.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2), // horizontal, vertical
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: "Nearest Tire Station",
                  fontSize: 17.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 0.1.h),
                customText(
                  text: "Fast and reliable tire services, just\naround the corner",
                  fontSize: 13.sp,
                  fontFamily: "Barlow",
                  fontWeight: FontWeight.w500,
                  color: textBrownColor
                ),
                SizedBox(height: 1.h),
                buttonWidget("Get Direction", whiteColor,colors: buttonColor,height: 3.h,width: 20.w,radius: 20.sp,fontsize: 13.sp)
              ],
            ),
            Image.asset("assets/png/home_screen_images/home_map.png",width: 32.w,)
          ],
        ),
      ),
    );
  }

  Widget tireDetailWidget(String tno,String lastcheckdate,Color color){
    return Container(
      width: 88.w,
      decoration: BoxDecoration(
        color: lightYellowWithOpacity,
        borderRadius: BorderRadius.circular(15.sp),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.08),
        //     spreadRadius: 1,
        //     blurRadius: 8,
        //     offset: Offset(0, 2), // horizontal, vertical
        //   ),
        // ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                        text: tno,
                        fontSize: 16.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                        color: textBrownColor
                    ),
                    customText(
                        text: "Need Replacement",
                        fontSize: 12.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w500,
                        color: color
                    ),
                  ],
                ),
                customText(
                    text: lastcheckdate,
                    fontSize: 13.sp,
                    fontFamily: "Barlow",
                    fontWeight: FontWeight.w400,
                    color: textBrownColor
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12.sp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                        text: "Remaining",
                                        fontSize: 13.sp,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w600,
                                        color: blackColor
                                    ),
                                    customText(
                                        text: "Remaining Distance",
                                        fontSize: 12.sp,
                                        fontFamily: "Barlow",
                                        fontWeight: FontWeight.w500,
                                        color: textBrownColor
                                    ),
                                  ],
                                ),
                                SizedBox(width: 2.w),
                                Container(
                                  decoration: BoxDecoration(
                                    color: brownColor,
                                    borderRadius: BorderRadius.circular(12.sp),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                                    child: Column(
                                      children: [
                                        customText(
                                            text: "44",
                                            fontSize: 14.sp,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w600,
                                            color: whiteColor
                                        ),
                                        customText(
                                            text: "Km",
                                            fontSize: 14.sp,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w600,
                                            color: whiteColor
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12.sp),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  customText(
                                    text: "Tires Health",
                                    fontSize: 13.sp,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w600,
                                    color: blackColor,
                                  ),
                                  SizedBox(width: 14.w),
                                  customText(
                                    text: "4/32",
                                    fontSize: 12.sp,
                                    fontFamily: "Barlow",
                                    fontWeight: FontWeight.w500,
                                    color: color,
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.sp),
                                child: Container(
                                  width: 35.w,
                                  height: 0.4.h,
                                  child: LinearProgressIndicator(
                                    value: 0.4,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(color),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Image.asset(
                      "assets/png/home_screen_images/car_wheel.png",
                      width: 25.w,
                    ),
                    Positioned(
                      bottom: 0.5.h, // adjust as needed
                      right: 0.5.w,  // adjust as needed
                      child: Container(
                        width: 7.w,
                        height: 7.w,
                        decoration: BoxDecoration(
                          color: yellowColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 18.sp,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
Widget quickAction({
  required Color color,
  required String imagePath,
  required String text,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10.sp),
    child: Container(
      width: 41.w, // Adjust width as needed
      height: 5.h, // Fixed height for uniform buttons
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 16.sp,
            height: 16.sp,
            fit: BoxFit.contain,
            color: Colors.white,
          ),
          SizedBox(width: 2.w),
          customText(
            text: text,
            fontSize: 16.sp,
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    ),
  );
}
