import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dispose_controller.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_screens/total_wheels.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';

class DisposedHistory extends StatelessWidget {
  DisposedHistory({super.key});

  final DisposeController controller = Get.find<DisposeController>();

  Map<String, List<T>> groupItemsByDate<T>(List<T>? items, String? Function(T item) getDate) {
    if (items == null) return {};

    final Map<String, List<T>> groupedMap = {};
    for (var item in items) {
      final date = getDate(item);
      if (date != null && date.isNotEmpty) {
        if (!groupedMap.containsKey(date)) {
          groupedMap[date] = [];
        }
        groupedMap[date]!.add(item);
      }
    }
    return groupedMap;
  }

  @override
  Widget build(BuildContext context) {
    // FIXED: API call triggered after the build to prevent markNeedsBuild error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Disposed History",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      // FIXED: Wrapped the body in Obx to ensure UI updates when data or index changes
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),

              // -------------------- TAB BAR --------------------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Row(
                  children: List.generate(controller.inventoryTabs.length, (index) {
                    bool isSelected = controller.inventoryIndexTab.value == index;

                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == controller.inventoryTabs.length - 1 ? 0 : 2.w,
                      ),
                      child: InkWell(
                        onTap: () {
                          controller.selectInventoryValue(index);
                        },
                        borderRadius: BorderRadius.circular(30.sp),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.6.h),
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
                    );
                  }),
                ),
              ),

              // -------------------- TAB CONTENT --------------------
              if (controller.isLoading.value)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: CircularProgressIndicator(color: yellowColor),
                  ),
                )
              else
                controller.inventoryIndexTab.value == 0
                    ? tyreList()
                    : wheelList(),
              SizedBox(height: 5.h),
            ],
          ),
        );
      }),
    );
  }

  // API load karne ka function
  void _loadData() async {
    if (controller.disposedData.value == null && controller.disposedWheelData.value == null) {
      await controller.getDisposedHistory("tire");
      await controller.getDisposedHistory("wheel");
    }
  }

  // -------------------- TYRE LIST --------------------
  Widget tyreList() {
    // FIXED: Correctly check for null or empty list to show the empty message
    final tires = controller.disposedData.value?.data?.items;

    if (tires == null || tires.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 38.h),
          child:
          customText(
            text: "No disposed tires found.",
            fontSize: 15.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    final groupedTires = groupItemsByDate(
      tires,
          (item) => formatDate(item?.updatedAt),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedTires.entries.map((entry) {
        final date = entry.key;
        final items = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 6.w, top: 2.h, bottom: 1.h),
              child: customText(
                text: date,
                fontSize: 14.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
            ),
            ...items.map((item) {
              return disposedWidget(
                item?.serialNumber ?? "",
                item?.brand ?? "",
                item?.mountedPosition ?? "-",
                (item?.tireHealth ?? "").toString(),
                item?.tireSize ?? "",
                formatDate(item?.updatedAt),
                (item?.plyRating ?? "").toString(),
                item?.dismount?.reason ?? "",
                    () {},
              );
            }).toList(),
          ],
        );
      }).toList(),
    );
  }

  // -------------------- WHEEL LIST --------------------
  Widget wheelList() {
    // FIXED: Correctly check for null or empty list to show the empty message
    final wheels = controller.disposedWheelData.value?.data?.items;

    if (wheels == null || wheels.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 38.h),
          child: customText(
            text: "No disposed wheel found.",
            fontSize: 15.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    final groupedWheels = groupItemsByDate(
      wheels,
          (item) => formatDate(item?.updatedAt),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedWheels.entries.map((entry) {
        final date = entry.key;
        final items = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 6.w, top: 2.h, bottom: 1.h),
              child: customText(
                text: date,
                fontSize: 14.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
            ),
            ...items.map((item) {
              return disposedWidget(
                item?.serialNumber ?? "",
                item?.material ?? "",
                item?.mountedPosition ?? "-",
                (item?.wheelHealth ?? "").toString(),
                item?.wheelSize ?? "",
                formatDate(item?.updatedAt),
                (item?.wheelCondition ?? "").toString(),
                item?.dismount?.reason ?? "",
                    () {},
              );
            }).toList(),
          ],
        );
      }).toList(),
    );
  }
}
// Your existing disposedWidget function remains the same
Widget disposedWidget(
    String name,
    String model,
    String mountedPosition,
    String tireHealth,
    String tireSize,
    String date,
    String plyRating,
    String reason,
    VoidCallback ontap,
    ) {
  final DisposeController controller = Get.find<DisposeController>();
  return Padding(

    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.5.h),
    child: InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity, // Full width
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.sp,
              offset: Offset(0, 2.sp),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row with name and model
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: name,
                        fontSize: 17.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                      ),
                      customText(
                        text: model,
                        fontSize: 15.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 1.h),

              // Details row
              Row(
                children: [
                  // Left Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Mounted Position",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: mountedPosition,
                        fontSize: 13.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.5.h),
                      customText(
                        text: controller.inventoryIndexTab == 0 ? "Tire Size":"Wheel Size",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        fontSize: 13.sp,
                        text: tireSize,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.5.h),
                      customText(
                        text: "Date of Update",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        fontSize: 13.sp,
                        text: date,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(width: 15.w),
                  // Right Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Health",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: "${tireHealth} \%",
                        fontSize: 13.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.5.h),
                      customText(
                        text: controller.inventoryIndexTab == 0 ? "Ply Rating": "Wheel Condition",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: plyRating,
                        fontSize: 13.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.5.h),
                      customText(
                        text: "Disposed Reason",
                        fontSize: 13.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: reason,
                        fontSize: 13.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
