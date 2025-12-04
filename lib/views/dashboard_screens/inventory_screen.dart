import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/components/common_image_view.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_screens/total_wheels.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/header_widget.dart';
import 'fleet_home_screen.dart';

class InventoryScreen extends StatelessWidget {
  InventoryScreen({super.key});
  final DashboardController controller = Get.find<DashboardController>();
  final TotalTireController totalTireController = Get.find<TotalTireController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await totalTireController.GetAllTireInventory();
          await totalTireController.GetAllWheelInventory();
        },
        builder: (BuildContext context, Widget child, IndicatorController controller) {
            return child;
          },

          // return Stack(
          //   children: [
          //     child, // Your scrollable content
          //     // Optional: show custom loader only if you want
          //     if (controller.isLoading || controller.value > 0)
          //       Positioned(
          //         top: 16,
          //         left: 0,
          //         right: 0,
          //         child: Opacity(
          //           opacity: controller.value.clamp(0.0, 1.0),
          //           // Fade in effect
          //           child: Container(
          //             alignment: Alignment.center,
          //             height: 30,
          //             child: SizedBox.shrink(), // Hide spinner completely
          //           ),
          //         ),
          //       ),
          //   ],
          // );
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(), // Allow pull even if content < screen
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- Your existing widgets ----------------
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
                    controller: totalTireController.searchController,
                    onChanged: (value) async {
                      if(controller.inventorySelectedIndex.value == 1) {
                        if (value
                            .trim()
                            .isEmpty) {
                          // agar empty hai to full list reload
                          await totalTireController.GetAllTireInventory();
                        } else {
                          // filter by search value
                          await totalTireController.GetAllTireInventory(
                              search: value.trim());
                        }
                      }
                      else{
                        if (value
                            .trim()
                            .isEmpty) {
                          // agar empty hai to full list reload
                          await totalTireController.GetAllWheelInventory();
                        } else {
                          // filter by search value
                          await totalTireController.GetAllWheelInventory(
                              search: value.trim());
                        }
                      }
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: InkWell(
                      onTap: () async {
                        controller.inventorySelectedIndex.value = 1;
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
                      onTap: () async {
                        controller.inventorySelectedIndex.value = 2;
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

              // ---------------- Tabs & Grid content ----------------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Obx(
                      () => Row(
                    children: List.generate(controller.inventoryTabs.length, (index) {
                      bool isSelected = controller.inventoryIndexTab.value == index;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: index == controller.inventoryTabs.length - 1 ? 0 : 2.w),
                          child: InkWell(
                            onTap: () async {
                              controller.selectInventoryValue(index);

                              if (index == 1) {
                                await Get.toNamed("disposedhistory");
                                controller.inventoryIndexTab.value = 0;
                              }
                            },
                            borderRadius: BorderRadius.circular(30.sp),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 0.9.h),
                              decoration: BoxDecoration(
                                color: isSelected ? brownColor : brownColor.withAlpha(40),
                                borderRadius: BorderRadius.circular(30.sp),
                              ),
                              alignment: Alignment.center,
                              child: customText(
                                text: controller.inventoryTabs[index],
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? whiteColor : brownColor,
                              ),
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
                  // ---------- TIRE GRID ----------
                  if (totalTireController.isLoadingTireInventory.value) {
                    return SizedBox(
                      height: 60.h,
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: CircularProgressIndicator(color: yellowColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return totalTireController.getTireInventory.value?.data?.items?.isEmpty ?? true
                      ? Center(
                    child: customText(
                      text: "No Tires In Inventory",
                      fontSize: 15.sp,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  )
                      : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: totalTireController.getTireInventory.value?.data?.items?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3.w,
                        childAspectRatio: 0.5,
                      ),
                      itemBuilder: (context, index) {
                        final item = totalTireController.getTireInventory.value?.data?.items?[index];
                        return inventoryWidget(
                          item?.imageUrl ?? '',
                          item?.vehicalNumber ?? '',
                          item?.brand ?? '',
                          item?.tireSize ?? '',
                          formatDate(item?.updatedAt ?? ''),
                          item?.mountedPosition ?? '',
                          item?.serialNumber ?? '',
                          item?.status ?? '',
                              () {
                            Get.toNamed("tire");
                          },
                        );
                      },
                    ),
                  );
                } else {
                  // ---------- WHEEL GRID ----------
                  if (totalTireController.isLoadingWheelInventory.value) {
                    return SizedBox(
                      height: 60.h,
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: CircularProgressIndicator(color: yellowColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return totalTireController.getWheelInventory.value?.data?.items?.isEmpty ?? true
                      ? Center(
                    child: customText(
                      text: "No Wheel In Inventory",
                      fontSize: 15.sp,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  )
                      : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: totalTireController.getWheelInventory.value?.data?.items?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3.w,
                        childAspectRatio: 0.5,
                      ),
                      itemBuilder: (context, index) {
                        final item = totalTireController.getWheelInventory.value?.data?.items?[index];
                        return inventoryWidget(
                          item?.imageUrl ?? '',
                          item?.vehicalNumber ?? '',
                          item?.material ?? '',
                          item?.wheelSize ?? '',
                          formatDate(item?.updatedAt ?? ''),
                          item?.mountedPosition ?? '',
                          item?.serialNumber ?? '',
                          item?.status ?? '',
                              () {
                            Get.toNamed("wheeldetails");
                          },
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
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
    String status,
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
          imageWidget(path),
          // CommonImageView(
          //   url: path,
          //   height: 10.h,
          //   fit: BoxFit.contain,
          // ),
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
                    text: status,
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

Widget imageWidget(String? path) {
  return SizedBox(
    height: 13.h,
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.sp),
      child: path != null && path.isNotEmpty
          ? CachedNetworkImage(
        imageUrl: path,
        fit: BoxFit.contain,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(color: Colors.white),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/png/placeholder.png',
          fit: BoxFit.contain,
        ),
      )
          : Image.asset(
        'assets/png/placeholder.png',
        fit: BoxFit.contain,
      ),
    ),
  );
}
