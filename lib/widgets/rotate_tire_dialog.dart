import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/custom_text_feild.dart'; // Assuming this is your custom input widget
import 'package:tire_eagle/widgets/rotation_complete_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void showRotateTireDialog(BuildContext context, {String? vehicleNo, String? position, String? tireType, bool? isWheel = false}) {
  final DashboardController controller = Get.find<DashboardController>();
  final TotalTireController totalTireController = Get.find<TotalTireController>();
  showDialog(
    context: context,
    barrierDismissible: true,
    builder:
        (_) => Dialog(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 0.8.h),
            customText(
              text: isWheel == false ? "Rotate Tire": "Rotate Wheel",
              fontWeight: FontWeight.w600,
              fontSize: 19.sp,
              fontFamily: "Barlow",
            ),
            SizedBox(height: 0.6.h),
            Divider(color: Colors.grey.shade300, thickness: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: lightBlueColor,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 1.h,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/png/car.png", width: 5.w),
                              SizedBox(width: 3.w),
                              customText(
                                text: vehicleNo ?? "YXU - 5689",
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                fontFamily: "Barlow",
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      text: "Current Position:",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                      color: rotateTireGreyColor,
                                      fontFamily: "Barlow",
                                    ),
                                    SizedBox(height: 0.3.h),
                                    customText(
                                      text: position ?? "F-Right",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                      fontFamily: "Barlow",
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      text: isWheel == false ? "Tire Type:": "Wheel Type",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                      color: rotateTireGreyColor,
                                      fontFamily: "Barlow",
                                    ),
                                    SizedBox(height: 0.3.h),
                                    customText(
                                      text: tireType ?? "Michelin XDE2+",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                      fontFamily: "Barlow",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),

                  // --- Dropdown using DropdownButton2 (New Position) ---
                  customText(
                    text: "New Position",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: rotateTireGreyColor,
                    fontFamily: "Barlow",
                  ),
                  SizedBox(height: 1.h),
                  Obx(
                        () => DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,

                        buttonStyleData: ButtonStyleData(
                          height: 4.5.h,
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: rotateTireTextFeildColor, width: 1.0),
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                          elevation: 0,
                        ),

                        iconStyleData: IconStyleData(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey.shade600,
                            size: 17.sp,
                          ),
                        ),

                        dropdownStyleData: DropdownStyleData(
                          offset: const Offset(4, 0),
                          maxHeight: 200,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.w),
                            color: whiteColor,
                          ),
                        ),

                        menuItemStyleData: MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          height: (4.5.h).toDouble(),
                        ),

                        value: controller.selectedPosition.value.isNotEmpty &&
                            controller.positions.contains(controller.selectedPosition.value)
                            ? controller.selectedPosition.value
                            : null,

                        hint: customText(
                          text: "Select position",
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                          fontFamily: "Barlow",
                          color: blackColor,
                        ),

                        onChanged: (String? value) {
                          if (value != null) {
                            controller.selectedPosition.value = value;
                          }
                        },

                        items: controller.positions.map((position) {
                          return DropdownMenuItem<String>(
                            value: position,
                            child: customText(
                              text: position,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Barlow",
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.5.h),

                  // --- NEW: Technician Note Text Field ---
                  customText(
                    text: "Technician note",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: rotateTireGreyColor,
                    fontFamily: "Barlow",
                  ),

                  SizedBox(height: 1.h),

                  Container(
                    height: 4.5.h, // SAME height as dropdown
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: rotateTireTextFeildColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: totalTireController.technicianNoteController,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Barlow",
                        color: blackColor,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Regular maintenance rotation",
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Barlow",
                          //color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.5.h),

                  // Using your custom_text_feild widget here

                  SizedBox(height: 1.5.h),
                  // --- END NEW SECTION ---


                  Container(
                    decoration: BoxDecoration(
                      color: rotateTireLightOrangeColor,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 1.h,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0.8.h),
                            child: Image.asset(
                              "assets/png/warning.png",
                              width: 2.5.w,
                              alignment: Alignment.topLeft,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: customText(
                              text:
                              "Warning: Steer tires should not be placed in drive positions unless specified by manufacturer.",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: rotateTireOrangeTextColor,
                              fontFamily: "Barlow",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    children: [
                      Expanded(
                        child: buttonWidget(
                          "Cancel",
                          blackColor,
                          borderColor: rotateTireTextFeildColor,
                          height: 4.5.h,
                          radius: 10.sp,
                          fontsize: 15.sp,
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: buttonWidget(
                          "Confirm Rotation",
                          whiteColor,
                          colors: greenColor,
                          height: 4.5.h,
                          radius: 10.sp,
                          fontsize: 15.sp,
                          onTap: () {

                            // --- VALIDATION START ---
                            String selectedPosition = controller.selectedPosition.value;
                            String noteText = totalTireController.technicianNoteController.text.trim();

                            if (selectedPosition.isEmpty) {
                              // Validation failed for New Position
                              Get.snackbar(
                                "Error",
                                "Please fill Position field",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white,
                              );
                              return; // Stop the process
                            }
                            // --- VALIDATION END ---

                            // Agar validation pass ho jaye, toh aage badho
                            isWheel == false ? totalTireController.updateTireRotation(context): totalTireController.updateWheelRotation(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
