import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/customTextFeild.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';

class AddNewTire extends StatelessWidget {
  AddNewTire({super.key});

  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Add New Tire",
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
                    child: Center(
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
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 0.5.h,
                    children: [
                      customTextFeild(
                        "Serial Number",
                        "Enter serial number",
                        path: "assets/png/scan_icon.png",
                      ),
                      SizedBox(height: 0.5.h),
                      customTextFeild(
                        "Date of Entry",
                        "MM/DD/YYYY",
                        path: "assets/png/calender_icon.png",
                      ),
                      SizedBox(height: 0.5.h),
                      customText(
                        text: "General Info",
                        fontSize: 15.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w300,
                      ),
                      SizedBox(height: 0.5.h),
                       customDropdownField<String>(
                        title: "Select Brand",
                        hintText: "Bridgestone",
                        items: [],
                        selectedItem: controller.selectedValue,
                        onChanged: (value) {
                          controller.selectedValue = value;
                        },
                      ),
                      SizedBox(height: 0.5.h),
                      Row(
                        children: [
                          Expanded(
                            child: customDropdownField<String>(
                              title: "Tire Size",
                              hintText: "Select Size",
                              items: [],
                              selectedItem: controller.selectedValue,
                              onChanged: (value) {
                                controller.selectedValue = value;
                              },
                            ),
                          ),
                          SizedBox(width: 4.w), // spacing between the dropdowns
                          Expanded(
                            child: customDropdownField<String>(
                              title: "Ply Rating",
                              hintText: "Select Ply",
                              items: [],
                              selectedItem: controller.selectedValue,
                              onChanged: (value) {
                                controller.selectedValue = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      customDropdownField<String>(
                        title: "Tire Health",
                        hintText: "12/32 ---- 🟢 (New)",
                        items: [],
                        selectedItem: controller.selectedValue,
                        onChanged: (value) {
                          controller.selectedValue = value;
                        },
                      ),
                      SizedBox(height: 0.5.h),
                      customText(
                        text: "Tire Placement",
                        fontSize: 15.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w300,
                      ),
                      SizedBox(height: 0.5.h),
                      customDropdownField<String>(
                        title: "Status",
                        hintText: "On Vehical",
                        items: [],
                        selectedItem: controller.selectedValue,
                        onChanged: (value) {
                          controller.selectedValue = value;
                        },
                      ),
                      SizedBox(height: 0.5.h),
                      customTextFeild(
                        "Vehical Number Plate",
                        "YXU - 5689",
                      ),
                      SizedBox(height: 0.5.h),
                      customDropdownField<String>(
                        title: "Mounted Position",
                        hintText: "D2-Left-Outer",
                        items: [],
                        selectedItem: controller.selectedValue,
                        onChanged: (value) {
                          controller.selectedValue = value;
                        },
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
