import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';

import '../../constants/constants_widgets.dart';

class SplashTwo extends StatelessWidget {
  const SplashTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 85.w, // Restrict width of the whole content
          child: Stack(
            children: [
              // ── Background Image ────────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 70.h,
                  child: Image.asset(
                    'assets/png/splash_two_background.png',
                    fit: BoxFit.fill, // Use this only if needed
                  ),
                ),
              ),

              // ── Top Logo ────────────────────────────────
              Positioned(
                top: 11.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    "assets/png/tire_eagle_logo.png",
                    height: 17.h,
                    width: 65.w,
                  ),
                ),
              ),

              // ── Widget over image ───────────────────────
              Positioned(
                bottom: 19.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Tire Care\n",
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                            height: 0.08.h,
                          ),
                        ),
                        TextSpan(
                          text: "Made Easy",
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                bottom: 17.h,
                left: 0,
                right: 0,
                child: Center(
                  child: customText(
                    text: "Your tires, your safety—logged in one tap.",
                    height: 0.1.h,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  )
                ),
              ),
              Positioned(
                bottom: 5.h,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed("loginscreen");
                    },
                    child: Container(
                      height: 7.5.h,
                      width: 7.5.h,
                      decoration: BoxDecoration(
                        color: darkBrownColor,
                        shape: BoxShape.circle
                      ),
                      child: Icon(Icons.arrow_forward,size: 22.sp,color: whiteColor,),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
