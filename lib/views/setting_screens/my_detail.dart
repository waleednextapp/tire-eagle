import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/custom_text_feild.dart';
import '../../widgets/success_dialog.dart';


class MyDetail extends StatelessWidget {
  MyDetail({super.key});
  final AuthController controller = Get.find<AuthController>();

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
                  // Profile Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.sp),
                    child: Image.asset(
                      "assets/png/profile_pic.png",
                      width: 22.w,
                      height: 22.w,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Camera Icon Circle
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 7.w,
                      height: 7.w,
                      padding: EdgeInsets.all(1.2.w), // optional: controls icon size
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
                ],
              ),
              SizedBox(height: 1.h),
              customTextFeildM(
                "Name",
                "Harry Jonas",
              ),
              SizedBox(height: 1.h),
              customTextFeildM(
                "Email",
                "harry.jonas@xyz.com",
              ),
              SizedBox(height: 1.h),
              customPhoneTextField(
                title: "Phone Number",
                hintText: "Enter Your Phone Number",
                controller: controller.phoneController,
              ),
              SizedBox(height: 1.h),
              Row(children: [
                Expanded(
                  child: customTextFeildM(
                    "Vehical",
                    "Ford F-150",
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: customTextFeildM(
                    "Vehical Number",
                    "YXU - 5689",
                  ),
                ),

              ],),
              SizedBox(height: 3.h),
              buttonWidget("Update", blackColor,height: 5.h,colors: yellowColor,onTap: (){
                successDialog(
                  context,
                  "Profile has been updated successfully.",
                  "Ok",
                      title: "Congratulations!",
                      () {
                    Get.back();
                      },
                );

              }),
            ],
          ),
        ),
      ),
    );
  }
}
