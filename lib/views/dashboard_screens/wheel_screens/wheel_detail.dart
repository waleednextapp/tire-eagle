import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_screens/total_wheels.dart';
import 'package:tire_eagle/widgets/button_widget.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/total_tire_controller.dart';
import '../../../utils/shared_prefrences_methods.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/confirm_dismount_dialog.dart';
import '../../../widgets/rotate_tire_dialog.dart';
import '../inventory_screen.dart';
import '../remainder.dart';
import '../tire_screens/tire_detail.dart';

class WheelDetail extends StatelessWidget {
  WheelDetail({super.key});
  final AuthController controller = Get.find<AuthController>();
  final prefs = SharedPreferencesMethod.storage;
  // NOTE: Initial 'remainder' list is redundant as it's redefined in build.
  // Keeping it as a placeholder list here for context if needed elsewhere.
  final List<Map<String, String>> initialRemainder = [
    {"title": "Vehical", "content": "Truck #YXU - 5689"},
    {"title": "Wheel Size", "content": "22.5"},
    {"title": "Position", "content": "F-Right"},
    {"title": "Serial Number", "content": "DOT 5478 DC89"},
    {"title": "Last Update", "content": "April 25, 2025"},
    {"title": "Install Date", "content": "Feb 20, 2024"},
    {"title": "Select Material:", "content": "Aluminum"},
  ];
  final TotalTireController totalTireController = Get.find<TotalTireController>();


