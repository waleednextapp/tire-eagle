import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/setting_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/outh_file/local_db_key.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/shared_prefrences_methods.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/custom_text_feild.dart';
import '../../widgets/success_dialog.dart';


class MyDetail extends StatelessWidget {
  MyDetail({super.key});
  final prefs = SharedPreferencesMethod.storage;
  final AuthController controller = Get.find<AuthController>();
  final DashboardController dashboardController = Get.find<DashboardController>();
  final SettingController settingController = Get.find<SettingController>();
  final TotalTireController totalTireController = Get.find<TotalTireController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "My Details",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 3.h),
          child: Column(
            children: [
              Stack(
                children: [
                  // Profile Image (Reactive)
                  Obx(() {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(100.sp),
                      child: settingController.profilePicture.value != null
                          ? Image.file(
                        settingController.profilePicture.value!,
                        width: 22.w,
                        height: 22.w,
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        "${prefs.getString(LocalDBKeys.USERPROFILEPIC)}",
                        width: 22.w,
                        height: 22.w,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),

                  // Camera Icon Circle
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        settingController.getPicture();
                        dashboardController.uploadImage(3);
                      },
                      child: Container(
                        width: 7.w,
                        height: 7.w,
                        padding: EdgeInsets.all(1.2.w),
                        decoration: BoxDecoration(
                          color: yellowColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "assets/png/setting_icon/camera.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              customTextFeildM(
                "Name",
                "Harry Jonas",
                controller: settingController.nameController
              ),
              SizedBox(height: 1.h),
              customTextFeildM(
                "Email",
                "harry.jonas@xyz.com",
                controller: settingController.emailController
              ),
              SizedBox(height: 1.h),
              customPhoneTextField(
                title: "Phone Number",
                hintText: "Enter Your Phone Number",
                controller: settingController.phoneController,
              ),
              SizedBox(height: 1.h),
              // Row(children: [
              //   Expanded(
              //     child: customTextFeildM(
              //       "Vehical",
              //       "Ford F-150",
              //     ),
              //   ),
              //   SizedBox(width: 4.w),
              //   Expanded(
              //     child: customTextFeildM(
              //       "Vehical Number",
              //       "YXU - 5689",
              //     ),
              //   ),
              //
              // ],),
              SizedBox(height: 3.h),
              buttonWidget(
                "Update",
                blackColor,
                height: 5.h,
                colors: yellowColor,
                onTap: () {

                  // Check for empty fields and profile picture
                  if (settingController.nameController.text.trim().isEmpty ||
                      settingController.emailController.text.trim().isEmpty ||
                      settingController.phoneController.text.trim().isEmpty ||
                      dashboardController.profilePicture.value == null) {
                    Get.snackbar(
                      "Error",
                      "Please fill all fields and upload a profile picture",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(10),
                      duration: const Duration(seconds: 2),
                    );
                    return; // Stop execution if validation fails
                  }
                  // All fields filled and picture uploaded, proceed to update
                  if(totalTireController.isUser == true){
                    settingController.updateUserProfile(context);
                  }
                  else{
                    settingController.updateProfile(context);
                  }

                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
