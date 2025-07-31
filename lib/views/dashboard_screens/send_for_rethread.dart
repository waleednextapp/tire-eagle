import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/customTextFeild.dart';
import 'package:tire_eagle/widgets/report_rethread_dialog.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';

class SendForRethread extends StatelessWidget {
  SendForRethread({super.key});

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
            text: "Send for Retread",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 0.5.h,
                    children: [
                      customTextFeild(
                          "Serial Number",
                          "Enter serial number",
                          path: "assets/png/scan_icon.png",
                          ontap: (){
                            Get.toNamed("scan");
                          }
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
                      customDropdownField<String>(
                        title: "Retread History",
                        hintText: "1st retread",
                        items: [],
                        selectedItem: controller.selectedValue,
                        onChanged: (value) {
                          controller.selectedValue = value;
                        },
                      ),
                      SizedBox(height: 0.5.h),
                      customText(
                        text: "Retread Center",
                        fontSize: 15.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w300,
                      ),
                      SizedBox(height: 0.5.h),
                      customTextFeild(
                        "Center Name",
                        "ABC Retread Co.",
                      ),
                      SizedBox(height: 0.5.h),
                      customTextFeild(
                        "Avg. Cost",
                        "\$180",
                      ),
                      SizedBox(height: 0.5.h),
                      customDropdownField<String>(
                        title: "Pickup Logistics",
                        hintText: "Include wheel",
                        items: [],
                        selectedItem: controller.selectedValue,
                        onChanged: (value) {
                          controller.selectedValue = value;
                        },
                      ),SizedBox(height: 0.5.h),
                      customDropdownField<String>(
                        title: "Date Of Damage",
                        hintText: "July 10, 2025",
                        items: [],
                        selectedItem: controller.selectedValue,
                        onChanged: (value) {
                          controller.selectedValue = value;
                        },
                      ),SizedBox(height: 0.5.h),
                      customDropdownField<String>(
                        title: "Estimated Return Date",
                        hintText: "July 15, 2025",
                        items: [],
                        selectedItem: controller.selectedValue,
                        onChanged: (value) {
                          controller.selectedValue = value;
                        },
                      ),
                      SizedBox(height: 1.h),
                      buttonWidget("Save", blackColor,colors: yellowColor,onTap: (){
                        showRetreadDialog(context);
                      }),
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
