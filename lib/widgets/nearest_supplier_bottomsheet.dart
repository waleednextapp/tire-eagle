import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';

import '../constants/constants_widgets.dart';

void nearestSupplierBottomSheet(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: whiteColor,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.sp), topLeft: Radius.circular(20.sp)
              ),
              child: Stack(
                children: [
                  // MAP IMAGE
                  Image.asset(
                    "assets/png/home_screen_images/location_map.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  // CLOSE ICON (TOP RIGHT)
                  Positioned(
                    top: 1.5.h,
                    right: 1.5.h,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(0.3.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 1.5.h,
                    right: 1.5.h,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(0.3.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Image.asset("assets/png/home_screen_images/pinpoint_icon.png",width: 5.5.w,)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      customText(
                        text: "Nearest Tire Station",
                        fontSize: 17.sp,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: 2.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 1.3.w, vertical: 0.3.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15.w),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                              size: 14.5.sp,
                            ),
                            customText(
                              text: '4.8',
                              fontSize: 12.5.sp,
                              fontFamily: "Degular",
                              fontWeight: FontWeight.w600,
                              color: blackColor,
                            ),


                          ],
                        ),
                      ),
                      Spacer(),
                      customText(
                        text: '14 km Away',
                        fontSize: 14.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: 'Supplier Name:',
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w400,
                            color: nearestGreyColor,
                          ),
                          customText(
                            text: 'John Silva',
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w500,
                            color: nearestGreyColor,
                          ),
                          SizedBox(height: 1.h),
                          customText(
                            text: 'Phone Number',
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w400,
                            color: nearestGreyColor,
                          ),
                          customText(
                            text: '+1  21  548  302  6485',
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w500,
                            color: nearestGreyColor,
                          ),
                        ],
                      ),
                      SizedBox(width: 7.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: 'Working Hours',
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w400,
                            color: nearestGreyColor,
                          ),
                          customText(
                            text: '11:00 AM - 12:00 PM',
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w500,
                            color: nearestGreyColor,
                          ),
                          SizedBox(height: 1.h),
                          customText(
                            text: 'Email',
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w400,
                            color: nearestGreyColor,
                          ),
                          customText(
                            text: 'eagle.runner@xyz.com',
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w500,
                            color: nearestGreyColor,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
