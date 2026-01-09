import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_screens/total_wheels.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/header_widget.dart';

class InventoryScreen extends StatelessWidget {
  InventoryScreen({super.key});
  final DashboardController controller = Get.find<DashboardController>();
  final TotalTireController totalTireController = Get.find<TotalTireController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRefreshIndicator(
        onRefresh: () async {
          // Both list ko first page se reload karein
          await totalTireController.GetAllTireInventory(page: 1);
          await totalTireController.GetAllWheelInventory(page: 1);
        },
        // Pull-to-refresh builder is simple, as required.
        builder: (BuildContext context, Widget child, IndicatorController indicatorController) {
          return child;
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(), // Allow pull even if content < screen
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- Header and Search ----------------
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
                        // Tire Search Logic (Always starts from page 1)
                        await totalTireController.GetAllTireInventory(search: value.trim(), page: 1);
                      }
                      else{
                        // Wheel Search Logic (Always starts from page 1)
                        await totalTireController.GetAllWheelInventory(search: value.trim(), page: 1);
                      }
                    },
                  ),
                ),
              ),

              // ---------------- Tab Selection (Tires/Wheels) ----------------
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: InkWell(
                      onTap: () async {
                        controller.inventorySelectedIndex.value = 1;
                        // Hamesha page 1 se load karein jab tab switch ho
                        if (totalTireController.getTireInventory.value?.data?.items?.isEmpty ?? true) {
                          await totalTireController.GetAllTireInventory(page: 1);
                        }
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
                        // Hamesha page 1 se load karein jab tab switch ho
                        if (totalTireController.getWheelInventory.value?.data?.items?.isEmpty ?? true) {
                          await totalTireController.GetAllWheelInventory(page: 1);
                        }
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

              // ---------------- Secondary Tabs ----------------
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

              // ---------------- Grid Content (Tire/Wheel) ----------------
              Obx(() {
                if (controller.inventorySelectedIndex.value == 1) {
                  // ---------- TIRE GRID (Fixed List) ----------
                  final items = totalTireController.getTireInventory.value?.data?.items ?? [];

                  // 💡 NEW LOGIC: Show Centered Loader OR Empty State OR Grid View
                  if (totalTireController.isLoadingTireInventory.value) {
                    return _buildLoadingIndicator(); // Full-screen centered loader
                  }

                  // Empty State (If loading is complete and list is empty)
                  if (items.isEmpty) {
                    return _buildEmptyState("No Tires Found In Inventory");
                  }

                  // Display Grid View
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(), // Handled by SingleChildScrollView
                          itemCount: items.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 3.w,
                            childAspectRatio: 0.5,
                          ),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return inventoryWidget(
                                item.imageUrl ?? '',
                                item.vehicalNumber ?? '',
                                item.brand ?? '',
                                item.tireSize ?? '',
                                formatDate(item.updatedAt),
                                item.mountedPosition ?? '',
                                item.serialNumber ?? '',
                                item.status ?? '',
                                    () {
                                  Get.toNamed("tire");
                                },
                                ontapTwice: (){
                                  totalTireController.deleteTire(item.serialNumber ?? '');
                                }
                            );
                          },
                        ),
                      ),

                      // 💡 PAGINATION CONTROLS FOR TIRE
                      _buildPaginationControls(
                        currentPage: totalTireController.currentTirePage.value,
                        totalPages: totalTireController.totalTirePages.value,
                        hasPrevPage: totalTireController.currentTirePage.value > 1,
                        hasNextPage: totalTireController.hasNextTirePage.value,
                        onPrev: totalTireController.loadPrevTirePage,
                        onNext: totalTireController.loadNextTirePage,
                        isLoading: totalTireController.isLoadingTireInventory.value,
                      ),
                    ],
                  );
                } else {
                  // ---------- WHEEL GRID (Fixed List) ----------
                  final items = totalTireController.getWheelInventory.value?.data?.items ?? [];

                  // 💡 NEW LOGIC: Show Centered Loader OR Empty State OR Grid View
                  if (totalTireController.isLoadingWheelInventory.value) {
                    return _buildLoadingIndicator(); // Full-screen centered loader
                  }

                  // Empty State
                  if (items.isEmpty) {
                    return _buildEmptyState("No Wheels Found In Inventory");
                  }

                  // Display Grid View
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 3.w,
                            childAspectRatio: 0.5,
                          ),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return inventoryWidget(
                                item.imageUrl ?? '',
                                item.vehicalNumber ?? '',
                                item.material ?? '',
                                item.wheelSize ?? '',
                                formatDate(item.updatedAt),
                                item.mountedPosition ?? '',
                                item.serialNumber ?? '',
                                item.status ?? '',
                                    () {
                                  Get.toNamed("wheeldetails");
                                },
                                ontapTwice: (){
                                  totalTireController.deleteWheel(item.serialNumber ?? '');
                                }
                            );
                          },
                        ),
                      ),

                      // 💡 PAGINATION CONTROLS FOR WHEEL
                      _buildPaginationControls(
                        currentPage: totalTireController.currentWheelPage.value,
                        totalPages: totalTireController.totalWheelPages.value,
                        hasPrevPage: totalTireController.currentWheelPage.value > 1,
                        hasNextPage: totalTireController.hasNextWheelPage.value,
                        onPrev: totalTireController.loadPrevWheelPage,
                        onNext: totalTireController.loadNextWheelPage,
                        isLoading: totalTireController.isLoadingWheelInventory.value,
                      ),
                    ],
                  );
                }
              }),
              SizedBox(height: 5.h), // Extra space at the bottom of the scroll view
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- HELPER WIDGETS FOR PAGINATION AND STATE ----------------

  Widget _buildLoadingIndicator() {
    // This is the centered loader for initial/empty state
    return SizedBox(
      height: 60.h,
      child: Center(
        child: CircularProgressIndicator(color: yellowColor),
      ),
    );
  }

  Widget _buildEmptyState(String text) {
    return SizedBox(
      height: 60.h, // Ensure it takes up enough space to be visible clearly
      child: Center(
        child: customText(
          text: text,
          fontSize: 15.sp,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPaginationControls({
    required int currentPage,
    required int totalPages,
    required bool hasPrevPage,
    required bool hasNextPage,
    required VoidCallback onPrev,
    required VoidCallback onNext,
    required bool isLoading,
  }) {
    // Agar sirf ek page hai ya koi data nahi hai toh controls nahi dikhayenge
    if (totalPages <= 1) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous Button
          InkWell(
            onTap: isLoading || !hasPrevPage ? null : onPrev,
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hasPrevPage && !isLoading ? yellowColor : Colors.grey.shade300,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 3.w,
                color: hasPrevPage && !isLoading ? blackColor : Colors.grey.shade600,
              ),
            ),
          ),

          SizedBox(width: 4.w),

          // Page Status / Loader (This is the loader you wanted to keep for pagination)
          isLoading
              ? SizedBox(
              width: 5.w,
              height: 5.w,
              child: CircularProgressIndicator(strokeWidth: 2, color: yellowColor)
          )
              : customText(
            text: "Page $currentPage of $totalPages",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: blackColor,
          ),

          SizedBox(width: 4.w),

          // Next Button
          InkWell(
            onTap: isLoading || !hasNextPage ? null : onNext,
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hasNextPage && !isLoading ? yellowColor : Colors.grey.shade300,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 3.w,
                color: hasNextPage && !isLoading ? blackColor : Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --
// The rest of the helper widgets (`inventoryWidget` and `imageWidget`) remain unchanged.

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
    {VoidCallback? ontapTwice}
    ){
  return Container(
    width: 42.w,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12.sp),
    ),
    child: Padding(
      // Reduced vertical padding from 1.h to 0.5.h
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reduced height from 13.h to 12.h
          imageWidget(path, height: 12.h),
          // CommonImageView(
          //   url: path,
          //   height: 10.h,
          //   fit: BoxFit.contain,
          // ),
          SizedBox(height: 0.4.h),
          Padding( // Added horizontal padding for text content
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Row(
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
          ),

          SizedBox(height: 1.h),

          Padding( // Added horizontal padding for text content
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Row(
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
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: buttonWidget(
                "View Detail",
                blackColor,
                colors: yellowColor,
                height: 3.5.h,
                width: double.infinity,
                fontsize: 13.sp,
                onTap: ontap

            ),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: buttonWidget(
                "Remove",
                blackColor,
                colors: customButtonColor.withOpacity(0.2),
                height: 3.5.h,
                width: double.infinity,
                fontsize: 13.sp,
                onTap: ontapTwice

            ),
          ),
        ],
      ),
    ),
  );
}

Widget imageWidget(String? path, {double? height, double? width}) {
  return SizedBox(
    height: height ?? 13.h,
    width: width ?? double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.sp),
      child: path != null && path.isNotEmpty
          ? CachedNetworkImage(
        imageUrl: path,
        fit: BoxFit.cover,  // IMPORTANT: fills full width & height
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(color: Colors.white),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/png/placeholder.png',
          fit: BoxFit.cover,  // make placeholder full width too
        ),
      )
          : Image.asset(
        'assets/png/placeholder.png',
        fit: BoxFit.cover,  // ALWAYS fill full area
      ),
    ),
  );
}
