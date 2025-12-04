import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/widgets/damage_alert_dialog.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/dashboard_controller.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/customTextFeild.dart';

class ReportDamage extends StatelessWidget {
  ReportDamage({super.key});
  final DashboardController controller = Get.find<DashboardController>();
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
            text: "Report Damage",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.5.h),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 6.w),
          //   child: customText(
          //     text: "Your Damage Location",
          //     fontSize: 15.sp,
          //     fontFamily: "Barlow",
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
          // Container(
          //   width: double.infinity,
          //   child: Image.asset("assets/png/map.png"),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Obx(
                  () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  children: List.generate(controller.reportTab.length, (
                      index,
                      ) {
                    bool isSelected = controller.reportDamageTab.value == index;

                    return Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: GestureDetector(
                        onTap: () => controller.reportDamageToggle(index),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 0.7.h,
                          ),
                          decoration: BoxDecoration(
                            color:
                            isSelected
                                ? brownColor
                                : brownColor.withAlpha(40),
                            borderRadius: BorderRadius.circular(30.sp),
                          ),
                          child: Row(
                            children: [
                              customText(
                                text: controller.reportTab[index],
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? whiteColor : brownColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
      Obx(() {
        return controller.reportDamageTab.value == 0
            ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
          child: Column(
            spacing: 0.5.h,
            children: [
              customTextFeildM(
                "Serial Number",
                "Enter serial number",
                controller: controller.tireSerialNumber,
              ),
              SizedBox(height: 0.5.h),
              customDropdownField<String>(
                title: "Tire Mounted Position",
                hintText: "D2-Left-Outer",
                items: controller.mountedPositionList5,
                selectedItem: controller.mountedPositionList5.contains(controller.mountedPosition5.value)
                    ? controller.mountedPosition5.value
                    : null,
                onChanged: (value) {
                  controller.mountedPosition5.value = value ?? "";
                },
              ),

              SizedBox(height: 0.5.h),

              Row(
                children: [
                  Expanded(
                    child: customDropdownField<String>(
                      title: "Damage Type",
                      hintText: "Puncture",
                      items: controller.damageTypeList,
                      selectedItem: controller.damageTypeList.contains(controller.damageType.value)
                          ? controller.damageType.value
                          : null,
                      onChanged: (value) {
                        controller.damageType.value = value ?? "";
                      },
                    ),
                  ),
                  SizedBox(width: 4.w),

                  Expanded(
                    child: customDropdownField<String>(
                      title: "Severity",
                      hintText: "Minor",
                      items: controller.severityList,
                      selectedItem: controller.severityList.contains(controller.severity.value)
                          ? controller.severity.value
                          : null,
                      onChanged: (value) {
                        controller.severity.value = value ?? "";
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.5.h),
              customDropdownField<int>(
                title: "No Of Damage",
                hintText: "1",
                items: controller.noOfDamageList,   // List<int>
                selectedItem: controller.noOfDamageList.contains(controller.noOfDamage.value)
                    ? controller.noOfDamage.value
                    : null,
                onChanged: (value) {
                  controller.noOfDamage.value = value ?? 0;
                },
              ),

              SizedBox(height: 0.5.h),

              customTextFeildM(
                "Date of Entry",
                "MM/DD/YYYY",
                path: "assets/png/calender_icon.png",
                readonly: true,
                controller: controller.tiredateController3,
                ontap: () {
                  controller.pickDate(context, controller.tiredateController3);
                },
              ),

              SizedBox(height: 0.5.h),

              customTextFeildM(
                maxlines: 3,
                "Add Note ( Optional )",
                "Write Something Here",
                controller: controller.tireNoteController
              ),

              SizedBox(height: 1.h),

              buttonWidget("Submit Report", blackColor,
                  colors: yellowColor, onTap: () {
                    if (controller.tireSerialNumber.text.trim().isEmpty ||
                        controller.mountedPosition5.value.trim().isEmpty ||
                        controller.damageType.value.trim().isEmpty ||
                        controller.severity.value.trim().isEmpty ||
                        controller.noOfDamage.value <= 0 ||
                        controller.tiredateController3.text.trim().isEmpty) {

                      Get.snackbar(
                        "Error",
                        "Please fill all required fields",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                      return;
                    } else {
                      controller.reportTireDamage(context);
                    }



                  }),
            ],
          ),
        )
            : Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
          child: Column(
            spacing: 0.5.h,
            children: [
              customTextFeildM(
                "Serial Number",
                "Enter serial number",
                controller: controller.wheelSerialNumber,
              ),
              SizedBox(height: 0.5.h),
              customDropdownField<String>(
                title: "Wheel Mounted Position",
                hintText: "D2-Left-Outer",
                items: controller.mountedPositionList6,
                selectedItem: controller.mountedPositionList6.contains(controller.mountedPosition6.value)
                    ? controller.mountedPosition6.value
                    : null,
                onChanged: (value) {
                  controller.mountedPosition6.value = value ?? "";
                },
              ),

              SizedBox(height: 0.5.h),

              Row(
                children: [
                  Expanded(
                    child: customDropdownField<String>(
                      title: "Damage Type",
                      hintText: "Cut",
                      items: controller.damageType1List,
                      selectedItem: controller.damageType1List.contains(controller.damageType1.value)
                          ? controller.damageType1.value
                          : null,
                      onChanged: (value) {
                        controller.damageType1.value = value ?? "";
                      },
                    ),
                  ),
                  SizedBox(width: 4.w),

                  Expanded(
                    child: customDropdownField<String>(
                      title: "Severity",
                      hintText: "Minor",
                      items: controller.severity1List,
                      selectedItem: controller.severity1List.contains(controller.severity1.value)
                          ? controller.severity1.value
                          : null,
                      onChanged: (value) {
                        controller.severity1.value = value ?? "";
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.5.h),
              customDropdownField<int>(
                title: "No Of Damage",
                hintText: "1",
                items: controller.noOfDamage1List,   // List<int>
                selectedItem: controller.noOfDamage1List.contains(controller.noOfDamage1.value)
                    ? controller.noOfDamage1.value
                    : null,
                onChanged: (value) {
                  controller.noOfDamage1.value = value ?? 0;
                },
              ),
              SizedBox(height: 0.5.h),

              customTextFeildM(
                "Date of Entry",
                "MM/DD/YYYY",
                path: "assets/png/calender_icon.png",
                readonly: true,
                controller: controller.wheeldateController,
                ontap: () {
                  controller.pickDate(context, controller.wheeldateController);
                },
              ),

              SizedBox(height: 0.5.h),

              customTextFeildM(
                maxlines: 3,
                "Add Note ( Optional )",
                "Write Something Here",
                controller: controller.wheelNoteController
              ),

              SizedBox(height: 1.h),

              buttonWidget("Submit Report", blackColor,
                  colors: yellowColor, onTap: () {

                    if (controller.wheelSerialNumber.text.trim().isEmpty ||
                        controller.mountedPosition6.value.trim().isEmpty ||
                        controller.damageType1.value.trim().isEmpty ||
                        controller.severity1.value.trim().isEmpty ||
                        controller.noOfDamage1.value <= 0 ||
                        controller.wheeldateController.text.trim().isEmpty) {

                      Get.snackbar(
                        "Error",
                        "Please fill all required fields",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                      return;
                    } else {
                      controller.reportWheelDamage(context);
                    }

                  }),
            ],
          ),
        );
      }),


      ],
      ),
    );
  }
}
