import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/controllers/user_dashboard_controller.dart';
import 'package:tire_eagle/controllers/user_tire_wheel_controller.dart';
import '../../../constants/constants_widgets.dart';
import '../fleet_home_screen.dart';
import '../wheel_screens/total_wheels.dart';

class UserDashboardScreen extends StatelessWidget {
  UserDashboardScreen({super.key});
  final UserDashboardController userDashboardController = Get.find<UserDashboardController>();
  final UserTireWheelController userTireWheelController = Get.find<UserTireWheelController>();
  final AuthController controller = Get.find<AuthController>();
  // final List<Map<String, dynamic>> staticTires = [
  //   {
  //     "serialNumber": "TYR-1001",
  //     "status": "On Vehicle",
  //     "tireHealth": 85,
  //     "lastCheck": "10 - 11 - 2025"
  //   },
  //   {
  //     "serialNumber": "TYR-1002",
  //     "status": "In Storage",
  //     "tireHealth": 72,
  //     "lastCheck": "08 - 11 - 2025"
  //   },
  //   {
  //     "serialNumber": "TYR-1003",
  //     "status": "In Repair",
  //     "tireHealth": 55,
  //     "lastCheck": "02 - 11 - 2025"
  //   },
  // ];
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if(userDashboardController.isLoading.value){
          return Center(
            child: CircularProgressIndicator(
              color: yellowColor,
            ),
          );
        }
        else{
         return  CustomRefreshIndicator(
            onRefresh: () async {
              await userDashboardController.GetUserHome();
            },
            builder: (BuildContext context, Widget child, IndicatorController controller) {
              return child;
            },
            child: SingleChildScrollView(
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
                                    onTap: () {
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
                          controller: userDashboardController.searchController,
                          onChanged: (value) {
                            userDashboardController.searchTire(value);
                          },
                          style: TextStyle(fontSize: 15.sp, fontFamily: "Barlow",fontWeight: FontWeight.w500),
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
                              borderSide: BorderSide(
                                  color: borderColor, width: 0.2.w),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.sp),
                              borderSide: BorderSide(
                                  color: borderColor, width: 0.2.w),
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
                                  userDashboardController.GetUserHome();
                                  // tireController.GetAllTire();
                                  Get.toNamed("totaltires");
                                },
                                child:
                                homeWidget(
                                  "Total Tires",
                                  "assets/png/tire_img.png",
                                  userDashboardController.userHomeModel.value?.data?.summary!.totalTires ?? 0,
                                )

                            ),
                            InkWell(
                              onTap: (){
                                // tireController.GetAllWheel();
                                Get.toNamed("totalwheel");
                                print(userDashboardController.userHomeModel.value?.data?.tires?.length);
                              },
                              child:
                              homeWidget(
                                "Total Wheels",
                                "assets/png/home_screen_images/wheel.png",
                                userDashboardController.userHomeModel.value?.data?.summary?.totalWheels ?? 0,
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
                      userDashboardController.userHomeModel.value?.data?.tires?.length == 0 ?
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
                            itemCount: userDashboardController.filteredTires.length,
                            itemBuilder: (context, index) {
                              final item = userDashboardController.filteredTires[index];

                              return Padding(
                                padding: EdgeInsets.only(right: 1.w),
                                child: tireDetailWidget(
                                  item.serialNumber ?? '',
                                  item.status ?? '',
                                  "Last Check: ${formatDate(item.updatedAt)}",
                                  getTireColor(item.tireHealth ?? 0),
                                  item.tireHealth ?? 0,
                                  id: item.id,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: directionWidget(),
                      ),

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

