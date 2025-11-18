import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/widgets/report_dialog.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/customTextFeild.dart';

class PunctureForm extends StatelessWidget {
  PunctureForm({super.key});
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
            text: "Puncture",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 0.5.h,
              children: [
                customTextFeildM(
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
                  hintText: "D2-Outer-Left",
                  items: [],
                  selectedItem: controller.selectedValue,
                  onChanged: (value) {
                    controller.selectedValue = value;
                  },
                ),
                SizedBox(height: 0.5.h),
                customTextFeildM(
                  "Vehical Number Plate",
                  "YXU - 5689",
                ),
                SizedBox(height: 0.5.h),
                customTextFeildM(
                  "Puncture",
                  "Puncture",
                ),
                SizedBox(height: 0.5.h),
                customTextFeildM(
                  "Cuts",
                  "Cuts",
                ),
                SizedBox(height: 0.5.h),
                customTextFeildM(
                  "Bulge",
                  "Bulge",
                ),
                SizedBox(height: 0.5.h),
                customTextFeildM(
                  "Date of Puncture",
                  "Select date",
                ),

                SizedBox(height: 0.5.h),
                customTextFeildM(
                  "Cost",
                  "\$00.00",
                ),
                SizedBox(height: 1.h),
                buttonWidget("Save", blackColor,colors: yellowColor,onTap: (){
                  reportDialog(context,isPuncture: true);
                }),
                SizedBox(height: 5.h),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
