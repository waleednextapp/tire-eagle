import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/constants/constants_widgets.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final List<Map<String, String>> rowOption = [
    {"path": "assets/png/setting_icon/contact.png", "name": "Contact Details"},
    {
      "path": "assets/png/setting_icon/notification.png",
      "name": "Notifications",
    },
    {
      "path": "assets/png/setting_icon/preference.png",
      "name": "App Preferences",
    },
    {
      "path": "assets/png/setting_icon/security.png",
      "name": "Password & Security",
    },
    {"path": "assets/png/setting_icon/logout.png", "name": "Log Out"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: whiteColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Profile Settings",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // <-- Add scroll
          child: Column(
            children: [
              // Top Title
              // Container(
              //   width: double.infinity,
              //   color: whiteColor,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              //     child: customText(
              //       text: "Profile Settings",
              //       fontSize: 20.sp,
              //       fontFamily: "Roboto",
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),

              // User Info
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                child: Row(
                  children: [
                    Image.asset("assets/png/profile_pic.png", width: 22.w),
                    SizedBox(width: 4.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: "Harry Jonas",
                          fontSize: 20.sp,
                          fontFamily: "Barlow",
                          fontWeight: FontWeight.w600,
                        ),
                        customText(
                          text: "YXU - 5689",
                          fontSize: 15.sp,
                          fontFamily: "Barlow",
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Divider(),

              // Settings List
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                      text: "Account Settings",
                      fontSize: 15.sp,
                      fontFamily: "Barlow",
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 1.h),

                    // ListView.builder
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: rowOption.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.5.h),
                          child: buildRow(
                            rowOption[index]["path"]!,
                            rowOption[index]["name"]!,
                            index,
                            () {
                              switch (index) {
                                case 0:
                                  Get.toNamed("scan");
                                  break;
                                case 1:
                                  // Get.toNamed("notification");
                                  break;
                                case 2:
                                  // Get.toNamed("addnewwheel");
                                  break;
                                case 3:
                                  // Get.toNamed("reportdamage");
                                  break;
                                case 4:
                                  Get.toNamed("loginscreen");
                                  break;
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(String path, String name, int index, VoidCallback onTap) {
    final double imageSize = index == 2 ? 5.w : 5.5.w;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(path, width: imageSize, height: imageSize),
                SizedBox(width: 4.w),
                customText(
                  text: name,
                  fontSize: 17.sp,
                  fontFamily: "Barlow",
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: blackColor),
          ],
        ),
      ),
    );
  }
}
