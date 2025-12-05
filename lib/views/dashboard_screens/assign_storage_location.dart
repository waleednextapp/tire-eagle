import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/views/dashboard_screens/select_dismount_reason.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/dismount_controller.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';

class AssignStorageLocation extends StatelessWidget {
  AssignStorageLocation({super.key});

  final DismountController controller = Get.find<DismountController>();
  final TotalTireController totalTireController = Get.find<TotalTireController>();

  @override
  Widget build(BuildContext context) {
    final isWheel = Get.arguments;
    // Controller ko use karne ke liye, hum Obx ka use karenge

    // Dismount Reason ko yahan fetch kar lete hain
    final String dismountReason = controller.getSelectedDismountReason();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Assign Storage Location",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: dismountProgressWidget(containerColor: yellowColor, textColor: blackColor),
                  ),
                  Divider(color: Colors.grey, thickness: 0.3),
                  SizedBox(height: 1.h),
                  Center(
                    child: customText(
                      text: isWheel == false? "Where should this tire be stored after dismount?": "Where should this wheel be stored after dismount?",
                      fontSize: 15.sp,
                      fontFamily: "Barlow",
                      fontWeight: FontWeight.w500,
                      color: textBrownColor,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      children: [
                        // --- LOCATION TILES MADE SELECTABLE USING OBX ---
                        Obx(() => locationTile(
                            title: "Main Warehouse",
                            subtitle: "Bay A-12",
                            iconPath: "assets/png/dismount_images/house.png",
                            isSelected: controller.selectedWarehouseIndex.value == 0,
                            onTap: () {
                              controller.selectedWarehouseIndex.value = 0;
                            })),
                        SizedBox(height: 1.h),
                        Obx(() => locationTile(
                            title: "Repair Shop",
                            subtitle: "Service Area",
                            iconPath: "assets/png/dismount_images/tool.png",
                            isSelected: controller.selectedWarehouseIndex.value == 1,
                            onTap: () {
                              controller.selectedWarehouseIndex.value = 1;
                            })),
                        SizedBox(height: 1.h),

                        Obx(() => locationTile(
                            title: "Recycling Center",
                            subtitle: "Bay A-12",
                            iconPath: "assets/png/dismount_images/recycle.png",
                            isSelected: controller.selectedWarehouseIndex.value == 2,
                            onTap: () {
                              controller.selectedWarehouseIndex.value = 2;
                            })),
                        SizedBox(height: 1.h),
                        Obx(() => locationTile(
                            title: "Old Warehouse",
                            subtitle: "Bay A-12",
                            iconPath: "assets/png/dismount_images/trolly.png",
                            isSelected: controller.selectedWarehouseIndex.value == 3,
                            onTap: () {
                              controller.selectedWarehouseIndex.value = 3;
                            })),
                        SizedBox(height: 1.h),

                        // --- TIRE INFORMATION CONTAINER ---
                        Container(
                          decoration: BoxDecoration(
                            color: lightBlueColor,
                            border: Border.all(
                              color: textFeildBorderColor,
                              width: 0.3.w,
                            ),
                            borderRadius: BorderRadius.circular(12.sp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                  text: isWheel == false ? "Tire Information" : "Wheel Information",
                                  fontSize: 15.sp,
                                  fontFamily: "Barlow",
                                  fontWeight: FontWeight.w500,
                                  color: textBrownColor,
                                ),
                                SizedBox(height: 0.5.h),
                                tireInfromation("ID:", isWheel== false ? totalTireController.getTireByIdModel.value?.data?.vehicalNumber ?? '':totalTireController.getWheelByIdModel.value?.data?.vehicalNumber ?? ''),
                                tireInfromation(isWheel == false? "Model:" : "Material:", isWheel==false ? totalTireController.getTireByIdModel.value?.data?.brand ?? '':totalTireController.getWheelByIdModel.value?.data?.material ?? ''),
                                // 💡 Dismount Reason ko switch case function se liya
                                tireInfromation("Dismount Reason:", dismountReason)
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
          ),

          // Bottom fixed container
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, -2),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 0.5.h),
                SizedBox(
                  width: double.infinity,
                  child: buttonWidget(
                      "Continue",
                      whiteColor,
                      fontsize: 15.sp,
                      colors: brownColor,
                      height: 4.7.h,
                      radius: 12.sp,
                      fontfaimly: 'Roboto',
                      fontweight: FontWeight.w600,
                      onTap: () {
                        // 💡 Validation: Check if a location is selected (index != -1)
                        if (controller.selectedWarehouseIndex.value == -1) {
                          Get.snackbar("Error", "Please select a storage location.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                          return;
                        }
                        isWheel== false ?
                        controller.DismountTire(context,isWheel: isWheel):
                        controller.DismountWheel(context,isWheel: isWheel);
                        // Get.toNamed("assignstoragelocationone");
                      }
                  ),
                ),
                SizedBox(height: 1.5.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// NOTE: locationTile and tireInfromation widgets remain the same as provided by you.
Widget locationTile({
  required String title,
  required String subtitle,
  required String iconPath,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 9.h, // 👈 your desired fixed height
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(
          color: isSelected ? blueBorderColor : textFeildBorderColor,
          width: 0.3.w,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // 👈 vertically center items
        children: [
          // Circle icon
          Container(
            height: 6.h,
            width: 6.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? lightblueBorderColor : dismountContainerColor,
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                height: 2.h,
                width: 2.h,
                fit: BoxFit.contain,
                color: isSelected ? blueBorderColor : Colors.black,

              ),
            ),
          ),
          SizedBox(width: 4.w),

          // Text Column
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 👈 center vertically inside column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: title,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: "Barlow",
                ),
                customText(
                  text: subtitle,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: dismountGreyColor,
                  fontFamily: "Barlow",
                ),
              ],
            ),
          ),

          // Selection circle
          isSelected
              ? Container(
            height: 2.8.h,
            width: 2.8.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(
                color: blueBorderColor,
                width: 0.6.w,
              ),
            ),
            child: Center(
              child: Container(
                height: 2.h,
                width: 2.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          )
              : Container(
            height: 2.8.h,
            width: 2.8.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: rotationBorderColor,
                width: 0.3.w,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
Widget tireInfromation(String title, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      customText(
        text: title,
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
        color: rotateTireGreyColor,
        fontFamily: "Barlow",
      ),
      customText(
        text: text,
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
        color: blackColor,
        fontFamily: "Barlow",
      ),
    ],
  );
}

