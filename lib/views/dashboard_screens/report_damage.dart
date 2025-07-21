import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/back_button.dart';
import '../../widgets/customTextFeild.dart';

class ReportDamage extends StatelessWidget {
  ReportDamage({super.key});
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
            text: "Add New Wheel",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.5.h),
            customText(
              text: "Your Damage Location",
              fontSize: 15.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w400,
            ),
            Container(
              width: double.infinity,
              child: Image.asset("assets/png/map.png"),
            ),
            Column(
              spacing: 0.5.h,
              children: [
                customDropdownField<String>(
                  title: "Select Damage Tire",
                  hintText: "DOT 5478 DC89",
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
                        title: "Damage Type",
                        hintText: "Puncture",
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
                        title: "Severity",
                        hintText: "Minor",
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
                customTextFeild(
                  "Date of Entry",
                  "MM/DD/YYYY",
                  path: "assets/png/calender_icon.png",
                ),
                SizedBox(height: 0.5.h),
                customTextFeild(
                  "Add Note ( Optional )",
                  "Write Something Here",
                  path: "assets/png/calender_icon.png",
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
