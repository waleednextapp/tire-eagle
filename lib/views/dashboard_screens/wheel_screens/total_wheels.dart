import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/views/dashboard_screens/remainder.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_screens/tire_detail.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/total_tire_controller.dart';
import '../../../models/wheel_model.dart';
import '../../../widgets/back_button.dart';

class TotalWheels extends StatelessWidget {
  TotalWheels({super.key});
  final TotalTireController controller = Get.find<TotalTireController>();

  @override
  Widget build(BuildContext context) {
    var heightConstant = 19.5;

    return Scaffold(
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
        leading: backButton(),
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await controller.GetAllWheel();
        },
        builder: (BuildContext context, Widget child, IndicatorController controller) {
          return child;
        },
        child: Obx(() {
          if (controller.isLoadingWheel.value) {
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

          return controller.wheelModel.value?.data?.wheels?.length == 0 ?
          Center(
            child: customText(
              text: "No Wheel Available",
              fontSize: 15.sp,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
            ),
          ):
            Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: ListView.builder(
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
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: wheelsForDate.length,
                            itemBuilder: (context, wheelIndex) {
                              final item = wheelsForDate[wheelIndex];

                              String getDamageType() {
                                final cut = item.damageInfo?.damageType?.cut ?? 0;
                                final bulge = item.damageInfo?.damageType?.bulge ?? 0;
                                if (cut > 0) return "Cut";
                                if (bulge > 0) return "Bulge";
                                return "-";
                              }

                              return reminderWidget(
                                item.vehicalNumber ?? "",
                                item.material ?? "",
                                item.wheelSize ?? "",
                                "0",
                                item.dateOfEntry ?? "",
                                item.mountedPosition ?? "",
                                item.serialNumber ?? "",
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
                                onNextTap: () => Get.toNamed("wheeldetails", arguments: item.id ?? ""),
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
