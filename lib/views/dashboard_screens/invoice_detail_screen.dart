import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/success_dialog.dart';

class InvoiceDetailScreen extends StatelessWidget {
  const InvoiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 0,
        leading: backButton(),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: customText(
            text: "Invoice Details",
            fontSize: 18..sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Column(
            children: [

              /// -----------------------------------
              /// INVOICE HEADER CARD
              /// -----------------------------------
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 1,
                      blurRadius: 6,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Invoice No + Pending Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                              text: "Invoice No.",
                              fontSize: 14.sp,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withValues(alpha: 0.6),
                              height: 1.2
                            ),
                            customText(
                              text: "INV-1172",
                              fontSize: 15.sp,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                              height: 1
                            ),
                          ],
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: billingLightYellowColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: customText(
                            text: "Pending Payment",
                            fontSize: 13.sp,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            color: invoiceOrangeColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    /// Due Date & Service Type
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                                text: "Due Date",
                                fontSize: 14.sp,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withValues(alpha: 0.6),
                                height: 1.2
                            ),
                            customText(
                                text: "Nov 20, 2025",
                                fontSize: 15.sp,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w600,
                                height: 1
                            ),
                          ],
                        ),


                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                                text: "Service Type",
                                fontSize: 14.sp,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withValues(alpha: 0.6),
                                height: 1.2
                            ),
                            customText(
                                text: "Tire Repair",
                                fontSize: 15.sp,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w600,
                                height: 1
                            ),
                          ],
                        ),

                      ],
                    ),

                    SizedBox(height: 2.h),

                    Divider(color: Colors.black.withValues(alpha: 0.2),),

                    SizedBox(height: 2.h),

                    customText(
                        text: "Amount Due",
                        fontSize: 14.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withValues(alpha: 0.6),
                        height: 1
                    ),

                    //SizedBox(height: 0.5.h),

                    customText(
                      text: "\$567.00",
                      fontSize: 18.sp,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),

              /// -----------------------------------
              /// DETAILS SECTION
              /// -----------------------------------
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 1,
                      blurRadius: 6,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: "Details",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        const Icon(Icons.keyboard_arrow_up, color: Colors.black26,),
                      ],
                    ),

                    SizedBox(height: 2.h),



                    //SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Puncture Repair
                            customText(
                                text: "Items",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: invoiceGreyColor,
                                fontFamily: 'Roboto'

                            ),
                            customText(
                                text: "Puncture Repair",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: invoiceGreyColor,
                              height: 1,
                                fontFamily: 'Roboto'

                            ),
                            SizedBox(height: 0.2.h),
                            customText(
                                text: '2 x \$45.00',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: invoiceGreyColor,
                              height: 1,
                                fontFamily: 'Roboto'

                            ),
                          ],
                        ),
                        customText(
                          text: "\$90.00",
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto'

                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    /// Inspection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Puncture Repair
                            customText(
                                text: "Inspection",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: invoiceGreyColor,
                                fontFamily: 'Roboto'

                            ),
                            customText(
                                text: "Complete Tire Inspection",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: invoiceGreyColor,
                                height: 1,
                                fontFamily: 'Roboto'

                            ),
                            SizedBox(height: 0.2.h),
                            customText(
                                text: '8 x \$53.13',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: invoiceGreyColor,
                                height: 1,
                                fontFamily: 'Roboto'

                            ),
                          ],
                        ),
                        customText(
                          text: "\$425.00",
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto'
                        ),
                      ],
                    ),

                    SizedBox(height: 1.5.h),
                    Divider(),
                    SizedBox(height: 1.5.h),

                    /// Subtotal
                    rowText("Subtotal", "\$515.00"),
                    SizedBox(height: 1.h),

                    /// Tax
                    rowText("Tax", "\$42.00"),
                    SizedBox(height: 1.h),

                    /// Fees
                    rowText("Fees", "\$10.00"),
                    SizedBox(height: 1.5.h),

                    Divider(),

                    SizedBox(height: 1.5.h),

                    rowText(
                      "Total",
                      "\$567.00",
                      isBold: true,
                    ),

                    SizedBox(height: 3.h),

                    /// Buttons
                    Row(
                      children: [
                        Expanded(
                          child: buttonWidget(
                    "Pay Now",
                      Colors.black,             // textColor
                      colors: Colors.amber,     // background
                      fontsize: 13.sp,
                      radius: 10.sp,
                      fontfaimly: "Roboto",
                      fontweight: FontWeight.w700,
                      height: 4.h,
                      onTap: () {
                        successDialog(
                          context,
                          "Your invoice has been sent to your email.",
                          "Ok",
                          title: "Payment Successful!",
                              () {
                            Get.back();
                          },
                        );
                      },
                    ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: buttonWidget(
                            "Download",
                            Colors.black,          // textColor
                            colors: Colors.white,  // button background
                            borderColor: Colors.grey.shade400,
                            fontsize: 13.sp,
                            radius: 10.sp,
                            fontfaimly: "Roboto",
                            fontweight: FontWeight.w600,
                            height: 4.h,
                            onTap: () {},
                          )

                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable row widget
  Widget rowText(String left, String right, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customText(
          text: left,
          fontSize: 14.sp,
          color: invoiceGreyColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto'
        ),
        customText(
          text: right,
          fontSize: 14.5.sp,
          color: invoiceGreyColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto'
        ),
      ],
    );
  }
}



