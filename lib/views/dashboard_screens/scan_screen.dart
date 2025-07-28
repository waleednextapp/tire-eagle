import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/constants_widgets.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/png/scan.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Cross (X) icon in top-left
          Positioned(
            top: 7.h, // You can adjust this as needed
            left: 4.w,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),

          /// Content below
          Column(
            children: [
            ],
          ),
        ],
      ),
    );
  }
}
