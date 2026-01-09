import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/controllers/billing_and_invoice_controller.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/setting_controller.dart';
import '../../widgets/back_button.dart';

class BillingAndInvoices extends StatelessWidget {
  BillingAndInvoices({super.key});

  final SettingController controller = Get.find<SettingController>();
  final BillingAndInvoiceController billingcontroller = Get.find<BillingAndInvoiceController>();

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
            text: "Billing & Invoices",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: Obx(
            () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
          child: Column(
            children: [
              rowBar(controller),
              controller.selectedTab.value == 0

              /// ---------------- ALL (4) ----------------
                  ? Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  padding: EdgeInsets.only(top: 1.h),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: bills(status: index < 3 ? true : false),
                    );
                  },
                ),
              )

              /// ---------------- PENDING (1) ----------------
                  : controller.selectedTab.value == 1
                  ? Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  padding: EdgeInsets.only(top: 1.h),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: bills(status: true),
                    );
                  },
                ),
              )

              /// ---------------- PAID (3) ----------------
                  : controller.selectedTab.value == 2
                  ? Expanded(
                child: ListView.builder(
                  itemCount: 2,
                  padding: EdgeInsets.only(top: 1.h),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: bills(status: false),
                    );
                  },
                ),
              )

                  : Container()

            ],
          ), // Default case
        ),
      ),
    );
  }
}

Widget rowBar(SettingController controller) {
  final BillingAndInvoiceController billingcontroller = Get.find<BillingAndInvoiceController>();
  return Container(
    color: whiteColor,
    padding: EdgeInsets.only(top: 1.5.h),
    child: Column(
      children: [
        /// --- TAB ROW ---
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  billingcontroller.GetAllBillingAndInvoices("all");
           controller.changeTab(0);
  } ,
                child: customText(
                  text: "All (4)",
                  fontSize: 13.sp,
                  fontFamily: "Barlow",
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
              onTap: () {
              controller.changeTab(1);
              },
                child: customText(
                  text: "Pending (1)",
                  fontSize: 13.sp,
                  fontFamily: "Barlow",
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
  onTap: () {
  controller.changeTab(2);
  },
                child: customText(
                  text: "Paid (3)",
                  fontSize: 13.sp,
                  fontFamily: "Barlow",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

        SizedBox(height: 1.5.h),

        /// --- BOTTOM LINES ---
        Obx(
              () => Stack(
            children: [
              /// Grey full line
              Container(
                height: 0.15.h,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),

              /// Yellow underline
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                top: 0,
                left: controller.selectedTab.value == 0
                    ? 0
                    : controller.selectedTab.value == 1
                    ? (Get.width - 12.w) * 0.33 // subtract total horizontal padding
                    : (Get.width - 12.w) * 0.66,
                child: Container(
                  height: 0.25.h,
                  width: (Get.width - 12.w) * 0.33, // reduce width to fit padding
                  color: yellowColor,
                ),
              ),
            ],
          ),
        ),

      ],
    ),
  );
}
Widget bills({bool? status, bool? isdownload}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(15.sp),
      border: Border.all(color: textFeildBorderColor, width: 0.2.w),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05), // subtle shadow
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 2), // vertical offset
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              customText(
                text: "INV-1203",
                fontSize: 16.sp,
                fontFamily: "Barlow",
                fontWeight: FontWeight.w600,
              ),
              SizedBox(width: 4.w),
              Container(
                decoration: BoxDecoration(
                  color: status == true ? billingLightGreenColor : billingLightYellowColor,
                  borderRadius: BorderRadius.circular(15.sp),
                  border: Border.all(
                      color: status == true ? billingBorderGreenColor:billingBorderYellowColor, width: 0.1.w
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.35.h),
                  child: customText(
                    text: "Paid",
                    fontSize: 13.5.sp,
                    fontFamily: "Barlow",
                    fontWeight: FontWeight.w500,
                    color: status == true ? billingGreenColor : billingYellowColor,
                  ),
                ),
              ),
              Spacer(),
              customText(
                text: "\$1245.00",
                fontSize: 16.sp,
                fontFamily: "Barlow",
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(height: 0.7.h),
          isdownload == true ? Row(
            children: [
              customText(
                text: "Wheel Alignment",
                fontSize: 15.sp,
                fontFamily: "Barlow",
                fontWeight: FontWeight.w500,
                color: billingBorderGreyColor,
              ),
              Spacer(),
              Image.asset('assets/png/setting_icon/download.png', width: 4.w),
            ],
          ): customText(
            text: "Wheel Alignment",
            fontSize: 15.sp,
            fontFamily: "Barlow",
            fontWeight: FontWeight.w500,
            color: billingBorderGreyColor,
          ),
          customText(
            text: "Paid on: Oct 25, 2025",
            fontSize: 15.sp,
            fontFamily: "Barlow",
            fontWeight: FontWeight.w500,
            color: billingBorderGreyColor,
          ),
        ],
      ),
    ),
  );
}

