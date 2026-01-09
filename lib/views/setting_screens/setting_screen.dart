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
    // SharedPreferences se values nikal li taaki code saaf rahay
    String? profilePicUrl = prefs.getString(LocalDBKeys.USERPROFILEPIC);
    String userName = prefs.getString(LocalDBKeys.USERFULLNAME) ?? "User";
    String userEmail = prefs.getString(LocalDBKeys.USEREMAIL) ?? "";

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
          child: Column(
            children: [
              // User Info Section
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
                      // ⭐ FIXED LOGIC: Null aur Empty string dono check kiye
                      child: (profilePicUrl != null && profilePicUrl.isNotEmpty)
                          ? ClipOval(
                        child: Image.network(
                          profilePicUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
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
                            return _buildInitialLetter(userName);
                          },
                        ),
                      )
                          : _buildInitialLetter(userName),
                    ),
                    SizedBox(width: 4.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: userName,
                          fontSize: 20.sp,
                          fontFamily: "Barlow",
                          fontWeight: FontWeight.w600,
                        ),
                        customText(
                          text: userEmail,
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
                                  _handleLogout(context);
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

  // --- Helper Widgets Taaki Code Ganda Na Ho ---

  Widget _buildInitialLetter(String name) {
    return Center(
      child: Text(
        name.isNotEmpty ? name.substring(0, 1).toUpperCase() : "U",
        style: TextStyle(
          fontSize: 12.w,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    successDialog(
      context,
      "Are you sure you want to logout?",
      "No",
      buttonText2: 'Yes',
      onTap2: () {
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
            controller.isUser.value = true;
            controller.loginUserIndex.value = 1;
            Get.offAllNamed("loginscreen");
          },
        );
      },
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
