import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/widgets/header_widget.dart';

import '../../constants/constants_widgets.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}
final List<String> imgpath =[
  "assets/png/store_image/store_banner1.png",
  "assets/png/store_image/store_banner2.png"
];
final List<Map<String,String>> lastexplore = [
  {
    "path": "assets/png/store_image/bridgestone.png",
    "name": "Bridgestone"
  },
  {
    "path": "assets/png/store_image/michlein.png",
    "name": "Michelin"
  },
  {
    "path": "assets/png/store_image/godyear.png",
    "name": "Goodyear"
  },
  {
    "path": "assets/png/store_image/coopertires.png",
    "name": "Cooper Tires"
  },
  {
    "path": "assets/png/store_image/yokohama.png",
    "name": "Yokohama"
  },
  {
    "path": "assets/png/store_image/contenantal.png",
    "name": "Continental"
  },
  {
    "path": "assets/png/store_image/bfgoogrich.png",
    "name": "BFGoodrich"
  },
  {
    "path": "assets/png/store_image/firestone.png",
    "name": "Firestone"
  },
];
class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: whiteColor,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 7.h,
                  left: 6.w,
                  right: 6.w,
                  bottom: 2.h,
                ),
                child: headerWidget(
                  "Discover Tire Suppliers",
                      () {},
                  "Search By Tire model",
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                itemCount: imgpath.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: Image.asset(
                      imgpath[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w), // outer padding only
              child: Wrap(
                spacing: 0,
                runSpacing: 0.5.h,
                children: lastexplore.map((item) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width - (2.w * 2)) / 4, // subtract outer padding
                    child: lastExplore(item["path"]!, item["name"]!),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listSupplier("assets/png/store_image/tire1.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM"),
                      listSupplier("assets/png/store_image/tire2.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM"),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listSupplier("assets/png/store_image/tire1.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM"),
                      listSupplier("assets/png/store_image/tire2.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM"),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listSupplier("assets/png/store_image/tire1.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM"),
                      listSupplier("assets/png/store_image/tire2.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM"),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listSupplier("assets/png/store_image/tire1.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM"),
                      listSupplier("assets/png/store_image/tire2.png", "Tire Supplier Name", "14km Away", "11:00 AM - 12:00 PM"),
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
  Widget lastExplore(String path,String title) {
    return
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Image.asset(path,)
            ),
            customText(
              text: title,
              fontSize: 13.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w400,
            ),
          ],
        );
  }
  Widget listSupplier(String path, String name, String distance, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Supplier Image
            Image.asset(
              path,
              width: 42.w,
              fit: BoxFit.cover,
            ),

            // Star rating badge
            Positioned(
              bottom: 1.h,
              right: 1.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(1),
                      Colors.white.withOpacity(0.15)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(2.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1.w,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow[700],
                      size: 15.sp,
                    ),
                    SizedBox(width: 1.w),
                    customText(
                      text: '4.8',
                      fontSize: 13.sp,
                      fontFamily: "Barlow",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 0.7.h),

        customText(
          text: name,
          fontSize: 16.sp,
          fontFamily: "Barlow",
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 0.3.h),
        customText(
          text: distance,
          fontSize: 14.sp,
          fontFamily: "Barlow",
          fontWeight: FontWeight.w400,
          color: homegreyColor,
        ),
        SizedBox(height: 0.2.h),
        customText(
          text: time,
          fontSize: 14.sp,
          fontFamily: "Barlow",
          fontWeight: FontWeight.w400,
          color: homegreyColor,
        ),
      ],
    );
  }


}
