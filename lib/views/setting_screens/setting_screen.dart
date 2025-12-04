import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/constants/constants_widgets.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/controllers/setting_controller.dart';
import 'package:tire_eagle/outh_file/local_db_key.dart';
import 'package:tire_eagle/utils/helper_functions.dart';
import 'package:tire_eagle/utils/shared_prefrences_methods.dart';

import '../../controllers/dashboard_controller.dart';
import '../../widgets/success_dialog.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final AuthController controller = Get.find<AuthController>();
  final SettingController settingController = Get.find<SettingController>();

  final prefs = SharedPreferencesMethod.storage;
  final List<Map<String, String>> rowOption = [
    {"path": "assets/png/setting_icon/contact.png", "name": "My Details"},
    {
      "path": "assets/png/setting_icon/notification.png",
      "name": "Notifications",
    },
    {
      "path": "assets/png/setting_icon/billing.png",
      "name": "Billings & Invoices",
    },
    {
      "path": "assets/png/setting_icon/security.png",
      "name": "Password & Security",
    },
    {"path": "assets/png/setting_icon/logout.png", "name": "Log Out"},
  ];
  final DashboardController dashboardController = Get.find<DashboardController>();
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
                    Container(
                      width: 22.w,
                      height: 22.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: yellowColor.withAlpha(200),
                      ),
                      child: prefs.getString(LocalDBKeys.USERPROFILEPIC) != null
                          ? ClipOval(
                        child: Image.network(
                          prefs.getString(LocalDBKeys.USERPROFILEPIC)!,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            // Show shimmer while image is loading
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 22.w,
                                height: 22.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to first letter if image fails
                            return Center(
                              child: Text(
                                (prefs.getString(LocalDBKeys.USERFULLNAME)?.substring(0, 1) ?? "").toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                          : Center(
                        child: Text(
                          (prefs.getString(LocalDBKeys.USERFULLNAME)?.substring(0, 1) ?? "").toUpperCase(),
                          style: TextStyle(
                            fontSize: 12.w,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Image.asset(LocalDBKeys.USERPROFILEPIC, width: 22.w),
                    SizedBox(width: 4.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: prefs.getString(LocalDBKeys.USERFULLNAME),
                          fontSize: 20.sp,
                          fontFamily: "Barlow",
                          fontWeight: FontWeight.w600,
                        ),
                        customText(
                          text: prefs.getString(LocalDBKeys.USEREMAIL),
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
                                  Get.toNamed("mydetails");
                                  break;
                                case 1:
                                  Get.toNamed("allownotifications");
                                  break;
                                case 2:
                                  Get.toNamed("billing");
                                  break;
                                case 3:
                                  Get.toNamed("password");
                                  break;
                                case 4:
                                  successDialog(
                                    context,
                                    "Are you sure you want to logout?",
                                    buttonText2: 'Yes',
                                    "No",
                                    isLogout: true,
                                        onTap2: (){
                                      Get.back();
                                        },

                                        () {
                                      dashboardController.currentIndex.value = 0;
                                      HelperFunction.clearLocalStorage();
                                          successDialog(
                                            context,
                                            "You’ve been logged out successfully.",
                                            "Ok",
                                                () {
                                              prefs.setBool('isUser', true);
                                              var isUser = prefs.getBool('isUser');
                                              controller.isUser.value = true;
                                              controller.loginUserIndex.value = 1;
                                              print(isUser);
                                                 Get.offAllNamed("loginscreen");
                                            },
                                          );
                                    },
                                  );
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
