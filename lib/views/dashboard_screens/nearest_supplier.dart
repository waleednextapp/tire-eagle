import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/views/dashboard_screens/store_screen.dart';
import 'package:tire_eagle/widgets/button_widget.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/back_button.dart';
import '../../widgets/nearest_supplier_bottomsheet.dart';

class NearestSupplier extends StatelessWidget {
  NearestSupplier({super.key});

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
            text: "Nearest Supplier",
            fontSize: 19.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: backButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.h),
              child: Column(
                children: [
                  SizedBox(height: 1.h),
                  TextField(
                    cursorColor: yellowColor,
                    style: TextStyle(fontSize: 15.sp, fontFamily: "Barlow",fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 1.2.h,
                        horizontal: 4.w,
                      ),
                      hintText: 'Street	1049 Ponce De Leon Ave NE',
                      hintStyle: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: "Barlow",
                        color: textFeildTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                      filled: true,
                      fillColor: whiteColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.sp),
                        borderSide: BorderSide(color: borderColor, width: 0.2.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.sp),
                        borderSide: BorderSide(color: borderColor, width: 0.2.w),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 4.w, right: 1.w),
                        child: Image.asset(
                          "assets/png/home_screen_images/pin_point.png",
                          height: 2.h,
                          width: 2.h,
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minHeight: 2.h,
                        minWidth: 2.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listSupplier("assets/png/store_image/tire1.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM",ontap: (){nearestSupplierBottomSheet(context);}),
                      listSupplier("assets/png/store_image/tire2.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM",ontap: (){nearestSupplierBottomSheet(context);}),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listSupplier("assets/png/store_image/tire1.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM",ontap: (){nearestSupplierBottomSheet(context);}),
                      listSupplier("assets/png/store_image/tire2.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM",ontap: (){nearestSupplierBottomSheet(context);}),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listSupplier("assets/png/store_image/tire1.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM",ontap: (){nearestSupplierBottomSheet(context);}),
                      listSupplier("assets/png/store_image/tire2.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM"),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listSupplier("assets/png/store_image/tire1.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM",ontap: (){nearestSupplierBottomSheet(context);}),
                      listSupplier("assets/png/store_image/tire2.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM",ontap: (){nearestSupplierBottomSheet(context);}),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
