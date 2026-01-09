import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/views/dashboard_screens/remainder.dart';
import 'package:tire_eagle/widgets/button_widget.dart';
import 'package:tire_eagle/widgets/report_dialog.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/dashboard_controller.dart';
import '../../../models/historyandreportmodel.dart'; // Ensure HistoryAndReportEntry, Tiresfull, Wheels are here
import '../../../widgets/header_widget.dart';
import '../wheel_screens/total_wheels.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  // Access the single instance of the controller
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // --- Reactive search and tab state ---
        final bool isSearching = controller.historySearchController.text.isNotEmpty;
        final bool isTireTab = controller.selectedHistoryIndex.value == 0;

        // --- FIXED: Determine data list based on search state ---
        // If searching: dataList contains flat, filtered results (List<Tiresfull> or List<Wheels>)
        // If not searching: dataList contains grouped results (List<HistoryAndReportEntry>)
        final List dataList = isSearching
            ? (isTireTab ? controller.historyFilteredTires.value : controller.historyFilteredWheels.value)
            : controller.historyModel.value?.data?.entries ?? [];

        // --- Check empty state ---
        final bool showEmptyState = dataList.isEmpty;

        return Column(
          children: [
            // --- Header & Search Bar ---
            Container(
              color: whiteColor,
              padding: EdgeInsets.only(top: 7.h, left: 6.w, right: 6.w, bottom: 2.h),
              child: Column(
                children: [
                  headerWidget(
                    "History & Reports",
                        () {},
                    "Search By Serial Number",
                    controller: controller.historySearchController,
                    onChanged: (value) {
                      controller.historySearchQuery.value = value;
                      // Calls the updated searchHistory in the controller
                      controller.searchHistory(controller.selectedHistoryIndex.value, value);
                    },
                  ),
                  SizedBox(height: 2.h),
                  // ... Report Tabs UI (Filter buttons) ...
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(controller.reportTabs.length, (index) {
                        bool isSelected = controller.reportIndexTab.value == index;
                        bool isLastIndex = index == controller.reportTabs.length - 1;

                        return Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: GestureDetector(
                            onTap: () {
                              controller.reportValuetoggle(index);
                              controller.historySearchController.clear();
                              controller.historyFilteredTires.clear();
                              controller.historyFilteredWheels.clear();

                              // Reset and fetch data based on the new tab selection
                              if (index == 0) {
                                controller.GetHistoryAndReport(quickRange: "lastWeek");
                              } else if (index == 1) {
                                controller.GetHistoryAndReport(quickRange: "lastMonth");
                              } else if (index == 2) {
                                controller.GetHistoryAndReport(quickRange: "last3Months");
                              } else if (index == 3) {
                                // Custom filter logic
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp)),
                                  ),
                                  builder: (_) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).viewInsets.bottom,
                                      top: 2.h,
                                      left: 4.w,
                                      right: 4.w,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Filter Report", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                        SizedBox(height: 2.h),
                                        // Start Date
                                        TextField(
                                          controller: controller.startDate,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: "Start Date",
                                            labelStyle: TextStyle(color: brownColor, fontWeight: FontWeight.w500, fontFamily: "Barlow"),
                                            filled: true,
                                            fillColor: Colors.grey.shade200,
                                            contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.calendar_today, color: brownColor),
                                              onPressed: () => controller.pickDate(context, controller.startDate),
                                            ),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.sp), borderSide: BorderSide.none),
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        // End Date
                                        TextField(
                                          controller: controller.endDate,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: "End Date",
                                            labelStyle: TextStyle(color: brownColor, fontWeight: FontWeight.w500, fontFamily: "Barlow"),
                                            filled: true,
                                            fillColor: Colors.grey.shade200,
                                            contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.calendar_today, color: brownColor),
                                              onPressed: () => controller.pickDate(context, controller.endDate),
                                            ),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.sp), borderSide: BorderSide.none),
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        buttonWidget(
                                          'Apply Filter',
                                          colors: brownColor,
                                          whiteColor,
                                          onTap: () async {
                                            await controller.GetHistoryAndReport(
                                              startDate: controller.startDate.text,
                                              endDate: controller.endDate.text,
                                            );
                                            controller.startDate.clear();
                                            controller.endDate.clear();
                                            Get.back();
                                          },
                                        ),
                                        SizedBox(height: 4.h),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.3.w, vertical: 0.7.h),
                              decoration: BoxDecoration(
                                color: isSelected ? brownColor : brownColor.withAlpha(40),
                                borderRadius: BorderRadius.circular(30.sp),
                              ),
                              child: Row(
                                children: [
                                  if (isLastIndex) ...[
                                    Image.asset(
                                      'assets/png/filter_icon.png',
                                      height: 16.sp,
                                      width: 16.sp,
                                      color: isSelected ? whiteColor : brownColor,
                                    ),
                                    SizedBox(width: 2.w),
                                  ],
                                  customText(
                                    text: controller.reportTabs[index],
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
                ],
              ),
            ),

            SizedBox(height: 1.h),

            // --- History Tabs (Tires/Wheels) ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Row(
                children: List.generate(controller.historyTabs.length, (index) {
                  bool isSelected = controller.selectedHistoryIndex.value == index;
                  return Padding(
                    padding: EdgeInsets.only(right: index == controller.historyTabs.length - 1 ? 0 : 2.w),
                    child: InkWell(
                      onTap: () {
                        controller.selectHistoryValue(index);
                        controller.historySearchController.clear();
                        controller.historyFilteredTires.clear();
                        controller.historyFilteredWheels.clear();
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
                          text: controller.historyTabs[index],
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

            SizedBox(height: 1.h),

            // --- Reports List ---
            Expanded(
              child: controller.isLoading.value
                  ? Center(child: CircularProgressIndicator(color: yellowColor))
                  : showEmptyState
                  ? Center(
                child: customText(
                  text: isTireTab
                      ? (isSearching ? "No matching Tire found" : "No Tire History Found")
                      : (isSearching ? "No matching Wheel found" : "No Wheel History Found"),
        fontSize: 15.sp,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.zero,
                // Pagination controls are only shown when NOT searching.
                itemCount: isSearching ? dataList.length : dataList.length + 1,
                itemBuilder: (context, index) {
                  // --- Pagination Controls (Only when not searching) ---
                  if (!isSearching && index == dataList.length) {
                    return Obx(
                          () => Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                        child: buildPaginationControls(
                          currentPage: controller.currentHistoryPage.value,
                          totalPages: controller.totalHistoryPages.value,
                          hasPrevPage: controller.currentHistoryPage.value > 1,
                          hasNextPage: controller.hasNextHistoryPage.value,
                          onPrev: controller.loadPrevHistoryPage,
                          onNext: controller.loadNextHistoryPage,
                          isLoading: controller.isLoading.value,
                        ),
                      ),
                    );
                  }

                  // --- Tire Tab Logic ---
                  if (isTireTab) {
                    // --- Search Mode: dataList is List<Tiresfull> ---
                    if (isSearching) {
                      final tire = dataList[index] as Tiresfull;
                      // Renders single widget for searched tire
                      return reminderWidget(
                        tire.vehicalNumber ?? "",
                        tire.brand ?? "",
                        tire.tireSize ?? "",
                        "", // 4th parameter not used for tires in your original code
                        '-',
                        tire.mountedPosition ?? "",
                        tire.serialNumber ?? "",
                        tire.tireHealth?.toString() ?? "0",
                        width: 88.w,
                        namesize: 17.sp,
                        modelsize: 14.sp,
                        tirewidgetfontsize: 14.sp,
                        inusesize: 14.sp,
                        customheight: 29.h,
                        sizedBoxWidth: 25.w,
                        status: tire.status,
                        isHistory: true,
                        plyRating: tire.plyRating,
                        ontap: () {
                          Get.toNamed("tire",arguments: tire.id ?? "");
                        }
                      );
                    } else {
                      // --- Non-Search Mode: dataList is List<HistoryAndReportEntry> ---
                      final entry = dataList[index] as Entries;
                      final tires = entry.tires ?? [];
                      if (tires.isEmpty) return SizedBox.shrink();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: customText(
                              text: entry.date ?? "",
                              fontSize: 14.sp,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          // Map over the tires in this entry
                          ...tires.map((t) => reminderWidget(
                            t.vehicalNumber ?? "",
                            t.brand ?? "",
                            t.tireSize ?? "",
                            "",
                            entry.date ?? "",
                            t.mountedPosition ?? "",
                            t.serialNumber ?? "",
                            t.tireHealth?.toString() ?? "0",
                            width: 88.w,
                            namesize: 17.sp,
                            modelsize: 14.sp,
                            tirewidgetfontsize: 14.sp,
                            inusesize: 14.sp,
                            customheight: 29.h,
                            sizedBoxWidth: 25.w,
                            status: t.status,
                            isHistory: true,
                            plyRating: t.plyRating,
                              ontap: () {
                                Get.toNamed("tire",arguments: t.id ?? "");
                              }
                          )).toList(),
                        ],
                      );
                    }
                  } else {
                    // --- Wheel Tab Logic ---
                    // --- Search Mode: dataList is List<Wheels> ---
                    if (isSearching) {
                      final wheel = dataList[index] as Wheels;
                      // Renders single widget for searched wheel
                      return reminderWidget(
                        wheel.vehicalNumber ?? "",
                        wheel.material ?? "",
                        wheel.wheelSize ?? "",
                        wheel.wheelCondition ?? "",
                        '-',
                        wheel.mountedPosition ?? "-",
                        wheel.serialNumber ?? "",
                        wheel.wheelHealth?.toString() ?? "0",
                        width: 88.w,
                        namesize: 17.sp,
                        modelsize: 14.sp,
                        tirewidgetfontsize: 14.sp,
                        inusesize: 14.sp,
                        customheight: 29.h,
                        sizedBoxWidth: 25.w,
                        status: wheel.status,
                        isHistory: true,
                        plyRating: wheel.wheelCondition ?? "-",
                          ontap: () {
                            Get.toNamed("wheeldetails",arguments: wheel.id ?? "");
                          }
                      );
                    } else {
                      // --- Non-Search Mode: dataList is List<HistoryAndReportEntry> ---
                      final entry = dataList[index] as Entries;
                      final wheels = entry.wheels ?? [];
                      if (wheels.isEmpty) return SizedBox.shrink();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: customText(
                              text: entry.date ?? "",
                              fontSize: 14.sp,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          // Map over the wheels in this entry
                          ...wheels.map((w) => reminderWidget(
                            w.vehicalNumber ?? "",
                            w.material ?? "",
                            w.wheelSize ?? "",
                            w.wheelCondition ?? "",
                            entry.date ?? "",
                            w.mountedPosition ?? "-",
                            w.serialNumber ?? "",
                            w.wheelHealth?.toString() ?? "0",
                            width: 88.w,
                            namesize: 17.sp,
                            modelsize: 14.sp,
                            tirewidgetfontsize: 14.sp,
                            inusesize: 14.sp,
                            customheight: 29.h,
                            sizedBoxWidth: 25.w,
                            status: w.status,
                            isHistory: true,
                            plyRating: w.wheelCondition ?? "-",
                              ontap: () {
                                Get.toNamed("wheeldetails",arguments: w.id ?? "");
                              }
                          )).toList(),
                        ],
                      );
                    }
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
