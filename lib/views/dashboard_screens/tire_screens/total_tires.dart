import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/views/dashboard_screens/remainder.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_screens/tire_detail.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widgets/back_button.dart';
import '../wheel_screens/total_wheels.dart';

class TotalTires extends StatelessWidget {
  TotalTires({super.key});
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
            text: "Total Tires",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await controller.GetAllTire();
        },
        builder: (BuildContext context, Widget child, IndicatorController controller) {
          return child;
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: yellowColor,));
          }

          // Group tires by dateOfEntry
          Map<String, List<dynamic>> tiresByDate = {};
          for (var tire in controller.tireModel.value?.data?.tires ?? []) {
            final date = tire.dateOfEntry?.split("T").first ?? "";
            if (tiresByDate.containsKey(date)) {
              tiresByDate[date]!.add(tire);
            } else {
              tiresByDate[date] = [tire];
            }
          }

          final dateKeys = tiresByDate.keys.toList();

          return controller.tireModel.value?.data?.tires?.length == 0 ?
          Center(
            child: customText(
              text: "No Tires Available",
              fontSize: 15.sp,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
            ),
          ):
            Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: ListView.builder(
              itemCount: dateKeys.length,
              itemBuilder: (context, dateIndex) {
                final date = dateKeys[dateIndex];
                final tiresForDate = tiresByDate[date]!;
                double height = 40.0;
                if (tiresForDate.length > 1) {
                  height = height - 2.8;
                }

                // Timeline height = number of tires for that date * height constant
                double timelineHeight = (height * tiresForDate.length).h;

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

                          /// INNER LIST BUILDER (Tires of that date)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: tiresForDate.length,
                            itemBuilder: (context, tireIndex) {
                              final item = tiresForDate[tireIndex];

                              String getDamageTypes() {
                                final puncture = item?.damageInfo?.damageType?.puncture ?? 0;
                                final cut = item?.damageInfo?.damageType?.cut ?? 0;
                                final bulge = item?.damageInfo?.damageType?.bulge ?? 0;

                                if (puncture > 0) return "Puncture";
                                if (cut > 0) return "Cut";
                                if (bulge > 0) return "Bulge";

                                return "-";
                              }

                              return reminderWidget(
                                item?.vehicalNumber ?? "",
                                item?.brand ?? "",
                                item?.tireSize ?? "",
                                (item?.damageInfo?.damageType?.puncture ?? 0).toString(),
                                item?.dateOfEntry ?? "",
                                item?.mountedPosition ?? "-",
                                item?.serialNumber ?? "",
                                (item?.tireHealth ?? 0).toString(),
                                width: 78.w,
                                namesize: 16.sp,
                                modelsize: 14.sp,
                                tirewidgetfontsize: 13.sp,
                                buttoncheaque: false,
                                inusesize: 13.sp,
                                damagetype: getDamageTypes(),
                                estimatedreturndate: formatDate(item?.retreadInfo?.estimatedReturnDate ?? "-"),
                                retreadcentername: item?.retreadInfo?.centerName ?? "-",
                                spend: (item?.totalCost ?? '0').toString(),
                                damagereport: formatDate(item?.dateOfEntry),
                                status: item?.status ?? "",
                                index: tireIndex,
                                onNextTap: () { Get.toNamed("tire",arguments: item?.id ?? "");
                                  print(item?.id ?? "");
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
          );
        }),
      ),
    );
  }
}

