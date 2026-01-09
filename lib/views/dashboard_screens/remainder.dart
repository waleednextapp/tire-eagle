import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/reminder_controller.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_screens/tire_detail.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_screens/total_wheels.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';
import 'fleet_home_screen.dart';

class Remainder extends StatelessWidget {
  Remainder({super.key});
  final ReminderController controller = Get.put(ReminderController());

  @override
  Widget build(BuildContext context) {
    // Load both APIs once when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if data is not already loaded
      if (controller.tireReminders.value == null) {
        controller.TireReminder(type: "Tire", page: 1);
      }
      if (controller.wheelReminders.value == null) {
        controller.TireReminder(type: "Wheel", page: 1);
      }
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: customText(
            text: "Reminder",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: Column(
        children: [
          // Tabs (Tire/Wheel)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
            child: Obx(
                  () => Row(
                children: List.generate(controller.RemainderTabs.length, (index) {
                  bool isSelected = controller.selectedRemainderIndex.value == index;
                  return Padding(
                    padding: EdgeInsets.only(
                        right: index == controller.RemainderTabs.length - 1 ? 0 : 2.w),
                    child: InkWell(
                      onTap: () {
                        // Just switch the tab, don't call API again
                        controller.selectRemainderValue(index);
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
                          text: controller.RemainderTabs[index],
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
          ),

          // Reminder List with Date Grouping
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(color: yellowColor));
              }

              List<dynamic> data = controller.selectedRemainderIndex.value == 0
                  ? controller.tireReminders.value?.data ?? []
                  : controller.wheelReminders.value?.data ?? [];

              if (data.isEmpty) {
                return Center(
                  child: Text(
                    controller.selectedRemainderIndex.value == 0
                        ? "No tire reminders available"
                        : "No wheel reminders available",
                  ),
                );
              }

              // Group by createdAt date
              Map<String, List<dynamic>> groupedData = {};
              for (var item in data) {
                DateTime dt = DateTime.parse(item.createdAt);
                String dateKey =
                    "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
                if (!groupedData.containsKey(dateKey)) {
                  groupedData[dateKey] = [];
                }
                groupedData[dateKey]!.add(item);
              }

              // Sort dates descending
              final sortedDates = groupedData.keys.toList()
                ..sort((a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)));

              // Build list
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                itemCount: sortedDates.length + 1, // +1 for pagination at end
                itemBuilder: (context, dateIndex) {
                  if (dateIndex == sortedDates.length) {
                    // Pagination controls at end
                    return Obx(() => buildPaginationControls(
                      currentPage: controller.currentRemindersPage.value,
                      totalPages: controller.totalRemindersPages.value,
                      hasPrevPage: controller.currentRemindersPage.value > 1,
                      hasNextPage: controller.hasNextRemindersPage.value,
                      onPrev: controller.loadPrevReminderPage,
                      onNext: controller.loadNextReminderPage,
                      isLoading: controller.isLoading.value,
                    ));
                  }

                  String date = sortedDates[dateIndex];
                  List<dynamic> items = groupedData[date]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date header
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                        child: customText(
                          text: formatDate(date),
                          fontSize: 14.sp,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      // Cards for this date
                      ...items.map((r) {
                        if (controller.selectedRemainderIndex.value == 0) {
                          // Tire
                          return reminderWidget(
                            r?.vehicalNumber ?? '-',
                            r?.brand ?? '-',
                            r?.tireSize ?? '-',
                            "",
                            formatDate(r?.updatedAt ?? '-'),
                            r?.mountedPosition ?? '-',
                            r?.serialNumber ?? '-',
                            (r?.tireHealth ?? 0).toString(),
                            buttonText: "Sent Remainder",
                            isHistory: true,
                            status: r?.status,
                            plyRating: r?.plyRating ?? '-',
                            sizedBoxWidth: 25.w,
                            ontap: () {
                              showSetReminderBottomSheet(context);
                            },
                          );
                        } else {
                          // Wheel
                          return reminderWidget(
                            r?.vehicalNumber ?? '-',
                            r?.material ?? '-',
                            r?.wheelSize ?? '-',
                            "",
                            formatDate(r?.updatedAt ?? '-'),
                            r?.mountedPosition ?? '-',
                            r?.serialNumber ?? '-',
                            (r?.wheelHealth ?? 0).toString(),
                            buttonText: "Sent Remainder",
                            isHistory: true,
                            status: r?.status,
                            plyRating: r?.wheelCondition ?? '-',
                            sizedBoxWidth: 25.w,
                            ontap: () {
                              showSetReminderBottomSheet(context);
                            },
                          );
                        }
                      }).toList(),

                    ],
                  );
                },
              );
            }),
          ),
          SizedBox(height: 4.h)
        ],
      ),
    );
  }
}
Widget reminderWidget(
    String name,
    String model,
    String size,
    String maintenance,
    String date,
    String position,
    String SerialNo,
    String tirehealth,
    {
      int? index,
      double? width,
      double? namesize,
      double? modelsize,
      double? tirewidgetfontsize,
      double? inusesize,
      bool? buttoncheaque = true,
      double? customheight,
      String? damagetype,
      String? estimatedreturndate,
      String? damagereport,
      String? retreadcentername,
      String? spend,
      VoidCallback? ontap,
      VoidCallback? onNextTap,
      String? status,
      double? sizedBoxWidth,
      bool? isHistory = false,
      String? plyRating,
      String? buttonText,
    }
    ) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
    child: InkWell(
      onTap: onNextTap,
      child: Container(
        height: buttoncheaque == true ? 32.h : customheight,
        width: width != null ? width : 120.w,

        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      customText(
                        text: name,
                        fontSize: namesize != null ? namesize : 19.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                      ),
                      customText(
                        text: model,
                        fontSize: modelsize!=null ? modelsize : 14.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      color: getDisposedColor(status ?? ''),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 0.5.h,
                      ),
                      child: customText(
                        text: "$status",
                        fontSize: inusesize!=null ? inusesize : 14.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                        color: status == "disposed" || status == "dismounted" ? redColor:textGreenColor
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Size",
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        fontFamily: buttoncheaque == true ? "Roboto" : "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: size,
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        fontFamily: buttoncheaque == true ? "Barlow": "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      isHistory == true ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          customText(
                            text: "Ply Rating",
                            fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                            fontFamily: buttoncheaque == true ? "Roboto" : "Barlow",
                            fontWeight: FontWeight.w400,
                          ),
                          customText(
                            text: plyRating,
                            fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                            fontFamily: buttoncheaque == true ? "Barlow": "Roboto",
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ): SizedBox.shrink(),


                      // SizedBox(height: 1.h),
                      // customText(
                      //   text: "Maintenance",
                      //   fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                      //   fontFamily: buttoncheaque == true ? "Roboto" : "Barlow",
                      //   fontWeight: FontWeight.w400,
                      // ),
                      // customText(
                      //   text: maintenance,
                      //   fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                      //   fontFamily: buttoncheaque == true ? "Barlow": "Roboto",
                      //   fontWeight: FontWeight.w400,
                      // ),
                      SizedBox(height: 1.h),
                      damagetype !=null ?
                      customText(
                        text: "Damage Type",
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        fontFamily: buttoncheaque == true ? "Roboto" : "Barlow",
                        fontWeight: FontWeight.w400,
                      ):
                      customText(
                        text: "Last Date",
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        fontFamily: buttoncheaque == true ? "Roboto" : "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      damagetype != null ?
                      customText(
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        text: damagetype,
                        fontFamily: buttoncheaque == true ? "Barlow": "Roboto",
                        fontWeight: FontWeight.w400,
                      ):
                      customText(
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        text: date,
                        fontFamily: buttoncheaque == true ? "Barlow": "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      if (buttoncheaque == true)
                        SizedBox.shrink()
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),
                            customText(
                              text: "Estimated Return Date",
                              fontSize: tirewidgetfontsize ?? 14.sp,
                              fontFamily: buttoncheaque == true ? "Roboto" : "Barlow",
                              fontWeight: FontWeight.w400,
                            ),
                            customText(
                              fontSize: tirewidgetfontsize ?? 14.sp,
                              text: estimatedreturndate??"-",
                              fontFamily: buttoncheaque == true ? "Barlow": "Roboto",
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 1.h),
                            customText(
                              text: "Retread Center Name",
                              fontSize: tirewidgetfontsize ?? 14.sp,
                              fontFamily: buttoncheaque == true ? "Roboto" : "Barlow",
                              fontWeight: FontWeight.w400,
                            ),
                            customText(
                              fontSize: tirewidgetfontsize ?? 14.sp,
                              text: retreadcentername,
                              fontFamily: buttoncheaque == true ? "Barlow": "Roboto",
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                    ],
                  ),
SizedBox(width: sizedBoxWidth ?? 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Position",
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        fontFamily: buttoncheaque == true ? "Roboto" : "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: position,
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        fontFamily: buttoncheaque == true ? "Barlow": "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.h),
                      customText(
                        text: "Serial Number",
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        fontFamily: buttoncheaque == true ? "Roboto" : "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        text: SerialNo,
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        fontFamily: buttoncheaque == true ? "Barlow": "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 1.h),
                      customText(
                        text: "Health",
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        fontFamily: buttoncheaque == true ? "Roboto" : "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                      customText(
                        fontSize: tirewidgetfontsize!=null?tirewidgetfontsize:14.sp,
                        text: "${tirehealth} \%",
                        color: getTireColor(int.parse(tirehealth.toString())),
                        fontFamily: buttoncheaque == true ? "Barlow": "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                      if (buttoncheaque == true)
                        SizedBox.shrink()
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),
                            customText(
                              text: "Damage Report",
                              fontSize: tirewidgetfontsize ?? 14.sp,
                              fontFamily: "Barlow",
                              fontWeight: FontWeight.w400,
                            ),
                            customText(
                              fontSize: tirewidgetfontsize ?? 14.sp,
                              text: damagereport,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 1.h),
                            customText(
                              text: "Spend",
                              fontSize: tirewidgetfontsize ?? 14.sp,
                              fontFamily: "Barlow",
                              fontWeight: FontWeight.w400,
                            ),
                            customText(
                              fontSize: tirewidgetfontsize ?? 14.sp,
                              text: "${spend} \$",
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                            ),

                          ],
                        ),

                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              buttoncheaque == true
                  ? buttonWidget(
                buttonText ?? "View Detail",
                blackColor,
                colors: yellowColor,
                height: 3.5.h,
                width: double.infinity,
                fontsize: 14.sp,
                onTap: ontap
              )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    ),
  );
}
void showSetReminderBottomSheet(BuildContext context) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  Get.bottomSheet(
    Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.sp),
          topRight: Radius.circular(20.sp),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          customText(
            text: "Send Reminder",
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 2.h),

          // Title TextField
          TextField(
            cursorColor: yellowColor,
            controller: titleController,
            decoration: InputDecoration(
              labelText: "Title",
              labelStyle: TextStyle(
                color: Colors.grey.shade700, // inactive label color
              ),
              floatingLabelStyle: TextStyle(
                color: yellowColor, // color when focused
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.sp),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.sp),
                borderSide: BorderSide(
                  color: yellowColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.sp),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            ),
          ),

          SizedBox(height: 2.h),

          // Message TextField
          TextField(
            cursorColor: yellowColor,
            controller: messageController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: "Message",
              labelStyle: TextStyle(
                color: Colors.grey.shade700, // inactive label color
              ),
              floatingLabelStyle: TextStyle(
                color: yellowColor, // label color when focused
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.sp),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.sp),
                borderSide: BorderSide(
                  color: yellowColor, // focused border color
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.sp),
                borderSide: BorderSide(
                  color: Colors.grey.shade400, // normal border color
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            ),
          ),
          SizedBox(height: 3.h),

          // Send Button
          buttonWidget(
            "Send",
            blackColor,
            colors: yellowColor,
            width: double.infinity,
            height: 4.h,
            fontsize: 14.sp,
            onTap: () {
              String title = titleController.text.trim();
              String message = messageController.text.trim();

              if (title.isEmpty || message.isEmpty) {
                Get.snackbar(
                  "Error",
                  "Please enter both title and message",
                  backgroundColor: redColor,
                  colorText: whiteColor,
                );
                return;
              }

              // Call your controller function to send reminder here
              // controller.sendReminder(title, message);

              // Close bottom sheet
              Get.back();
            },
          ),
          SizedBox(height: 2.h),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
