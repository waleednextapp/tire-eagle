import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/utils/shared_prefrences_methods.dart';
// Removed unused imports:
// import 'package:tire_eagle/views/dashboard_screens/inventory_screen.dart';
// import 'package:tire_eagle/views/dashboard_screens/remainder.dart';
// import 'package:tire_eagle/views/dashboard_screens/wheel_screens/total_wheels.dart';
// import 'package:tire_eagle/views/dashboard_screens/wheel_screens/wheel_detail.dart';
import 'package:tire_eagle/widgets/confirm_dismount_dialog.dart';
import 'package:tire_eagle/widgets/rotate_tire_dialog.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/user_tire_wheel_controller.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/button_widget.dart';
import '../inventory_screen.dart';
import '../remainder.dart';
import '../wheel_screens/total_wheels.dart';
import '../wheel_screens/wheel_detail.dart';

// --- MAIN CLASS ---
class UserTireDetail extends StatelessWidget {
  UserTireDetail({super.key});

  // Controllers and Utilities
  final AuthController controller = Get.find<AuthController>();
  final TotalTireController totalTireController = Get.find<TotalTireController>();
  final UserTireWheelController userTireWheelController = Get.find<UserTireWheelController>();
  final DashboardController dashboardController = Get.find<DashboardController>();
  final prefs = SharedPreferencesMethod.storage;
  final bool iswheel = false;

