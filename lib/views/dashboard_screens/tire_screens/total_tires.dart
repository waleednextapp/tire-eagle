import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/views/dashboard_screens/remainder.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_screens/tire_detail.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/user_tire_wheel_controller.dart';
import '../../../widgets/back_button.dart';
import '../wheel_screens/total_wheels.dart';

class TotalTires extends StatelessWidget {
  TotalTires({super.key});
  final TotalTireController controller = Get.find<TotalTireController>();
  final UserTireWheelController userTireWheelController = Get.find<UserTireWheelController>();
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    print(controller.isUser);
    return controller.isUser == false
        ? Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Total Tires",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(
          onTap: () {
            dashboardController.currentIndex.value = 0;
            Get.offAllNamed('/bottomnavbar');
          },
        ),
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await controller.GetAllTire(page: 1);
        },
        builder: (BuildContext context, Widget child, IndicatorController indicator) {
          return child;
        },
        child: Obx(() {
          if (controller.isLoading.value && (controller.tireModel.value?.data?.tires?.isEmpty ?? true)) {
            return const Center(child: CircularProgressIndicator(color: yellowColor));
          }

          // Group tires by dateOfEntry using dot notation
          Map<String, List<dynamic>> tiresByDate = {};
          for (var tire in controller.tireModel.value?.data?.tires ?? []) {
            final date = tire.dateOfEntry?.toString().split("T").first ?? "";
            if (tiresByDate.containsKey(date)) {
              tiresByDate[date]!.add(tire);
            } else {
              tiresByDate[date] = [tire];
            }
          }

          final dateKeys = tiresByDate.keys.toList();

          if (dateKeys.isEmpty) {
            return Center(
              child: customText(
                text: "No Tires Available",
                fontSize: 15.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dateKeys.length,
                    itemBuilder: (context, dateIndex) {
                      final date = dateKeys[dateIndex];
                      final tiresForDate = tiresByDate[date]!;
                      double height = 40.0;
                      if (tiresForDate.length > 1) {
                        height = height - 2.8;
                      }

                      double timelineHeight = (height * tiresForDate.length).h;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: SizedBox(
                              height: timelineHeight,
                              child: timelineIndicator(),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  child: customText(
                                    text: formatDate(date),
                                    fontSize: 14.sp,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: tiresForDate.length,
                                  itemBuilder: (context, tireIndex) {
                                    final item = tiresForDate[tireIndex];

                                    String getDamageTypes() {
                                      // Handling nested fields that might be Maps or Objects
                                      final puncture = item.damageInfo?.damageType?.puncture ?? 0;
                                      final cut = item.damageInfo?.damageType?.cut ?? 0;
                                      final bulge = item.damageInfo?.damageType?.bulge ?? 0;

                                      if (puncture > 0) return "Puncture";
                                      if (cut > 0) return "Cut";
                                      if (bulge > 0) return "Bulge";

                                      return "-";
                                    }

                                    return reminderWidget(
                                      item.vehicalNumber ?? "",
                                      item.brand ?? "",
                                      item.tireSize ?? "",
                                      (item.damageInfo?.damageType?.puncture ?? 0).toString(),
                                      item.dateOfEntry ?? "",
                                      item.mountedPosition ?? "-",
                                      item.serialNumber ?? "",
                                      (item.tireHealth ?? 0).toString(),
                                      width: 78.w,
                                      namesize: 16.sp,
                                      modelsize: 14.sp,
                                      tirewidgetfontsize: 13.sp,
                                      buttoncheaque: false,
                                      inusesize: 13.sp,
                                      damagetype: getDamageTypes(),
                                      estimatedreturndate: formatDate(item.retreadInfo?.estimatedReturnDate?.toString() ?? "-"),
                                      retreadcentername: item.retreadInfo?.centerName ?? "-",
                                      spend: (item.totalCost ?? '0').toString(),
                                      damagereport: formatDate(item.dateOfEntry ?? ""),
                                      status: item.status ?? "",
                                      index: tireIndex,
                                      onNextTap: () {
                                        if (controller.isUser == false) {
                                          Get.toNamed("tire", arguments: item.id ?? "");
                                        } else {
                                          Get.toNamed("usergettirebyid", arguments: item.id ?? "");
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  buildPaginationControls(
                    currentPage: controller.currentTotalTirePage.value,
                    totalPages: controller.totalTotalTirePages.value,
                    hasPrevPage: controller.currentTotalTirePage.value > 1,
                    hasNextPage: controller.hasNextTotalTirePage.value,
                    onPrev: controller.loadPrevTotalTirePage,
                    onNext: controller.loadNextTotalTirePage,
                    isLoading: controller.isLoading.value,
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          );
        }),
      ),
    )
        : Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Total Tires",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(
          onTap: () {
            dashboardController.currentIndex.value = 0;
            Get.offAllNamed('/bottomnavbar');
          },
        ),
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await userTireWheelController.GetAllTire(page: 1);
        },
        builder: (BuildContext context, Widget child, IndicatorController indicator) {
          return child;
        },
        child: Obx(() {
          if (userTireWheelController.isLoading.value && (userTireWheelController.usertireModel.value?.data?.tires?.isEmpty ?? true)) {
            return const Center(child: CircularProgressIndicator(color: yellowColor));
          }

          Map<String, List<dynamic>> tiresByDate = {};
          for (var tire in userTireWheelController.usertireModel.value?.data?.tires ?? []) {
            final date = tire.dateOfEntry?.toString().split("T").first ?? "";
            if (tiresByDate.containsKey(date)) {
              tiresByDate[date]!.add(tire);
            } else {
              tiresByDate[date] = [tire];
            }
          }

          final dateKeys = tiresByDate.keys.toList();

          if (dateKeys.isEmpty) {
            return Center(
              child: customText(
                text: "No Tires Available",
                fontSize: 15.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dateKeys.length,
                    itemBuilder: (context, dateIndex) {
                      final date = dateKeys[dateIndex];
                      final tiresForDate = tiresByDate[date]!;
                      double height = 40.0;
                      if (tiresForDate.length > 1) {
                        height = height - 2.8;
                      }

                      double timelineHeight = (height * tiresForDate.length).h;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: SizedBox(
                              height: timelineHeight,
                              child: timelineIndicator(),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  child: customText(
                                    text: formatDate(date),
                                    fontSize: 14.sp,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: tiresForDate.length,
                                  itemBuilder: (context, tireIndex) {
                                    final item = tiresForDate[tireIndex];

                                    String getDamageTypes() {
                                      final puncture = item.damageInfo?.damageType?.puncture ?? 0;
                                      final cut = item.damageInfo?.damageType?.cut ?? 0;
                                      final bulge = item.damageInfo?.damageType?.bulge ?? 0;

                                      if (puncture > 0) return "Puncture";
                                      if (cut > 0) return "Cut";
                                      if (bulge > 0) return "Bulge";

                                      return "-";
                                    }

                                    return reminderWidget(
                                      item.vehicalNumber ?? "",
                                      item.brand ?? "",
                                      item.tireSize ?? "",
                                      (item.damageInfo?.damageType?.puncture ?? 0).toString(),
                                      item.dateOfEntry ?? "",
                                      item.mountedPosition ?? "-",
                                      item.serialNumber ?? "",
                                      (item.tireHealth ?? 0).toString(),
                                      width: 78.w,
                                      namesize: 16.sp,
                                      modelsize: 14.sp,
                                      tirewidgetfontsize: 13.sp,
                                      buttoncheaque: false,
                                      inusesize: 13.sp,
                                      damagetype: getDamageTypes(),
                                      estimatedreturndate: formatDate(item.retreadInfo?.estimatedReturnDate?.toString() ?? '-'),
                                      retreadcentername: item.retreadInfo?.centerName ?? "-",
                                      spend: (item.totalCost ?? '0').toString(),
                                      damagereport: formatDate(item.dateOfEntry ?? ""),
                                      status: item.status ?? "",
                                      index: tireIndex,
                                      onNextTap: () {
                                        if (controller.isUser == false) {
                                          Get.toNamed("tire", arguments: item.id ?? "");
                                        } else {
                                          Get.toNamed("usergettirebyid", arguments: item.id ?? "");
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  buildPaginationControls(
                    currentPage: userTireWheelController.currentTotalTirePage.value,
                    totalPages: userTireWheelController.totalTotalTirePages.value,
                    hasPrevPage: userTireWheelController.currentTotalTirePage.value > 1,
                    hasNextPage: userTireWheelController.hasNextTotalTirePage.value,
                    onPrev: userTireWheelController.loadPrevTotalTirePage,
                    onNext: userTireWheelController.loadNextTotalTirePage,
                    isLoading: userTireWheelController.isLoading.value,
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
