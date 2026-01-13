import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/user_tire_wheel_controller.dart';
import 'package:tire_eagle/views/dashboard_screens/remainder.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_screens/tire_detail.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/dashboard_controller.dart';
import '../../../controllers/total_tire_controller.dart';
import '../../../models/user_get_all_wheel_model.dart';
import '../../../models/wheel_model.dart';
import '../../../widgets/back_button.dart';



class TotalWheels extends StatelessWidget {
  TotalWheels({super.key});
  final TotalTireController controller = Get.find<TotalTireController>();
  final UserTireWheelController userTireWheelController = Get.find<UserTireWheelController>();
  final DashboardController dashboardController = Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return
      controller.isUser == false ?
      Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Total Wheels",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(
          onTap: () {
            // 1. Update the controller state first
            dashboardController.currentIndex.value = 0;

            // 2. Then perform the navigation
            Get.offAllNamed('/bottomnavbar');
          },
        ),


      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          // 💡 CHANGE: Load first page on refresh
          await controller.GetAllWheel(page: 1);
        },
        builder: (BuildContext context, Widget child, IndicatorController controller) {
          return child;
        },
        child: Obx(() {
          if (controller.isLoadingWheel.value && (controller.wheelModel.value?.data?.wheels?.isEmpty ?? true)) {
            return const Center(child: CircularProgressIndicator(color: yellowColor,));
          }

          // Group wheels by dateOfEntry (YYYY-MM-DD)
          Map<String, List<Wheels>> wheelsByDate = {};
          for (var wheel in controller.wheelModel.value?.data?.wheels ?? []) {
            final date = wheel.dateOfEntry?.split("T").first ?? "";
            if (wheelsByDate.containsKey(date)) {
              wheelsByDate[date]!.add(wheel);
            } else {
              wheelsByDate[date] = [wheel];
            }
          }

          final dateKeys = wheelsByDate.keys.toList();

          if (controller.wheelModel.value?.data?.wheels?.length == 0) {
            return Center(
              child: customText(
                text: "No Wheel Available",
                fontSize: 15.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.only(top: 1.h),
            // 💡 CRITICAL CHANGE: Main ListView ko SingleChildScrollView + Column se replace kiya
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    // Inner ListView must be shrinkWrap true and physics NeverScrollableScrollPhysics
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dateKeys.length,
                    itemBuilder: (context, dateIndex) {
                      final date = dateKeys[dateIndex];
                      final wheelsForDate = wheelsByDate[date]!;
                      double height = 40.0;
                      if (wheelsForDate.length > 1) {
                        height = height - 3.8;
                      }

                      // Timeline height = number of tires for that date * height constant
                      double timelineHeight = (height * wheelsForDate.length).h;


                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// ------- LEFT TIMELINE -------
                          Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: SizedBox(
                              height: timelineHeight,
                              child: timelineIndicator(),
                            ),
                          ),

                          /// ------- RIGHT CONTENT -------
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// DATE HEADER
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  child: customText(
                                    text: formatDate(date), // formatted date only
                                    fontSize: 14.sp,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 1.h),

                                /// INNER LIST BUILDER (Wheels of that date)
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: wheelsForDate.length,
                                  itemBuilder: (context, wheelIndex) {
                                    final item = wheelsForDate[wheelIndex];

                                    String getDamageType() {
                                      final damageInfo = item.damageInfo;

                                      if (damageInfo == null) return "-";

                                      final damageType = damageInfo.damageType;
                                      if (damageType == null) return "-";

                                      final int cut = damageType.cut ?? 0;
                                      final int bulge = damageType.bulge ?? 0;

                                      if (cut > 0) return "Cut";
                                      if (bulge > 0) return "Bulge";

                                      return "-";
                                    }


                                    return reminderWidget(
                                      item.vehicalNumber ?? "-",
                                      item.material ?? "-",
                                      item.wheelSize ?? "-",
                                      "0",
                                      item.dateOfEntry ?? "-",
                                      item.mountedPosition ?? "-",
                                      item.serialNumber ?? "-",
                                      (item.wheelHealth ?? 0).toString(),
                                      width: 78.w,
                                      namesize: 16.sp,
                                      modelsize: 14.sp,
                                      tirewidgetfontsize: 13.sp,
                                      buttoncheaque: false,
                                      inusesize: 13.sp,
                                      damagetype: getDamageType(),
                                      estimatedreturndate: formatDate(item.retreadInfo?.estimatedReturnDate ?? '-'),
                                      retreadcentername: item.retreadInfo?.centerName ?? '-',
                                      spend: null ?? '0',
                                      damagereport: formatDate(item.dateOfEntry), // formatted date
                                      status: item.status ?? "",
                                      index: wheelIndex,
                                      onNextTap: () {

                                        if(controller.isUser == false){
                                          Get.toNamed("wheeldetails", arguments:
                                          item.id ?? "");
                                        }
                                        else{
                                          Get.toNamed("usergetwheelbyid", arguments:
                                          item.id ?? "");
                                        }

                                      }
                                    );
                                  },
                                ),

                                SizedBox(height: 1.h),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // 💡 NEW: Pagination Controls for Total Wheels
                  buildPaginationControls(
                    currentPage: controller.currentTotalWheelPage.value,
                    totalPages: controller.totalTotalWheelPages.value,
                    hasPrevPage: controller.currentTotalWheelPage.value > 1,
                    hasNextPage: controller.hasNextTotalWheelPage.value,
                    onPrev: controller.loadPrevTotalWheelPage,
                    onNext: controller.loadNextTotalWheelPage,
                    isLoading: controller.isLoadingWheel.value,
                  ),
                  SizedBox(height: 5.h), // Extra space at the bottom
                ],
              ),
            ),
          );
        }),
      ),
    ):Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: whiteColor,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: customText(
              text: "Total Wheels",
              fontSize: 19.sp,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: backButton(
            onTap: () {
              // 1. Update the controller state first
              dashboardController.currentIndex.value = 0;

              // 2. Then perform the navigation
              Get.offAllNamed('/bottomnavbar');
            },
          ),
        ),
        body: CustomRefreshIndicator(
          onRefresh: () async {
            // 💡 CHANGE: Load first page on refresh
            await userTireWheelController.GetAllWheel(page: 1);
          },
          builder: (BuildContext context, Widget child, IndicatorController controller) {
            return child;
          },
          child: Obx(() {
            if (userTireWheelController.isLoading.value && (userTireWheelController.userWheelModel.value?.data?.wheels?.isEmpty ?? true)) {
              return const Center(child: CircularProgressIndicator(color: yellowColor,));
            }

            // Group wheels by dateOfEntry (YYYY-MM-DD)
            Map<String, List<UserWheels>> wheelsByDate = {};
            for (var wheel in userTireWheelController.userWheelModel.value?.data?.wheels ?? []) {
              final date = wheel.dateOfEntry?.split("T").first ?? "";
              if (wheelsByDate.containsKey(date)) {
                wheelsByDate[date]!.add(wheel);
              } else {
                wheelsByDate[date] = [wheel];
              }
            }

            final dateKeys = wheelsByDate.keys.toList();

            if (userTireWheelController.userWheelModel.value?.data?.wheels?.length == 0) {
              return Center(
                child: customText(
                  text: "No Wheel Available",
                  fontSize: 15.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.only(top: 1.h),
              // 💡 CRITICAL CHANGE: Main ListView ko SingleChildScrollView + Column se replace kiya
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                      // Inner ListView must be shrinkWrap true and physics NeverScrollableScrollPhysics
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dateKeys.length,
                      itemBuilder: (context, dateIndex) {
                        final date = dateKeys[dateIndex];
                        final wheelsForDate = wheelsByDate[date]!;
                        double height = 40.0;
                        if (wheelsForDate.length > 1) {
                          height = height - 3.8;
                        }

                        // Timeline height = number of tires for that date * height constant
                        double timelineHeight = (height * wheelsForDate.length).h;


                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// ------- LEFT TIMELINE -------
                            Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: SizedBox(
                                height: timelineHeight,
                                child: timelineIndicator(),
                              ),
                            ),

                            /// ------- RIGHT CONTENT -------
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// DATE HEADER
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                                    child: customText(
                                      text: formatDate(date), // formatted date only
                                      fontSize: 14.sp,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 1.h),

                                  /// INNER LIST BUILDER (Wheels of that date)
                                  ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: wheelsForDate.length,
                                    itemBuilder: (context, wheelIndex) {
                                      final item = wheelsForDate[wheelIndex];

                                      String getDamageType() {
                                        final damageInfo = item.damageInfo;

                                        if (damageInfo == null) return "-";

                                        final damageType = damageInfo.damageType;
                                        if (damageType == null) return "-";

                                        final int cut = damageType.cut ?? 0;
                                        final int bulge = damageType.bulge ?? 0;

                                        if (cut > 0) return "Cut";
                                        if (bulge > 0) return "Bulge";

                                        return "-";
                                      }


                                      return reminderWidget(
                                        item.vehicalNumber ?? "-",
                                        item.material ?? "-",
                                        item.wheelSize ?? "-",
                                        "0",
                                        item.dateOfEntry ?? "-",
                                        item.mountedPosition ?? "-",
                                        item.serialNumber ?? "-",
                                        (item.wheelHealth ?? 0).toString(),
                                        width: 78.w,
                                        namesize: 16.sp,
                                        modelsize: 14.sp,
                                        tirewidgetfontsize: 13.sp,
                                        buttoncheaque: false,
                                        inusesize: 13.sp,
                                        damagetype: getDamageType(),
                                        estimatedreturndate: formatDate(item.retreadInfo?.estimatedReturnDate ?? '-'),
                                        retreadcentername: item.retreadInfo?.centerName ?? '-',
                                        spend: null ?? '0',
                                        damagereport: formatDate(item.dateOfEntry), // formatted date
                                        status: item.status ?? "",
                                        index: wheelIndex,
                                        onNextTap: () {

                                          if(controller.isUser == false){
                                            Get.toNamed("wheeldetails", arguments:
                                            item.id ?? "");
                                          }
                                          else{
                                            Get.toNamed("usergetwheelbyid", arguments:
                                            item.id ?? "");
                                          }

                                        }
                                      );
                                    },
                                  ),

                                  SizedBox(height: 1.h),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    // 💡 NEW: Pagination Controls for Total Wheels
                    buildPaginationControls(
                      currentPage: controller.currentTotalWheelPage.value,
                      totalPages: controller.totalTotalWheelPages.value,
                      hasPrevPage: controller.currentTotalWheelPage.value > 1,
                      hasNextPage: controller.hasNextTotalWheelPage.value,
                      onPrev: controller.loadPrevTotalWheelPage,
                      onNext: controller.loadNextTotalWheelPage,
                      isLoading: controller.isLoadingWheel.value,
                    ),
                    SizedBox(height: 5.h), // Extra space at the bottom
                  ],
                ),
              ),
            );
          }),
        ),
      );
  }

}
/// Helper function to format ISO date to human-readable (date only)
String formatDate(String? isoDate) {
  if (isoDate == null || isoDate.isEmpty) return "";
  try {
    final dateTime = DateTime.parse(isoDate).toLocal();
    final formatter = DateFormat('dd MMM yyyy'); // e.g., 02 Dec 2025
    return formatter.format(dateTime);
  } catch (e) {
    return isoDate; // fallback
  }
}
// 💡 NEW HELPER WIDGET: Pagination Controls
Widget buildPaginationControls({
  required int currentPage,
  required int totalPages,
  required bool hasPrevPage,
  required bool hasNextPage,
  required VoidCallback onPrev,
  required VoidCallback onNext,
  required bool isLoading,
}) {
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

        // Page Status / Loader
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
