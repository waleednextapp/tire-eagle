import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/views/dashboard_screens/remainder.dart';
import 'package:tire_eagle/views/dashboard_screens/tire_detail.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';

class TotalWheels extends StatelessWidget {
  const TotalWheels({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 1.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 6.w,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 75.h, // or any fixed/expanded height
                      child: timelineIndicator(),

                    ),
                    SizedBox(
                      height: 78.h, // or any fixed/expanded height
                      child: timelineIndicator(),

                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: customText(
                      text: "22 April 2025",
                      fontSize: 14.sp,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  reminderWidget(
                      "YXU - 5689",
                      "Michelin XDE2+",
                      "11R22.5",
                      "2nd Puncture",
                      "22 April 2025",
                      "F-Right",
                      "DOT 5478 DC89",
                      "4/32 ---- 🔴 (Replace Now)",
                      width: 78.w,
                      namesize: 16.sp,
                      modelsize: 14.sp,
                      tirewidgetfontsize: 13.sp,
                      buttoncheaque: false,
                      damagetype: "Cut",
                      retreadcentername: "ABC Retread Co.",
                      spend: "105 \$",
                      damagereport: "July 10,2025",estimatedreturndate: "July 15,2025",
                      ontap: (){
                        Get.toNamed("tire");
                      }
                  ),

                  reminderWidget(
                      "YXU - 3689",
                      "Michelin XDE2+",
                      "11R22.5",
                      "2nd Puncture",
                      "22 April 2025",
                      "F-Right",
                      "DOT 5478 DC89",
                      "4/32 ---- 🔴 (Replace Now)",
                      width: 78.w,
                      namesize: 16.sp,
                      modelsize: 14.sp,
                      tirewidgetfontsize: 13.sp,
                      buttoncheaque: false,
                      inusesize: 13.sp,
                      damagetype: "Puncture",
                      retreadcentername: "ABC Retread Co.",
                      spend: "105 \$",
                      damagereport: "July 10,2025",estimatedreturndate: "July 15,2025",
                      ontap: (){
                        Get.toNamed("tire");
                      }
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 1.1.h),
                    child: customText(
                      text: "22 April 2025",
                      fontSize: 14.sp,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  reminderWidget(
                      "YXU - 5689",
                      "Michelin XDE2+",
                      "11R22.5",
                      "2nd Puncture",
                      "22 April 2025",
                      "F-Right",
                      "DOT 5478 DC89",
                      "4/32 ---- 🔴 (Replace Now)",
                      width: 78.w,
                      namesize: 16.sp,
                      modelsize: 14.sp,
                      tirewidgetfontsize: 13.sp,
                      buttoncheaque: false,
                      damagetype: "Cut",
                      retreadcentername: "ABC Retread Co.",
                      spend: "105 \$",
                      damagereport: "July 10,2025",estimatedreturndate: "July 15,2025",
                      ontap: (){
                        Get.toNamed("tire");
                      }
                  ),
                  reminderWidget(
                      "YXU - 3689",
                      "Michelin XDE2+",
                      "11R22.5",
                      "2nd Puncture",
                      "22 April 2025",
                      "F-Right",
                      "DOT 5478 DC89",
                      "4/32 ---- 🔴 (Replace Now)",
                      width: 78.w,
                      namesize: 16.sp,
                      modelsize: 14.sp,
                      tirewidgetfontsize: 13.sp,
                      inusesize: 13.sp,
                      buttoncheaque: false,
                      damagetype: "Puncture",
                      retreadcentername: "ABC Retread Co.",
                      spend: "105 \$",
                      damagereport: "July 10,2025",estimatedreturndate: "July 15,2025",
                      ontap: (){
                        Get.toNamed("tire");
                      }
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