  @override
  Widget build(BuildContext context) {
    final wheelId = Get.arguments;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (wheelId != null && wheelId.isNotEmpty) {
        totalTireController.GetWheelById(wheelId);
      }
    });

    return Obx(() {
      final item = totalTireController.getWheelByIdModel.value?.data;
      // Re-fetch isUser inside Obx in case it's dynamic, although usually static
      var isUser = prefs.getBool('isUser');

      // Helper functions defined here as they rely on the reactive 'item'
      // These are related to Wheel Damage (Cuts, Bulges)
      double bulge() => (item?.totalDamage?.bulge ?? 0) / 20;
      double cut() => (item?.totalDamage?.cut ?? 0) / 20;

      final List<Map<String, String>> remainder = [
        {"title": "Vehical", "content": item?.vehicalNumber ?? ''},
        {"title": "Size", "content": item?.wheelSize ?? ""},
        {"title": "Position", "content": item?.mountedPosition ?? "-"},
        {"title": "Serial Number", "content": item?.serialNumber ?? ""},
        {"title": "Last Update", "content": formatDate(item?.updatedAt ?? "")},
        {"title": "Install Date", "content": formatDate(item?.dateOfEntry ?? "")},
        {"title": "Wheel Health:", "content": (item?.wheelHealth?.toString() ?? '-') + '%'}, // Corrected to wheelHealth
        {"title": "Total Spending:", "content": "${item?.totalSpending ?? ""} \$"},
      ];

      // Check if data is loading and show a spinner
      if (totalTireController.isLoading.value == true) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            centerTitle: true,
            title: customText(text: "Wheel Details", fontSize: 19.sp, fontFamily: "Roboto", fontWeight: FontWeight.w600),
            leading: backButton(),
          ),
          body: const Center(child: CircularProgressIndicator(color: yellowColor)),
        );
      }

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: whiteColor,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: customText(
              text: "Wheel Details",
              fontSize: 19.sp,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: backButton(),
        ),
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Main Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 1. Banner and Main Info
                      _buildTireHeader(item),

                      // 2. Vehicle Details List (FIXED: Removed redundant fixed height container)
                      _buildVehicleDetailList(remainder),

                      // 3. Wheel Damage History (FIXED: Renamed/Adjusted for Wheel)
                      _buildWheelDamageHistory(item, bulge(), cut()),

                      // 4. Damage/Retread History Timeline
                      _RetreadHistoryTimeline(
                        totalTireController: totalTireController,
                      ),
                    ],
                  ),
                ),
              ),

              // 5. Bottom Fixed Actions
              isUser == false
                  ? _buildBottomActions(context)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );
    });
  }
  // --- BUILD HELPER METHODS ---

  Widget _buildTireHeader(dynamic item) {
    return Column(
      children: [
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: imageWidget(totalTireController.getWheelByIdModel.value?.data?.imageUrl ?? '', height: 28.h),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: item?.vehicalNumber ?? '',
                    fontSize: 19.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600,
                  ),
                  customText(
                    text: item?.material ?? '',
                    fontSize: 14.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: containerGreenColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                child: customText(
                  text: item?.status ?? '',
                  fontSize: 15.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  color: textGreenColor,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildVehicleDetailList(List<Map<String, String>> remainder) {
    // FIX: Removed the fixed height SizedBox which was unnecessary and restrictive.
    return Column(
      children: [
        ListView.builder( // Uses natural height inside SingleChildScrollView
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: remainder.length,
          itemBuilder: (context, index) {
            return vehicaldetail(
              remainder[index]["title"]!,
              remainder[index]["content"]!,
              index: index,
            );
          },
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildWheelDamageHistory(dynamic item, double bulgeValue, double cutValue) {
    // Renamed from _buildTreadDepthHistory to better reflect Wheel context
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                text: "Damage History", // Adjusted text
                fontSize: 17.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
              ),
              customText(
                text: "Wheel Health: ${item?.wheelHealth ?? '-'}%", // Using actual health value
                fontSize: 15.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
                color: wheelDetailOrangeColor,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
          child: Column(
            children: [
              // Assuming threadDepthWidget is a generic bar widget
              threadDepthWidget("Cuts", cutValue, barredColor, item?.totalDamage?.cut ?? 0),
              threadDepthWidget("Bulge", bulgeValue, bargreenColor, item?.totalDamage?.bulge ?? 0),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    final data = totalTireController.getWheelByIdModel.value?.data;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row with 2 buttons
          Row(
            children: [
              Expanded(
                child: buttonWidget(
                  "Rotate",
                  whiteColor,
                  fontsize: 14.sp,
                  colors: buttonBlueColor,
                  height: 4.7.h,
                  radius: 12.sp,
                  fontfaimly: 'Roboto',
                  fontweight: FontWeight.w600,
                  path: "assets/png/wheel_detail/rotate.png",
                  onTap: () {
                    showRotateTireDialog(context, isWheel: true, vehicleNo: data?.vehicalNumber, tireType: data?.material, position: data?.mountedPosition);
                  },
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: buttonWidget(
                  "Dismount",
                  whiteColor,
                  fontsize: 14.sp,
                  colors: buttonRedColor,
                  height: 4.7.h,
                  radius: 12.sp,
                  fontfaimly: 'Roboto',
                  fontweight: FontWeight.w600,
                  path: "assets/png/wheel_detail/dismount.png",
                  onTap: () {
                    confirmDismountDialog(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),

          // Separate button under the row
          SizedBox(
            width: double.infinity,
            child: buttonWidget(
              "Send for Retread",
              whiteColor,
              fontsize: 14.sp,
              colors: buttonPurpleColor,
              height: 4.7.h,
              radius: 12.sp,
              fontfaimly: 'Roboto',
              fontweight: FontWeight.w600,
              path: "assets/png/wheel_detail/rethread.png",
              onTap: () {
                Get.toNamed("rethread");
              },
            ),
          ),
          SizedBox(height: 1.5.h),
        ],
      ),
    );
  }


}

// --- EXTRACTED TIMELINE WIDGET ---
// ... (rest of the code remains the same up to _RetreadHistoryTimeline)

// --- EXTRACTED TIMELINE WIDGET ---
class _RetreadHistoryTimeline extends StatelessWidget {
  final TotalTireController totalTireController;

  const _RetreadHistoryTimeline({required this.totalTireController});

  // Helper function to group DAMAGE records by date (using dateOfEntry) - This is correct for ReportDamage
  Map<String, List<dynamic>> _groupRecordsDamage(List<dynamic>? records) {
    if (records == null) return {};
    Map<String, List<dynamic>> tiresByDate = {};
    for (var tire in records) {
      final date = tire.dateOfEntry?.split("T").first ?? "";
      tiresByDate.update(date, (list) => list..add(tire), ifAbsent: () => [tire]);
    }
    return tiresByDate;
  }

  // Helper function to group RETHREAD records by date
  // FIX: Changed 'dateOfEntry' to 'dateOfDamage' or 'createdAt' as per the JSON.
  // Using 'dateOfDamage' as it seems contextually relevant for grouping.
  Map<String, List<dynamic>> _groupRecordsRethread(List<dynamic>? records) {
    if (records == null) return {};
    Map<String, List<dynamic>> tiresByDate = {};
    for (var tire in records) {
      // **CRITICAL FIX: Changed from 'dateOfEntry' to 'dateOfDamage'**
      final date = tire.dateOfDamage?.split("T").first ?? "";
      tiresByDate.update(date, (list) => list..add(tire), ifAbsent: () => [tire]);
    }
    return tiresByDate;
  }

  // Helper function to determine the primary damage type for display
  String _getDamageType(dynamic item) {
    // This is used for Damage Reports (ReportDamages)
    final cut = item?.damageType?.cut ?? 0;
    final bulge = item?.damageType?.bulge ?? 0;

    if (cut > 0) return "Cut";
    if (bulge > 0) return "Bulge";

    return "-";
  }

  @override
  Widget build(BuildContext context) {
    final recordsReportDamage = totalTireController.getWheelByIdModel.value?.data?.reportDamages;
    final recordsRethread = totalTireController.getWheelByIdModel.value?.data?.retreadRecords;

    // Grouping
    final damagesByDate = _groupRecordsDamage(recordsReportDamage);
    final retreadsByDate = _groupRecordsRethread(recordsRethread);

    final damageDateKeys = damagesByDate.keys.toList();
    final retreadDateKeys = retreadsByDate.keys.toList();

    final hasRecords = (recordsReportDamage != null && recordsReportDamage.isNotEmpty) ||
        (recordsRethread != null && recordsRethread.isNotEmpty);

    if (totalTireController.isLoading.value) {
      return const Center(child: CircularProgressIndicator(color: yellowColor));
    }

    if (!hasRecords) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: customText(
            text: "No Damage or Retread Records Available",
            fontSize: 15.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- 1. DAMAGE REPORTS TIMELINE ---
        Padding(
          padding: EdgeInsets.only(left: 5.w,top: 2.h),
          child: customText(
              text: 'Puncture History',
              fontSize: 15.sp
          ),
        ),
        if (damageDateKeys.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: damageDateKeys.length,
              itemBuilder: (context, dateIndex) {
                final date = damageDateKeys[dateIndex];
                final recordsForDate = damagesByDate[date]!;

                // Timeline height calculation
                double heightPerItem = 40.0;
                if (recordsForDate.length > 1) {
                  heightPerItem -= 3.0 + ((recordsForDate.length - 1) * 0.085);
                }
                double timelineHeight = (heightPerItem * recordsForDate.length).h;

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
                              text: formatDate(date),
                              fontSize: 14.sp,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 1.h),

                          /// INNER LIST BUILDER (Damage Records of that date)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: recordsForDate.length,
                            itemBuilder: (context, recordIndex) {
                              final item = recordsForDate[recordIndex];
                              final sameData = totalTireController.getWheelByIdModel.value?.data;

                              return reminderWidget(
                                sameData?.vehicalNumber ?? "-",
                                sameData?.material ?? "-",
                                sameData?.wheelSize ?? "-",
                                "Damage Report", // Label changed for clarity
                                item?.dateOfEntry ?? "-", // dateOfEntry exists in ReportDamage
                                item?.location ?? "-",
                                sameData?.serialNumber ?? "-",
                                "${sameData?.wheelHealth ?? 0} \%",
                                width: 78.w,
                                namesize: 16.sp,
                                modelsize: 14.sp,
                                tirewidgetfontsize: 13.sp,
                                buttoncheaque: false,
                                inusesize: 13.sp,
                                damagetype: _getDamageType(item),
                                estimatedreturndate: null,
                                retreadcentername: null,
                                spend: null ?? '0',
                                damagereport: formatDate(item?.dateOfEntry),
                                status: sameData?.status ?? "-",
                                index: recordIndex,
                                onNextTap: () {
                                  Get.toNamed("tire", arguments: item?.id ?? "");
                                  print("Damage Report ID: ${item?.id ?? ""}");
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
          ),

        Padding(
          padding: EdgeInsets.only(left: 5.w,top: 0.h),
          child: customText(
              text: 'Rethread History',
              fontSize: 15.sp
          ),
        ),
        // --- 2. RETHREAD RECORDS TIMELINE ---
        if (retreadDateKeys.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: retreadDateKeys.length,
              itemBuilder: (context, dateIndex) {
                final date = retreadDateKeys[dateIndex];
                final recordsForDate = retreadsByDate[date]!;

                // Timeline height calculation
                double heightPerItem = 40.0;
                if (recordsForDate.length > 1) {
                  heightPerItem -= 3.9;
                }
                double timelineHeight = (heightPerItem * recordsForDate.length).h;

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
                              text: formatDate(date),
                              fontSize: 14.sp,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 1.h),

                          /// INNER LIST BUILDER (Retread Records of that date)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: recordsForDate.length,
                            itemBuilder: (context, recordIndex) {
                              final item = recordsForDate[recordIndex];
                              final sameData = totalTireController.getWheelByIdModel.value?.data;

                              return reminderWidget(
                                sameData?.vehicalNumber ?? "",
                                sameData?.material ?? "",
                                sameData?.wheelSize ?? "",
                                "Retread",
                                // FIX: dateOfDamage is the event date used for grouping.
                                item?.dateOfDamage ?? "",
                                sameData?.mountedPosition ?? "",
                                sameData?.serialNumber ?? "",
                                "${item?.wheelHealth ?? 0} \%",
                                width: 78.w,
                                namesize: 16.sp,
                                modelsize: 14.sp,
                                tirewidgetfontsize: 13.sp,
                                buttoncheaque: false,
                                inusesize: 13.sp,
                                damagetype: "Retread",
                                estimatedreturndate: formatDate(item?.estimatedReturnDate ?? ""),
                                retreadcentername: item?.centerName,
                                spend: "${item?.averageCost ?? 0} \$",
                                // Using the date the damage/event occurred for the report date
                                damagereport: formatDate(item?.dateOfDamage),
                                status: sameData?.status ?? "",
                                index: recordIndex,
                                onNextTap: () {
                                  Get.toNamed("tire", arguments: item?.id ?? "");
                                  print("Retread Record ID: ${item?.id ?? ""}");
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
          ),
      ],
    );
  }
}
Widget vehicaldetail(String title, String content,{int? index}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 6.w),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      // aligns both columns top-to-top
      children: [
        // First column
        Expanded(
          flex: 4, // 3 parts for title
          child: customText(
            text: title,
            fontSize: 15.sp,
            fontFamily: "Barlow",
            fontWeight: FontWeight.w500,
          ),
        ),
        // Spacer
        SizedBox(width: 6.w),

        // Second column
        Expanded(
          flex: 5, // 5 parts for content
          child: customText(
            text: content,
            fontSize: 14.sp,
            fontFamily: "Barlow",
            fontWeight: FontWeight.w400,
            color: index == 6 ? wheelDetailOrangeColor : null
          ),
        ),
      ],
    ),
  );
}
