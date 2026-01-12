import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/customTextFeild.dart';
import 'package:tire_eagle/widgets/report_rethread_dialog.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';

class SendForRethread extends StatelessWidget {
  SendForRethread({super.key});

  final DashboardController controller = Get.find<DashboardController>();
  final TotalTireController tireController = Get.find<TotalTireController>();

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
            text: "Send for Retread",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(onTap: (){
          Get.back();
          controller.isTire.value = false;
        }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.isTire.value) {
                  // Prefill with tire serial number
                  tireController.serialController.text = tireController.getTireByIdModel.value?.data?.serialNumber ?? "";
                  return customTextFeildM(
                    "Serial Number",
                    "Enter serial number",
                    readonly: true,
                    controller: tireController.serialController,
                  );
                } else {
                  // Clear the controller when isTire is false
                  tireController.serialController.clear();
                  return customTextFeildM(
                    "Serial Number",
                    "Enter serial number",
                    controller: controller.rethreadSerialNo,
                  );
                }
              }),
              SizedBox(height: 0.5.h,),
              Obx(
                    () => customDropdownField<String>(
                  title: "Mounted Position",
                  hintText: "F-Right",
                  items: controller.mountedPositionList7,
                  selectedItem: controller.mountedPositionList7.contains(controller.mountedPosition7.value)
                      ? controller.mountedPosition7.value
                      : null,
                  onChanged: (value) {
                    controller.mountedPosition7.value = value ?? "";
                  },
                ),
              ),

              SizedBox(height: 0.5.h,),

              // Mounted Position Dropdown
              // Obx(() => customDropdownField<String>(
              //   title: "Mounted Position",
              //   hintText: "D2-Left-Outer",
              //   items: controller.mountedPositionList,
              //   selectedItem: controller.mountedPositionList
              //       .contains(controller.mountedPosition.value)
              //       ? controller.mountedPosition.value
              //       : null,
              //   onChanged: (value) {
              //     controller.mountedPosition.value = value ?? "";
              //   },
              // )),

              // Tire Health Dropdown
              // Obx(() => customDropdownField<String>(
              //   title: "Tire Health",
              //   hintText: "12/32 ---- 🟢 (New)",
              //   items: controller.tireHealthList,
              //   selectedItem: controller.tireHealthList
              //       .contains(controller.TireHealth.value)
              //       ? controller.TireHealth.value
              //       : null,
              //   onChanged: (value) {
              //     controller.TireHealth.value = value ?? "";
              //   },
              // )),

              // Rethread History Dropdown
              // Obx(() => customDropdownField<String>(
              //   title: "Rethread History",
              //   hintText: "1st retread",
              //   items: controller.rethreadHistoryList,
              //   selectedItem: controller.rethreadHistoryList
              //       .contains(controller.RethreadHistory.value)
              //       ? controller.RethreadHistory.value
              //       : null,
              //   onChanged: (value) {
              //     controller.RethreadHistory.value = value ?? "";
              //   },
              // )),
              SizedBox(height: 0.5.h),

              customText(
                text: "Rethread Center",
                fontSize: 15.sp,
                fontFamily: "Barlow",
                fontWeight: FontWeight.w300,

              ),
              SizedBox(height: 0.5.h),

              customTextFeildM("Center Name", "ABC Retread Co.", controller: controller.rethreadCenterName),
              SizedBox(height: 0.5.h),
              customTextFeildM("Avg. Cost", "\$180", controller: controller.rethreadAvgCost),
              SizedBox(height: 0.5.h),

              // Pickup Logistics Dropdown
              customTextFeildM(
                "Pickup Logistics",
                "Description",
                controller: controller.rethreadPickupLogistics
              ),
              SizedBox(height: 0.5.h),

              // Date Of Damage Dropdown
              customTextFeildM(
                "Date of Damage",
                "MM/DD/YYYY",
                path: "assets/png/calender_icon.png",
                readonly: true,
                controller: controller.rethreadDateofDamage,
                ontap: () {
                  controller.pickDate(context, controller.rethreadDateofDamage);
                },
              ),
              SizedBox(height: 0.5.h),

              // Estimated Return Date Dropdown
              customTextFeildM(
                "Estimated Return Date",
                "MM/DD/YYYY",
                path: "assets/png/calender_icon.png",
                readonly: true,
                controller: controller.rethreadReturnDate,
                ontap: () {
                  controller.pickDate(context, controller.rethreadReturnDate);
                },
              ),
              SizedBox(height: 1.h),

              buttonWidget(
                "Save",
                blackColor,
                colors: yellowColor,
                onTap: () async {
                  // If isTire is false, use user input controller
                  if (controller.isTire.value == false) {
                    if (
                    controller.rethreadSerialNo.text.isEmpty ||
                        controller.mountedPosition7.value.isEmpty ||
                        controller.rethreadCenterName.text.isEmpty ||
                        controller.rethreadAvgCost.text.isEmpty ||
                        controller.rethreadPickupLogistics.text.isEmpty ||
                        controller.rethreadDateofDamage.text.isEmpty ||
                        controller.rethreadReturnDate.text.isEmpty
                    ) {
                      Get.snackbar(
                        "Error",
                        "Please fill all form fields",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: whiteColor,
                      );
                      return;
                    }
                  }
                  // If isTire is true, use the tire's serial number from controller
                  else {
                    // Pre-fill the serial number only if the field is empty
                    if (controller.rethreadSerialNo.text.isEmpty) {
                      controller.rethreadSerialNo.text = tireController.getTireByIdModel.value?.data?.serialNumber ?? "";
                    }

                    if (
                    controller.mountedPosition7.value.isEmpty ||
                        controller.rethreadCenterName.text.isEmpty ||
                        controller.rethreadAvgCost.text.isEmpty ||
                        controller.rethreadPickupLogistics.text.isEmpty ||
                        controller.rethreadDateofDamage.text.isEmpty ||
                        controller.rethreadReturnDate.text.isEmpty
                    ) {
                      Get.snackbar(
                        "Error",
                        "Please fill all form fields",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: whiteColor,
                      );

                      // Clear the serial number if you want to reset after error
                      controller.rethreadSerialNo.clear();
                      return;
                    }
                    controller.isTire.value = false;
                  }

print("hi iam here ${controller.isTire.value}");
                  // Finally, call the send method
                  await controller.sendForRethread(context);
                },
              ),


              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