  @override
  Widget build(BuildContext context) {
    final String tireId = Get.arguments?.toString() ?? "";
    // Fetch data when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (tireId != null && tireId.isNotEmpty) {
        userTireWheelController.GetTireById(tireId);
      }
    });

    // Use Obx to rebuild the widget when the data model changes,
    // ensuring item is always up-to-date.
    return Obx(() {
      final item = userTireWheelController.getTireByIdModel.value?.data;
      var isUser = prefs.getBool('isUser');

      print('iam here ${item?.status}');

      // Helper functions defined here as they rely on the reactive 'item'
      double puncture() => (item?.totalDamage?.puncture ?? 0) / 20;
      double bulge() => (item?.totalDamage?.bulge ?? 0) / 20;
      double cut() => (item?.totalDamage?.cut ?? 0) / 20;

      final List<Map<String, String>> remainder = [
        {"title": "Vehical", "content": item?.vehicalNumber ?? ''},
        {"title": "Size", "content": item?.tireSize ?? ""},
        {"title": "Position", "content": item?.mountedPosition ?? "-"},
        {"title": "Serial Number", "content": item?.serialNumber ?? ""},
        {"title": "Last Update", "content": formatDate(item?.updatedAt ?? "")},
        {"title": "Install Date", "content": formatDate(item?.dateOfEntry ?? "")},
        {"title": "Tire Health:", "content": (item?.tireHealth?.toString() ?? '-') + '%'},
        {"title": "Total Spending:", "content": "${item?.totalSpending ?? ""} \$"},
      ];
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: whiteColor,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: customText(
              text: "Tire Details",
              fontSize: 19.sp,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: backButton(
              onTap: (){
                if(totalTireController.isHome == true){
                  // 1. Update the controller state first
                  dashboardController.currentIndex.value = 0;

                  // 2. Then perform the navigation
                  Get.offAllNamed('/bottomnavbar');
                  totalTireController.isHome?.value = false;
                }
                else{
                  Get.back();
                }

              }),
        ),
        body: userTireWheelController.isLoading.value == true ?
        Center(child: CircularProgressIndicator(color: yellowColor)):
        SizedBox.expand(
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

                      // 2. Vehicle Details List
                      _buildVehicleDetailList(remainder),

                      // 3. Tread Depth History

                      _buildTreadDepthHistory(item, puncture(), bulge(), cut()),

                      // 4. Retread/Damage History Timeline
                      _RetreadHistoryTimeline(
                        userTireWheelController: userTireWheelController,
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
          child: imageWidget(userTireWheelController.getTireByIdModel.value?.data?.imageUrl ?? '', height: 28.h),
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
                    text: item?.brand ?? '',
                    fontSize: 14.sp,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: getDisposedColor(item?.status ?? ''),
                ),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                child: customText(
                  text: item?.status ?? '',
                  fontSize: 15.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  color: item?.status == "disposed" || item?.status == "dismounted"  ? redColor:textGreenColor,
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
    // FIX: Removed the incorrect fixed height Container wrapper for ListView.builder.
    // The physics and shrinkWrap are enough to control its height inside SingleChildScrollView.
    return Column(
      children: [
        SizedBox(
          height: 25.h,
          child: ListView.builder(
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
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildTreadDepthHistory(dynamic item, double punctureValue, double bulgeValue, double cutValue) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                text: "Tread Depth History",
                fontSize: 17.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
              ),
              // customText(
              //   text: "8/32", // Hardcoded value
              //   fontSize: 17.sp,
              //   fontFamily: "Roboto",
              //   fontWeight: FontWeight.w600,
              //   color: wheelDetailOrangeColor,
              // ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
          child: Column(
            children: [
              // The functions puncture(), bulge(), cut() now return the bar value,
              // and the last argument is the count (item?.totalDamage?.puncture ?? 0)
              threadDepthWidget("Punctures", punctureValue, barOrangeColor, item?.totalDamage?.puncture ?? 0),
              threadDepthWidget("Cuts", bulgeValue, barredColor, item?.totalDamage?.cut ?? 0),
              threadDepthWidget("Bulge", cutValue, bargreenColor, item?.totalDamage?.bulge ?? 0),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    final data = userTireWheelController.getTireByIdModel.value?.data;
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
                    showRotateTireDialog(context, vehicleNo: data?.vehicalNumber, position: data?.mountedPosition, tireType: data?.brand);
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
                    confirmDismountDialog(context,iswheel: iswheel);
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
// This widget is complex and benefits most from extraction.
class _RetreadHistoryTimeline extends StatelessWidget {
  final UserTireWheelController userTireWheelController;

  const _RetreadHistoryTimeline({required this.userTireWheelController});

  // Helper function to group RETHREAD records by date (using dateOfDamage)
  Map<String, List<dynamic>> _groupRecordsRetread(List<dynamic>? records) {
    if (records == null) return {};

    Map<String, List<dynamic>> tiresByDate = {};
    for (var tire in records) {
      // Use dateOfDamage for grouping Retread Records
      final date = tire.dateOfDamage?.split("T").first ?? "";
      tiresByDate.update(date, (list) => list..add(tire), ifAbsent: () => [tire]);
    }
    return tiresByDate;
  }

  // Helper function to group DAMAGE reports by date (using dateOfEntry)
  Map<String, List<dynamic>> _groupRecordsDamage(List<dynamic>? records) {
    if (records == null) return {};

    Map<String, List<dynamic>> tiresByDate = {};
    for (var tire in records) {
      // Use dateOfEntry for grouping Damage Reports
      final date = tire.dateOfEntry?.split("T").first ?? "";
      tiresByDate.update(date, (list) => list..add(tire), ifAbsent: () => [tire]);
    }
    return tiresByDate;
  }

  // Helper function to determine the primary damage type for display
  String _getDamageType(dynamic item) {
    // 'item' here is a single record from 'reportDamages' list.
    // The damage counts are directly under 'damageType' in the report object.
    final puncture = item?.damageType?.puncture ?? 0;
    final cut = item?.damageType?.cut ?? 0;
    final bulge = item?.damageType?.bulge ?? 0;

    if (puncture > 0) return "Puncture";
    if (cut > 0) return "Cut";
    if (bulge > 0) return "Bulge";

    return "-";
  }

  @override
  Widget build(BuildContext context) {
    // Get both records lists
    final recordsReportDamage = userTireWheelController.getTireByIdModel.value?.data?.reportDamages;
    final recordsRetread = userTireWheelController.getTireByIdModel.value?.data?.retreadRecords;

    // Grouping
    final damagesByDate = _groupRecordsDamage(recordsReportDamage);
    final retreadsByDate = _groupRecordsRetread(recordsRetread);

    final damageDateKeys = damagesByDate.keys.toList();
    final retreadDateKeys = retreadsByDate.keys.toList();

    final hasRecords = damageDateKeys.isNotEmpty || retreadDateKeys.isNotEmpty;

    if (userTireWheelController.isLoading.value) {
      return const Center(child: CircularProgressIndicator(color: yellowColor));
    }

    if (!hasRecords) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: customText(
            text: "No Retread/Damage Records Available",
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

        // --- 1. DAMAGE REPORTS TIMELINE (Uncommented and Fixed) ---
        if (damageDateKeys.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w,top: 2.h),
                child: customText(
                    text: 'Puncture History',
                    fontSize: 15.sp
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Crucial for nesting
                  itemCount: damageDateKeys.length, // Use Damage keys
                  itemBuilder: (context, dateIndex) {
                    final date = damageDateKeys[dateIndex]; // Use Damage date
                    final recordsForDate = damagesByDate[date]!;

                    // Calculate timeline height
                    double heightPerItem = 40.0;
                    if (recordsForDate.length > 1) {
                      // Adjusted for better visual stacking
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

                              /// INNER LIST BUILDER (Damage Reports of that date)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: recordsForDate.length,
                                itemBuilder: (context, recordIndex) {
                                  final item = recordsForDate[recordIndex];
                                  final sameData = userTireWheelController.getTireByIdModel.value?.data;

                                  return reminderWidget(
                                    sameData?.vehicalNumber ?? "-",
                                    sameData?.brand ?? "-",
                                    sameData?.tireSize ?? "-",
                                    "Damage Report", // Explicitly labeled
                                    item?.dateOfEntry ?? "-", // dateOfEntry exists in ReportDamage
                                    item?.location ?? "-", // Use damage location as position
                                    sameData?.serialNumber ?? "-",
                                    "${sameData?.tireHealth ?? 0}",
                                    width: 78.w,
                                    namesize: 16.sp,
                                    modelsize: 14.sp,
                                    tirewidgetfontsize: 13.sp,
                                    buttoncheaque: false,
                                    inusesize: 13.sp,
                                    damagetype: _getDamageType(item), // Use the specific damage type
                                    estimatedreturndate: null,
                                    retreadcentername: null,
                                    spend: "0",
                                    damagereport: formatDate(item?.dateOfEntry),
                                    status: sameData?.status ?? "-",
                                    index: recordIndex,
                                    onNextTap: () {
                                      // Navigate to tire detail with report ID if needed
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
            ],
          ),


        // --- 2. RETHREAD RECORDS TIMELINE (Existing Code with minor cleanup) ---
        if (retreadDateKeys.isNotEmpty)
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w,),
                child: customText(
                  text: 'Rethread History',
                  fontSize: 15.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Crucial for nesting
                  itemCount: retreadDateKeys.length, // Use Retread keys
                  itemBuilder: (context, dateIndex) {
                    final date = retreadDateKeys[dateIndex]; // Use Retread date
                    final tiresForDate = retreadsByDate[date]!;

                    // Calculate timeline height
                    double heightPerItem = 40.0;
                    if (tiresForDate.length > 1) {
                      heightPerItem -= 3.0 + ((tiresForDate.length - 1) * 0.085); // Adjusted for better visual stacking
                    }
                    double timelineHeight = (heightPerItem * tiresForDate.length).h;

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
                                itemCount: tiresForDate.length,
                                itemBuilder: (context, tireIndex) {
                                  final item = tiresForDate[tireIndex];
                                  final sameData = userTireWheelController.getTireByIdModel.value?.data;

                                  return reminderWidget(
                                    sameData?.vehicalNumber ?? "",
                                    sameData?.brand ?? "",
                                    sameData?.tireSize ?? "",
                                    "Retread",
                                    item?.dateOfDamage ?? "", // Use dateOfDamage for the primary date
                                    item?.mountedPosition ?? "",
                                    item?.serialNumber ?? "",
                                    "${item?.tireHealth ?? 0}",
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
                                    damagereport: formatDate(item?.dateOfDamage),
                                    status: sameData?.status ?? "",
                                    index: tireIndex,
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
          ),
      ],
    );
  }
}
  Widget threadDepthWidget(
      String title,
      double? value,
      Color color,
      int amount,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Fixed-width label
          SizedBox(
            width: 22.w, // ✅ Equal width for all labels
            child: customText(
              text: title,
              fontSize: 14.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 3.w),

          // Progress bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.sp),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 3.h,
              ),
            ),
          ),

          SizedBox(width: 3.w),

          // Amount (fixed width helps too if you want)
          SizedBox(
            width: 8.w,
            child: customText(
              text: amount < 10 ? "0$amount" : "$amount",
              fontSize: 14.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

Widget timelineIndicator({int itemCount = 1,Color color = taglinegreyColor}) {
  return Column(
    children: [
      // Circle at the top
      Container(
        width: 4.w,
        height: 2.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 0.2.w),
          color: Colors.white,
        ),
      ),

      // Vertical line
      Expanded(
        child: Container(
          width: 0.3.w,
          height: itemCount * 8.h,
          color: color.withOpacity(0.5),
        ),
      ),
    ],
  );
}
Color? getDisposedColor(String status){
  if(status == "disposed" || status == "dismounted"){
    return redColor.withAlpha(80);
  }
  else{
    return containerGreenColor;
  }

}
