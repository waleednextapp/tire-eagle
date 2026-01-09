import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/utils/helper_functions.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/customTextFeild.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widgets/back_button.dart';

class AddNewTire extends StatelessWidget {
  AddNewTire({super.key});
  final GlobalKey<FormState> _newTire = GlobalKey<FormState>();
  final GlobalKey<FormState> _newWheel = GlobalKey<FormState>();
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
            text: "Add New",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                        () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(
                        children: List.generate(controller.addTab.length, (
                            index,
                            ) {
                          bool isSelected = controller.addNewTab.value == index;

                          return Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: GestureDetector(
                              onTap: () => controller.addNewToggle(index),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 1.h,
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
                                      text: controller.addTab[index],
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
                  Obx(() =>
                    controller.addNewTab.value == 0 ?
                    Form(
                      key: _newTire,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: "General Info",
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w300,
                          ),
                          SizedBox(height: 0.5.h),
                          Container(
                            height: 15.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(
                                color: textFeildBorderColor,
                                width: 0.2.w,
                              ),
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            child: Center(
                              child: Obx(() {
                                if (controller.selectedImage1.value != null) {
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12.sp),
                                        child: SizedBox.expand(
                                          child: Image.file(
                                            controller.selectedImage1.value!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0.5.h,
                                        right: 1.w,
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.selectedImage1.value = null;
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              shape: BoxShape.circle,
                                            ),
                                            padding: EdgeInsets.all(4.sp),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 18.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return InkWell(
                                  onTap: () async {
                                    await controller.uploadImage(1);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/png/gallery_icon.png", width: 8.w),
                                      SizedBox(height: 0.5.h),
                                      customText(
                                        text: "Add Photo",
                                        fontSize: 15.sp,
                                        fontFamily: "Barlow",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 0.5.h,
                            children: [
                              customTextFeildM(
                                "Customer Email Address",
                                "Enter email address",
                                controller: controller.customerEmailController,
                                validator: (value) => HelperFunction.emailValidate(value),
                              ),
                              SizedBox(height: 0.5.h),
                              customTextFeildM(
                                "Serial Number",
                                "Enter serial number",
                                controller: controller.serialNumberController,
                              ),
                              SizedBox(height: 0.5.h),
                              customTextFeildM(
                                "Date of Entry",
                                "MM/DD/YYYY",
                                path: "assets/png/calender_icon.png",
                                readonly: true,
                                controller: controller.tiredateController,
                                ontap: () {
                                  controller.pickDate(context, controller.tiredateController);
                                },
                              ),
                              SizedBox(height: 0.5.h),
                              customText(
                                text: "Tire Details",
                                fontSize: 15.sp,
                                fontFamily: "Barlow",
                                fontWeight: FontWeight.w300,
                              ),
                              SizedBox(height: 0.5.h),
                              customTextFeildM(
                                "Select Brand",
                                "Bridgestone",
                                controller: controller.tirebrandField,
                              ),
                              SizedBox(height: 0.5.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: customTextFeildM(
                                      "Tire Size",
                                      "Enter Size",
                                      controller: controller.tiresizeField,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: customTextFeildM(
                                      "Ply Rating",
                                      "Select Ply Rating",
                                      controller: controller.tireplyField,
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(height: 0.5.h),
                              // customTextFeildM(
                              //   "Tire Health",
                              //   "60 %",
                              //   controller: controller.tireHealth,
                              // ),
                              // SizedBox(height: 0.5.h),
                              // customText(
                              //   text: "Tire Placement",
                              //   fontSize: 15.sp,
                              //   fontFamily: "Barlow",
                              //   fontWeight: FontWeight.w300,
                              // ),
                              SizedBox(height: 0.5.h),
                              Obx(() => customDropdownField<String>(
                                title: "Status",
                                hintText: "On Vehicle",
                                items: controller.statusList,
                                selectedItem: controller.statusList.contains(controller.status.value)
                                    ? controller.status.value
                                    : null,
                                onChanged: (value) {
                                  controller.status.value = value ?? "";
                                },
                              )),
                              SizedBox(height: 0.5.h),
                              customTextFeildM(
                                "Vehicle Number Plate",
                                "YXU - 5689",
                                controller: controller.vehicleNumberController,
                              ),
                              SizedBox(height: 0.5.h),
                              Obx(() => customDropdownField<String>(
                                title: "Mounted Position",
                                hintText: "D2-Left-Outer",
                                items: controller.mountedPositionList2,
                                selectedItem: controller.mountedPositionList2.contains(controller.mountedPosition2.value)
                                    ? controller.mountedPosition2.value
                                    : null,
                                onChanged: (value) {
                                  controller.mountedPosition2.value = value ?? "";
                                },
                              )),
                              SizedBox(height: 1.h),
                              buttonWidget(
                                "Save",
                                blackColor,
                                colors: yellowColor,
                                onTap: () async {
                                  if (_newTire.currentState!.validate()) {
                                    if (controller.selectedImage1.value == null ||
                                        controller.customerEmailController.text.isEmpty ||
                                        controller.serialNumberController.text.isEmpty ||
                                        controller.tiredateController.text.isEmpty ||
                                        controller.tirebrandField.text.isEmpty ||
                                        controller.tiresizeField.text.isEmpty ||
                                        controller.tireplyField.text.isEmpty ||
                                        // controller.tireHealth.text.isEmpty ||
                                        controller.status.value.isEmpty ||
                                        controller.vehicleNumberController.text.isEmpty ||
                                        controller.mountedPosition2.value.isEmpty) {
                                      Get.snackbar(
                                        "Error",
                                        "Please fill all form fields",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white,
                                      );
                                      return;
                                    }

                                    await controller.addNewTire();
                                    // Get.snackbar(
                                    //   "Success",
                                    //   "Tire added successfully",
                                    //   snackPosition: SnackPosition.BOTTOM,
                                    //   backgroundColor: Colors.green,
                                    //   colorText: Colors.white,
                                    // );
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "Please correct the errors in the form",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 5.h),
                            ],
                          ),
                        ],
                      ),
                    )
                        : Form(
                      key: _newWheel,

                          child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                          customText(
                            text: "General Info",
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w300,
                          ),
                          SizedBox(height: 0.5.h),
                          Container(
                            height: 15.h,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(
                                color: textFeildBorderColor,
                                width: 0.2.w,
                              ),
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            child: Container(
                              height: 15.h,
                              width: double.infinity, // agar width bhi full chahiye
                              decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border.all(
                                  color: textFeildBorderColor,
                                  width: 0.2.w,
                                ),
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                              child: Center(
                                child: Obx(() {
                                  if (controller.selectedImage2.value != null) {
                                    return Stack(
                                      children: [
                                        // Image container fills parent
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12.sp),
                                          child: SizedBox.expand(
                                            child: Image.file(
                                              controller.selectedImage2.value!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        // Cross button
                                        Positioned(
                                          top: 0.5.h,
                                          right: 1.w,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.selectedImage2.value = null;
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black54,
                                                shape: BoxShape.circle,
                                              ),
                                              padding: EdgeInsets.all(4.sp),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 18.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }

                                  // Default icon + text
                                  return InkWell(
                                    onTap: () {
                                      controller.uploadImage(2);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/png/gallery_icon.png", width: 8.w),
                                        SizedBox(height: 0.5.h),
                                        customText(
                                          text: "Add Photo",
                                          fontSize: 15.sp,
                                          fontFamily: "Barlow",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 0.5.h,
                            children: [
                              customTextFeildM(
                                "Customer Email Address",
                                "Enter email address",
                                controller: controller.customerEmailControllerWheel,
                                validator: (value) => HelperFunction.emailValidate(value),
                              ),
                              SizedBox(height: 0.5.h),
                              customTextFeildM(
                                  "Serial Number",
                                  "Enter serial number",
                                  controller: controller.serialNumberControllerWheel
                              ),
                              SizedBox(height: 0.5.h),
                              customTextFeildM(
                                "Date of Entry",
                                "MM/DD/YYYY",
                                path: "assets/png/calender_icon.png",
                                readonly: true,
                                controller: controller.tiredateController2,
                                ontap: () {
                                  controller.pickDate(context, controller.tiredateController2);
                                },
                              ),

                              SizedBox(height: 0.5.h),
                              customText(
                                text: "Wheel Details",
                                fontSize: 15.sp,
                                fontFamily: "Barlow",
                                fontWeight: FontWeight.w300,
                              ),
                              SizedBox(height: 0.5.h),
                              customTextFeildM(
                                "Select Material",
                                "Aluminum",
                                controller: controller.wheelMaterialField,
                              ),

                              SizedBox(height: 0.5.h),
                              customTextFeildM(
                                "Wheel Size",
                                "12.5R20",
                                controller: controller.wheelSizeField,
                              ),
                              SizedBox(height: 0.5.h),
                              customTextFeildM(
                                "Wheel Condition",
                                "9.8",
                                controller: controller.wheelConditionField,
                              ),
                              SizedBox(height: 0.5.h),
                              customText(
                                text: "Wheel Placement",
                                fontSize: 15.sp,
                                fontFamily: "Barlow",
                                fontWeight: FontWeight.w300,
                              ),
                              SizedBox(height: 0.5.h),
                              Obx(() => customDropdownField<String>(
                                title: "Status",
                                hintText: "On Vehicle",
                                items: controller.wheelStatusList,
                                selectedItem: controller.wheelStatusList.contains(controller.wheelStatus.value)
                                    ? controller.wheelStatus.value
                                    : null,
                                onChanged: (value) {
                                  controller.wheelStatus.value = value ?? "";
                                },
                              )),

                              SizedBox(height: 0.5.h),
                              customTextFeildM(
                                "Vehical Number Plate",
                                "YXU - 5689",
                                controller: controller.vehicleNumberControllerWheel
                              ),
                              SizedBox(height: 0.5.h),
                              customDropdownField<String>(
                                title: "Mounted Position",
                                hintText: "D2-Left-Outer",
                                items: controller.mountedPositionList3,
                                selectedItem: controller.mountedPositionList3.contains(controller.mountedPosition3.value)
                                    ? controller.mountedPosition3.value
                                    : null,
                                onChanged: (value) {
                                  controller.mountedPosition3.value = value ?? "";
                                },),
                              SizedBox(height: 1.h),
                              buttonWidget(
                                "Save",
                                blackColor,
                                colors: yellowColor,
                                onTap: () async {
                                  if (_newWheel.currentState!.validate()) {
                                    if (controller.selectedImage2.value == null ||
                                        controller.customerEmailControllerWheel.text.isEmpty ||
                                        controller.serialNumberControllerWheel.text.isEmpty ||
                                        controller.tiredateController2.text.isEmpty ||
                                        controller.wheelMaterialField.text.isEmpty ||
                                        controller.wheelSizeField.text.isEmpty ||
                                        controller.wheelConditionField.text.isEmpty ||
                                        controller.wheelStatus.value.isEmpty ||
                                        controller.vehicleNumberControllerWheel.text.isEmpty ||
                                        controller.mountedPosition3.value.isEmpty) {



                                      Get.snackbar(
                                        "Error",
                                        "Please fill all form fields",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white,
                                      );
                                      return;
                                    }

                                    await controller.addNewWheel();
                                    // Get.snackbar(
                                    //   "Success",
                                    //   "Tire added successfully",
                                    //   snackPosition: SnackPosition.BOTTOM,
                                    //   backgroundColor: Colors.green,
                                    //   colorText: Colors.white,
                                    // );
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "Please correct the errors in the form",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 5.h),
                            ],
                          ),
                                                ],
                                              ),
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
