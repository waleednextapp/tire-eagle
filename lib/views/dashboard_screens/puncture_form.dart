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
                  controller: controller.punctureSerialController

                ),
                SizedBox(height: 0.5.h),
                Obx(() => customDropdownField<String>(
                  title: "Mounted Position",
                  hintText: "F-Right",
                  items: controller.mountedPositionList4,
                  selectedItem: controller.mountedPositionList4.contains(controller.mountedPosition4.value)
                      ? controller.mountedPosition4.value
                      : null,
                  onChanged: (value) {
                    controller.mountedPosition4.value = value ?? "";
                  },
                )),

                // SizedBox(height: 0.5.h),
                // customTextFeildM(
                //   "Vehical Number Plate",
                //   "YXU - 5689",
                // ),
                SizedBox(height: 0.5.h),
                customTextFeildM(
                  "Puncture",
                  "Puncture",
                    controller: controller.noOfPuncture
                ),
                SizedBox(height: 0.5.h),
                customTextFeildM(
                  "Cuts",
                  "Cuts",
                    controller: controller.noOfCuts
                ),
                SizedBox(height: 0.5.h),
                customTextFeildM(
                  "Bulge",
                  "Bulge",
                  controller: controller.noOfBulge
                ),
                SizedBox(height: 0.5.h),
                customTextFeildM(
                  "Date of Puncture",
                  "MM/DD/YYYY",
                  path: "assets/png/calender_icon.png",
                  readonly: true,
                  controller: controller.punctureDateController,
                  ontap: () {
                    controller.pickDate(context, controller.punctureDateController);
                  },
                ),

                SizedBox(height: 0.5.h),
                customTextFeildM(
                  "Cost",
                  "\$00.00",
                  controller: controller.costController
                ),
                SizedBox(height: 1.h),
          buttonWidget(
            "Save",
            blackColor,
            colors: yellowColor,
            onTap: () async {
              if (controller.punctureSerialController.text.isEmpty ||
                  controller.noOfPuncture.text.isEmpty ||
                  controller.noOfCuts.text.isEmpty ||
                  controller.noOfBulge.text.isEmpty ||
                  controller.punctureDateController.text.isEmpty ||
                  controller.costController.text.isEmpty) {

                Get.snackbar(
                  "Error",
                  "Please fill all form fields",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                );
                return;
              }

              await controller.addPuncture(context);
            },
          ),
          SizedBox(height: 5.h),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
