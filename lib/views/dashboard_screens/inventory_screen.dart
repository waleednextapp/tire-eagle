import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/header_widget.dart';
import 'home_screen.dart';

class InventoryScreen extends StatelessWidget {
  InventoryScreen({super.key});
  final DashboardController controller = Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: whiteColor,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 7.h,
                  left: 6.w,
                  right: 6.w,
                  bottom: 2.h,
                ),
                child: headerWidget(
                  "Manage Inventory",
                      () {},
                  "Search By Serial Number",
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: customText(
                text: "Quick Actions",
                fontSize: 17.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  quickAction(
                    color: blueColor,
                    imagePath: 'assets/png/wheel_detail/rethread.png',
                    text: 'Send for Retread',
                    onTap: () {
                      Get.toNamed("rethread");
                    },
                  ),
                  quickAction(
                    color: greenColor,
                    imagePath: 'assets/png/home_screen_images/tire_icon.png',
                    text: 'Add Wheel/Tire',
                    onTap: () {
                      Get.toNamed("addnewtire");
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  quickAction(
                    color: purpleColor,
                    imagePath: 'assets/png/home_screen_images/remainder_icon.png',
                    text: 'Reminders',
                    onTap: () {
                      Get.toNamed("remainder");

                    },
                  ),
                  quickAction(
                    color: redColor,
                    imagePath: 'assets/png/home_screen_images/alert_icon.png',
                    text: 'Report Damage',
                    onTap: () {
                      Get.toNamed("reportdamage");

                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: InkWell(
                    onTap: () {
                      controller.inventorySelectedIndex.value = 1; // ✅ Fixed
                    },
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customText(
                          text: "Tires",
                          fontSize: 17.sp,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: controller.inventorySelectedIndex.value == 1
                              ? blackColor
                              : inventoryGreyColor,
                        ),
                        Container(
                          height: controller.inventorySelectedIndex.value == 1 ? 0.4.h : 0.2.h,
                          width: 43.w,
                          color: controller.inventorySelectedIndex.value == 1
                              ? yellowColor
                              : inventoryContainerColor,
                        ),
                      ],
                    )),
                  ),
                ),
                SizedBox(width: 2.w),
                Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: InkWell(
                    onTap: () {
                      controller.inventorySelectedIndex.value = 2; // ✅ Fixed
                    },
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customText(
                          text: "Wheels",
                          fontSize: 17.sp,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          color: controller.inventorySelectedIndex.value == 2
                              ? blackColor
                              : inventoryGreyColor,
                        ),
                        Container(
                          height: controller.inventorySelectedIndex.value == 2 ? 0.4.h : 0.2.h,
                          width: 43.w,
                          color: controller.inventorySelectedIndex.value == 2
                              ? yellowColor
                              : inventoryContainerColor,
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Obx(
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(controller.inventoryTabs.length, (index) {
                    bool isSelected = controller.inventoryIndexTab.value == index;
                    return Padding(
                      padding: EdgeInsets.only(right: 2.1.w),
                      child: GestureDetector(
                        onTap: () => controller.selectInventoryValue(index),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? brownColor
                                : brownColor.withAlpha(40),
                            borderRadius: BorderRadius.circular(30.sp),
                          ),
                          child: Row(
                            children: [
                              customText(
                                text: controller.inventoryTabs[index],
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

            SizedBox(height: 2.h),
            Obx(() {
              if (controller.inventorySelectedIndex.value == 1) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    children: List.generate(4, (rowIndex) {
                      return Row(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: inventoryWidget(
                              "assets/png/inventory_screen/inventory_tire1.png",
                              "YXU - 5689",
                              "Michelin XDE2+",
                              "11R22.5",
                              "22 April 2025",
                              "F-Right",
                              "DOT 5478 DC89",
                                (){
                                  Get.toNamed("tire");
                                }
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Flexible(
                            fit: FlexFit.tight,
                            child: inventoryWidget(
                              "assets/png/inventory_screen/inventory_tire1.png",
                              "YXU - 5689",
                              "Michelin XDE2+",
                              "11R22.5",
                              "22 April 2025",
                              "F-Right",
                              "DOT 5478 DC89",
                                    (){
                                  Get.toNamed("tire");
                                }
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    children: List.generate(4, (rowIndex) {
                      return Row(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: inventoryWidget(
                              "assets/png/inventory_screen/inventory_tire1.png",
                              "YXU - 5689",
                              "Michelin XDE2+",
                              "11R22.5",
                              "22 April 2025",
                              "F-Right",
                              "DOT 5478 DC89",
                                    (){
                                  Get.toNamed("wheeldetails");
                                }
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Flexible(
                            fit: FlexFit.tight,
                            child: inventoryWidget(
                              "assets/png/inventory_screen/inventory_tire1.png",
                              "YXU - 5689",
                              "Michelin XDE2+",
                              "11R22.5",
                              "22 April 2025",
                              "F-Right",
                              "DOT 5478 DC89",
                                    (){
                                  Get.toNamed("wheeldetails");
                                }
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                );
              }
            }),

          ],
        ),
      ),
    );
  }
}
Widget inventoryWidget(
    String path,
    String name,
    String model,
    String size,
    String date,
    String position,
    String serialNo,
    VoidCallback ontap,
    ){
  return Container(
    width: 42.w,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.sp),
      ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            path,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 0.4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: name,
                    fontSize: 15.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600,
                  ),
                  customText(
                    text: model,
                    fontSize: 13.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: remainderGreenColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 0.5.h,
                  ),
                  child: customText(
                    text: "In Use",
                    fontSize: 12.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 1.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: "Size",
                    fontSize: 13.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                  ),
                  customText(
                    text: size,
                    fontSize: 13.sp,
                    fontFamily: "Barlow",
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Last Date",
                    fontSize: 13.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                  ),
                  customText(
                    fontSize: 13.sp,
                    text: date,
                    fontFamily: "Barlow",
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: "Position",
                    fontSize: 13.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                  ),
                  customText(
                    text: position,
                    fontSize: 13.sp,
                    fontFamily: "Barlow",
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Serial Number",
                    fontSize: 13.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                  ),
                  customText(
                    text: serialNo,
                    fontSize: 13.sp,
                    fontFamily: "Barlow",
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          buttonWidget(
            "View Detail",
            blackColor,
            colors: yellowColor,
            height: 3.5.h,
            width: double.infinity,
            fontsize: 13.sp,
            onTap: ontap

          ),
          SizedBox(height: 1.h),
          buttonWidget(
            "Remove",
            blackColor,
            colors: customButtonColor.withOpacity(0.2),
            height: 3.5.h,
            width: double.infinity,
            fontsize: 13.sp,
            onTap: (){

            }
          ),
        ],
      ),
    ),
  );
}
