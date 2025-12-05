import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dismount_controller.dart'; // Import the new controller
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_text_feild.dart'; // Assuming custom_text_feild exists

class SelectDismountReason extends StatelessWidget {
  const SelectDismountReason({super.key});

  @override
  Widget build(BuildContext context) {
    final isWheel = Get.arguments;
    // Initialize the controller
    final DismountController controller = Get.put(DismountController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Select Dismount Reason",
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
                    child: dismountProgressWidget(),
                  ),
                  Divider(color: Colors.grey, thickness: 0.3),

                  // Use Obx to rebuild when selection changes
                  Obx(() => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Low Tread (Index 0)
                        dismountBodyWidget(
                          controller: controller,
                          index: 0,
                          path: "assets/png/dismount_images/tool.png",
                          title: "Low Tread",
                          msg: "Tread below safety\nthreshold",
                        ),
                        SizedBox(width: 4.w),
                        // Damaged (Index 1)
                        dismountBodyWidget(
                          controller: controller,
                          index: 1,
                          path: "assets/png/dismount_images/alert.png",
                          title: "Damaged",
                          msg: "Significant tire damage",
                        ),
                      ],
                    ),
                  )),

                  Obx(() => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Vehicle Service (Index 2)
                        dismountBodyWidget(
                          controller: controller,
                          index: 2,
                          path: "assets/png/dismount_images/van.png",
                          title: "Vehicle Service",
                          msg: "Removed during\nmaintenance",
                        ),
                        SizedBox(width: 4.w),
                        // Rotation (Index 3)
                        dismountBodyWidget(
                          controller: controller,
                          index: 3,
                          path: "assets/png/dismount_images/recycle.png",
                          title: "Rotation",
                          msg: "Regular tire rotation",
                        ),
                      ],
                    ),
                  )),

                  Obx(() => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // End of Life (Index 4)
                        dismountBodyWidget(
                          controller: controller,
                          index: 4,
                          path: "assets/png/dismount_images/bin.png",
                          title: "End of Life",
                          msg: "Tread below safety\nthreshold",
                        ),
                        SizedBox(width: 4.w),
                        // Other (Index 5)
                        dismountBodyWidget(
                          controller: controller,
                          index: 5,
                          path: "assets/png/dismount_images/add.png",
                          title: "Other",
                          msg: "Custom reason",
                        ),
                      ],
                    ),
                  )),

                  // --- Conditional Text Field for 'Other' ---
                  Obx(() {
                    if (controller.isOtherSelected) {
                      return Padding(
                        padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),
                            // Using the customTextFeild for consistent look
                            // customTextFeild(
                            //   controller: controller.otherReasonController,
                            //   hintText: "Enter custom dismount reason",
                            //   height: 4.5.h,
                            // ),
                            customTextFeild('Specify Reason', 'Tyre got bursted'),
                            SizedBox(height: 1.h),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  // ------------------------------------------

                  SizedBox(height: 2.h),
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
                      onTap: (){
                        // Add validation here: ensure a reason is selected, and if 'Other', the text field is filled.
                        if (controller.selectedIndex.value == -1) {
                          Get.snackbar("Error", "Please select a dismount reason to continue.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                          return;
                        }
                        if (controller.isOtherSelected && controller.otherReasonController.text.trim().isEmpty) {
                          Get.snackbar("Error", "Please specify the custom reason.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                          return;
                        }

                        Get.toNamed("assignstoragelocation",arguments: isWheel);
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

// ... (dismountProgressWidget, progressContainerWidget, dashContainer remain unchanged)

Widget dismountBodyWidget({
  required DismountController controller,
  required int index,
  required String path,
  required String title,
  required String msg,
}) {
  bool isSelected = controller.selectedIndex.value == index;

  return GestureDetector(
    onTap: () => controller.selectReason(index),
    child: Container(
      width: 42.w,
      height: 16.7.h,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(
          width: isSelected ? 0.4.w : 0.1.w, // Thicker border if selected
          color: isSelected ? blueBorderColor : textFeildBorderColor, // Blue border if selected
        ),
        // Add subtle shadow for selected state if desired
        boxShadow: isSelected ? [
          BoxShadow(
            color: lightBlueColor.withOpacity(0.3),
            blurRadius: 5,
          )
        ] : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 4.5.h,
            width: 4.5.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: dismountContainerColor,
            ),
            child: Center(
              child: Image.asset(
                path,
                height: 2.h,
                width: 2.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 0.5.h),
          customText(
            text: title,
            fontSize: 15.sp,
            fontFamily: "Barlow",
            fontWeight: FontWeight.w500,
          ),
          customText(
            text: msg,
            fontSize: 13.sp,
            fontFamily: "Barlow",
            fontWeight: FontWeight.w700,
            color: dismountGreyColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

// ... (dismountProgressWidget, progressContainerWidget, dashContainer remain unchanged)
Widget dismountProgressWidget({Color? containerColor,Color? textColor, Color? containerColor3, Color? textColor3,Color? centerContainerColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      progressContainerWidget(1, blackColor, yellowColor),
      SizedBox(width: 4.w),
      dashContainer(yellowColor),
      SizedBox(width: 4.w),
      progressContainerWidget(2, textColor ?? dismountGreyColor, containerColor ?? rotateTireTextFeildColor),
      SizedBox(width: 4.w),
      dashContainer(centerContainerColor ?? rotateTireTextFeildColor),
      SizedBox(width: 4.w),
      progressContainerWidget(3, textColor3 ?? dismountGreyColor, containerColor3 ?? rotateTireTextFeildColor),
    ],
  );
}

Widget progressContainerWidget(int num, Color color, Color containerColor) {
  return Container(
    width: 7.w,
    height: 7.w,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: containerColor,
    ),
    alignment: Alignment.center,
    child: customText(
      text: "$num",
      fontSize: 13.sp,
      fontFamily: "Barlow",
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );
}

Widget dashContainer(Color color) {
  return Container(
    width: 10.w,
    height: 0.5.h,
    decoration: BoxDecoration(color: color),
  );
}

// Widget dismountBodyWidget(String path, String title, String msg) {
//   return Container(
//     width: 42.w,
//     height: 16.h,
//     padding: EdgeInsets.symmetric(vertical: 2.h),
//     decoration: BoxDecoration(
//       color: whiteColor,
//       borderRadius: BorderRadius.circular(12.sp),
//       border: Border.all(
//         width: 0.1.w,
//         color: textFeildBorderColor,
//       ),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           height: 4.5.h,
//           width: 4.5.h,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: dismountContainerColor,
//           ),
//           child: Center(
//             child: Image.asset(
//               path,
//               height: 2.h,
//               width: 2.h,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         SizedBox(height: 1.h),
//         customText(
//           text: title,
//           fontSize: 15.sp,
//           fontFamily: "Barlow",
//           fontWeight: FontWeight.w500,
//         ),
//         customText(
//           text: msg,
//           fontSize: 13.sp,
//           fontFamily: "Barlow",
//           fontWeight: FontWeight.w700,
//           color: dismountGreyColor,
//           textAlign: TextAlign.center,
//         ),
//       ],
//     ),
//   );
// }
