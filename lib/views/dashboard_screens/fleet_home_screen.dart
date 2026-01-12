import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/models/home_model.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_screens/total_wheels.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import '../../constants/constants_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  Summary? home;
  final AuthController controller = Get.find<AuthController>();
  final DashboardController dashboardController = Get.find<DashboardController>();
  final TotalTireController tireController = Get.find<TotalTireController>();

  // @override
  // Widget build(BuildContext context) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     dashboardController.home();
  //   });
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Stack(
  //             children: [
  //               // Background container with bottom rounded corners
  //               Container(
  //                 height: 23.h,
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                   color: buttonColor,
  //                   borderRadius: BorderRadius.only(
  //                     bottomRight: Radius.circular(20.sp),
  //                     bottomLeft: Radius.circular(20.sp),
  //                   ),
  //                 ),
  //                 child: Image.asset(
  //                   "assets/png/home_screen_images/home_design.png",
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //
  //               // Row with profile image and fleet number
  //               Positioned(
  //                 top: 7.h,
  //                 left: 6.w,
  //                 right: 6.w,
  //                 child: Row(
  //                   children: [
  //                     Image.asset("assets/png/profile_pic.png", width: 13.w),
  //                     SizedBox(width: 4.w),
  //                     Expanded(
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               customText(
  //                                 text: "Fleet Number",
  //                                 fontSize: 14.sp,
  //                                 fontFamily: "Barlow",
  //                                 fontWeight: FontWeight.w500,
  //                                 color: homeTextColor,
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   customText(
  //                                     text: "YXU - 5689",
  //                                     fontSize: 18.sp,
  //                                     fontFamily: "Barlow",
  //                                     fontWeight: FontWeight.w600,
  //                                     color: whiteColor,
  //                                   ),
  //                                   Icon(
  //                                     Icons.keyboard_arrow_down,
  //                                     size: 18.sp,
  //                                     color: whiteColor,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           InkWell(
  //                             onTap: (){
  //                               Get.toNamed("notification");
  //                               print(controller.isUser.value);
  //                             },
  //                             child: Image.asset(
  //                               "assets/png/home_screen_images/notification_bell.png",
  //                               width: 5.w,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //
  //               // Search bar placed below the row
  //               Positioned(
  //                 top: 15.h,
  //                 left: 6.w,
  //                 right: 6.w,
  //                 child: TextField(
  //                   style: TextStyle(fontSize: 13.sp, fontFamily: "Barlow"),
  //                   decoration: InputDecoration(
  //                     isDense: true,
  //                     contentPadding: EdgeInsets.symmetric(
  //                       vertical: 1.2.h,
  //                       horizontal: 4.w,
  //                     ),
  //                     hintText: 'Track Tire By Seriel Number',
  //                     hintStyle: TextStyle(
  //                       fontSize: 15.sp,
  //                       fontFamily: "Barlow",
  //                       color: textFeildTextColor,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                     filled: true,
  //                     fillColor: whiteColor,
  //                     enabledBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(20.sp),
  //                       borderSide: BorderSide(color: borderColor, width: 0.2.w),
  //                     ),
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(20.sp),
  //                       borderSide: BorderSide(color: borderColor, width: 0.2.w),
  //                     ),
  //                     prefixIcon: Padding(
  //                       padding: EdgeInsets.only(left: 4.w, right: 2.w),
  //                       child: Image.asset(
  //                         "assets/png/search_icon.png",
  //                         height: 2.h,
  //                         width: 2.h,
  //                       ),
  //                     ),
  //                     prefixIconConstraints: BoxConstraints(
  //                       minHeight: 2.h,
  //                       minWidth: 2.h,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     InkWell(
  //                       onTap:(){
  //                         dashboardController.home();
  //                         Get.toNamed("totaltires");
  //   },
  //                       child: Obx(()=>
  //                       dashboardController.isLoading.value
  //                           ? homeWidgetShimmer()
  //                          : homeWidget(
  //                           "Total Tires",
  //                           "assets/png/tire_img.png",
  //                           dashboardController.homeModel.value?.data?.summary!.totalTires ?? 0,
  //                         ),
  //                       ),
  //                     ),
  //                     InkWell(
  //                       onTap: (){
  //                         Get.toNamed("totalwheel");
  //                         print(dashboardController.homeModel.value?.data?.tires?.length);
  //                       },
  //                       child: Obx(() =>
  //                       dashboardController.isLoading.value
  //                           ? homeWidgetShimmer()
  //                           : homeWidget(
  //                         "Total Wheels",
  //                         "assets/png/home_screen_images/wheel.png",
  //                         dashboardController.homeModel.value?.data?.summary?.totalWheels ?? 0,
  //                         imgWidth: 7.5.w,
  //                       ),
  //                       )
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               // Padding(
  //               //   padding: EdgeInsets.symmetric(horizontal: 6.w),
  //               //   child: directionWidget(),
  //               // ),
  //               SizedBox(height: 1.h),
  //               SizedBox(
  //                 height: 22.h, // adjust according to your tireDetailWidget height
  //                 child: ListView.builder(
  //                   scrollDirection: Axis.horizontal,
  //                   padding: EdgeInsets.symmetric(horizontal: 6.w),
  //                   itemCount: dashboardController.homeModel.value?.data?.tires?.length, // replace with your dynamic tire list length if available
  //                   itemBuilder: (context, index) {
  //                     // // You can replace these with dynamic data from your model
  //                     // String serialNumber;
  //                     // String lastCheck;
  //                     // Color color;
  //                     final item = dashboardController.homeModel.value?.data?.tires?[index];
  //                     Color getTireColor(int health) {
  //                       if (health >= 40 && health <= 60) {
  //                         return Colors.red;
  //                       } else if (health > 60 && health <= 80) {
  //                         return Colors.yellow;
  //                       } else if (health > 80) {
  //                         return Colors.green;
  //                       } else {
  //                         return Colors.red; // fallback for very low health
  //                       }
  //                     }
  //
  //                     return Padding(
  //                       padding: EdgeInsets.only(right: 1.w),
  //                       child: tireDetailWidget(item?.serialNumber ?? '',item?.status ?? '', "Last Check 14 - 4 - 2025" ,getTireColor(item?.tireHealth ?? 0),item?.tireHealth ?? 0),
  //                     );
  //                   },
  //                 ),
  //               ),
  //
  //
  //               // SingleChildScrollView(
  //               //   scrollDirection: Axis.horizontal,
  //               //   child: Row(
  //               //     children: [
  //               //       SizedBox(width: 6.w), // Left padding
  //               //       tireDetailWidget("DOT 5478 DC89", "Last Check 14 - 4 - 2025", Colors.red),
  //               //       SizedBox(width: 1.w),
  //               //       tireDetailWidget("DOT 1234 AB56", "Last Check 10 - 3 - 2025", Colors.green),
  //               //       SizedBox(width: 1.w),
  //               //       tireDetailWidget("DOT 9999 ZZ99", "Last Check 05 - 2 - 2025", Colors.orange),
  //               //       SizedBox(width: 6.w), // Right padding (optional)
  //               //     ],
  //               //   ),
  //               // ),
  //               SizedBox(height: 1.h),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 6.w),
  //                 child: customText(
  //                   text: "Quick Actions",
  //                   fontSize: 17.sp,
  //                   fontFamily: "Roboto",
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //
  //               ),
  //               SizedBox(height: 1.h),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 3.w),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     quickAction(
  //                       color: purpleColor,
  //                       imagePath: 'assets/png/wheel_detail/rethread.png',
  //                       text: 'Send for Retread',
  //                       onTap: () {
  //                         Get.toNamed("rethread");
  //                       },
  //                     ),
  //                     quickAction(
  //                       color: greenColor,
  //                       imagePath: 'assets/png/home_screen_images/tire_black.png',
  //                       text: 'Add Wheel/Tire',
  //                       onTap: () {
  //                         Get.toNamed("addnewtire");
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(height: 1.h),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 3.w),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     quickAction(
  //                       color: blueColor,
  //                       imagePath: 'assets/png/home_screen_images/remainder_icon.png',
  //                       text: 'Reminders',
  //                       width: 5.w,
  //                       containerWidth: 11,
  //                       onTap: () {
  //                         Get.toNamed("remainder");
  //
  //                       },
  //                     ),
  //                     quickAction(
  //                       color: redColor,
  //                       imagePath: 'assets/png/home_screen_images/alert.png',
  //                       text: 'Report Damage',
  //                       width: 5.w,
  //                       containerWidth: 11,
  //                       onTap: () {
  //                         Get.toNamed("reportdamage");
  //
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Check if loading
        if (dashboardController.isLoading.value) {
          // Full screen loader
          return Center(
            child: CircularProgressIndicator(
              color: yellowColor,
            ),
          );
        } else {
          // Actual content when data is loaded
          return CustomRefreshIndicator(
            onRefresh: () async {
              await dashboardController.home();
            },
            builder: (BuildContext context, Widget child, IndicatorController controller) {
              return child;
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
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
                                      print(controller.isUser.value);
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
                          cursorColor: yellowColor,
                          controller: dashboardController.searchController,
                          onChanged: (value) {
                            dashboardController.searchTire(value);
                          },
                          style: TextStyle(fontSize: 15.sp, fontFamily: "Barlow",fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 1.2.h,
                              horizontal: 4.w,
                            ),
                            hintText: 'Track Tire By Serial Number',
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
                            InkWell(
                              onTap:(){
                                dashboardController.home();
                                tireController.GetAllTire();
                                Get.toNamed("totaltires");
                              },
                              child:
                              homeWidget(
                                "Total Tires",
                                "assets/png/tire_img.png",
                                dashboardController.homeModel.value?.data?.summary!.totalTires ?? 0,
                              )

                            ),
                            InkWell(
                                onTap: (){
                                  tireController.GetAllWheel();
                                  Get.toNamed("totalwheel");
                                  print(dashboardController.homeModel.value?.data?.tires?.length);
                                },
                                child:
                                homeWidget(
                                  "Total Wheels",
                                  "assets/png/home_screen_images/wheel.png",
                                  dashboardController.homeModel.value?.data?.summary?.totalWheels ?? 0,
                                  imgWidth: 7.5.w,
                                ),

                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                      //   child: directionWidget(),
                      // ),
                      SizedBox(height: 1.h),
                      dashboardController.homeModel.value?.data?.tires?.length == 0 ?
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Container(
                                height: 22.h,
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
                              child: Center(
                                child: customText(
                                  text: "No Tires Available",
                                  fontSize: 15.sp,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ):
                      SizedBox(
                        height: 22.h,
                        child: Obx(
                              () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            itemCount: dashboardController.filteredTires.length,
                            itemBuilder: (context, index) {
                              final item = dashboardController.filteredTires[index];

                              return Padding(
                                padding: EdgeInsets.only(right: 1.w),
                                child: tireDetailWidget(
                                  item.serialNumber ?? '',
                                  item.status ?? '',
                                  "Last Check: ${formatDate(item.updatedAt)}",
                                  getTireColor(item.tireHealth ?? 0),
                                  item.tireHealth ?? 0,
                                  id: item.id,
                                  distance: (item.remainingDistance ?? 0).toString(),

                                ),
                              );
                            },
                          ),
                        ),
                      ),


                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: [
                      //       SizedBox(width: 6.w), // Left padding
                      //       tireDetailWidget("DOT 5478 DC89", "Last Check 14 - 4 - 2025", Colors.red),
                      //       SizedBox(width: 1.w),
                      //       tireDetailWidget("DOT 1234 AB56", "Last Check 10 - 3 - 2025", Colors.green),
                      //       SizedBox(width: 1.w),
                      //       tireDetailWidget("DOT 9999 ZZ99", "Last Check 05 - 2 - 2025", Colors.orange),
                      //       SizedBox(width: 6.w), // Right padding (optional)
                      //     ],
                      //   ),
                      // ),
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
                        child: Column(
                          children: [
                            quickAction(
                              color: purpleColor,
                              imagePath: 'assets/png/wheel_detail/rethread.png',
                              text: 'Send for Retread',
                              onTap: () {
                                Get.toNamed("rethread");
                              },
                            ),
                            SizedBox(height: 1.h),
                            quickAction(
                              color: greenColor,
                              imagePath: 'assets/png/home_screen_images/tire_black.png',
                              text: 'Add Wheel/Tire',
                              onTap: () {
                                Get.toNamed("addnewtire");
                              },
                            ),
                            SizedBox(height: 1.h),

                            quickAction(
                              color: blueColor,
                              imagePath: 'assets/png/home_screen_images/remainder_icon.png',
                              text: 'Reminders',
                              width: 5.w,
                              containerWidth: 11,
                              onTap: () {
                                Get.toNamed("remainder");

                              },
                            ),
                            SizedBox(height: 1.h),
                            quickAction(
                              color: redColor,
                              imagePath: 'assets/png/home_screen_images/alert.png',
                              text: 'Report Damage',
                              width: 5.w,
                              containerWidth: 11,
                              onTap: () {
                                Get.toNamed("reportdamage");
                              },
                            ),
                            SizedBox(height: 1.h),
                            quickAction(
                              color: brownColor,
                              imagePath: 'assets/png/home_screen_images/tire_black.png',
                              text: 'Puncture',
                              width: 5.w,
                              containerWidth: 11,
                              onTap: () {
                                Get.toNamed("punctureform");
                              },
                            ),
                          ],
                        ),
                      )


                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }



}
Widget quickAction({
  required Color color,
  required String imagePath,
  required String text,
  required VoidCallback onTap,
  double? width,
  double? containerWidth
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10.sp),
    child: Container(
      width: double.infinity, // Adjust width as needed
      height: 10.h, // Fixed height for uniform buttons
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 1.w),
          Container(
            decoration: BoxDecoration(
              color: whiteColor.withAlpha(50),
              shape: BoxShape.circle
            ),
            child: Padding(
              padding: EdgeInsets.all(containerWidth ?? 8.0),
              child: Image.asset(
                imagePath,
                width: width ?? 8.w,
                fit: BoxFit.contain,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          customText(
            text: text,
            fontSize: 17.sp,
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    ),
  );
}
Widget homeWidgetShimmer({double? height}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: 40.w,
      height: height ?? 6.5.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.sp),
      ),
    ),
  );
}
Widget homeWidget(String title, String path, int amount,{double? imgWidth}) {
  return Container(
    width: 40.w,
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
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            path,
            width: imgWidth ?? 7.w,
          ),
          SizedBox(width: 2.w),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                  text: title,
                  fontSize: 12.sp,
                  fontFamily: "Barlow",
                  fontWeight: FontWeight.w500,
                  color: homeBlueTextColor,
                  height: 0.12.h
              ),
              customText(
                text: "$amount",
                fontSize: 16.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
              ),
            ],
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
      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/png/home_screen_images/home_map.png",width: double.infinity,),
              SizedBox(height: 1.h),
              customText(
                text: "Nearest Tire Station",
                fontSize: 17.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
              ),
              customText(
                  text: "Fast and reliable tire services, just around the corner",
                  fontSize: 13.sp,
                  fontFamily: "Barlow",
                  fontWeight: FontWeight.w500,
                  color: textBrownColor
              ),
              SizedBox(height: 2.h),
              buttonWidget("Get Direction", whiteColor,colors: buttonColor,height: 3.h,width: 23.w,radius: 20.sp,fontsize: 13.sp,onTap: (){
                Get.toNamed("near");
              })
            ],
          ),


    ),
  );
}

Widget tireDetailWidget(String tno,String status,String lastcheckdate,Color color,int tireHealth,{String? id,bool? isHome = true,String? distance}){
  final TotalTireController tireController = Get.find<TotalTireController>();
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
    child:

    Padding(
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
                      text: status,
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
                                  padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.5.h),
                                  child: Column(
                                    children: [
                                      customText(
                                          text: "${distance}",
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
                                  text: "${tireHealth}%",   // 👈 percent added
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
                                  value: tireHealth/100,
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
                    child: InkWell(
                      onTap: (){
                        if(tireController.isUser == false){
                          Get.toNamed("tire", arguments: id); // List me do values
                            tireController.isHome?.value = true;
                        }
                        else{
                          Get.toNamed("usergettirebyid",arguments: id);
                          tireController.isHome?.value = true;
                        }

                      },
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
Color getTireColor(int health) {
  if (health >= 40 && health <= 60) {
    return Colors.red;
  } else if (health > 60 && health <= 80) {
    return Colors.yellow;
  } else if (health > 80) {
    return Colors.green;
  } else {
    return Colors.red; // fallback for very low health
  }
}
