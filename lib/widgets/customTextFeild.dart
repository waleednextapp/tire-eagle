
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/constants_widgets.dart';

import '../constants/color_constants.dart';

Widget customTextFeild(String title,String hintText,{IconData? icon,String? path}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     customText(
       text: title,
       fontSize: 15.sp,
       fontFamily: "Barlow",
       fontWeight: FontWeight.w500,
     ),
      SizedBox(height: 0.5.h),
      TextField(
        cursorColor: textFeildBorderColor,
        style: TextStyle(fontSize: 15.sp, fontFamily: "Barlow",fontWeight: FontWeight.w400),

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 1.2.h,
            horizontal: 4.w,),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            fontFamily: "Barlow",
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: whiteColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide(color: textFeildBorderColor, width: 0.2.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide(color: textFeildBorderColor, width: 0.4.w),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: path!= null ? Image.asset(
              path,
              height: 2.h,
              width: 2.h,
            ):
                Icon(icon,color: blackColor,size: 18.sp)
          ),
          suffixIconConstraints: BoxConstraints(
            minHeight: 2.h,
            minWidth: 2.h,
          ),
        ),
      )
    ],
  );
}

Widget customDropdownField<T>({
  required String title,
  required String hintText,
  required List<T> items,
  required T? selectedItem,
  required void Function(T?) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customText(
        text: title,
        fontSize: 15.sp,
        fontFamily: "Barlow",
        fontWeight: FontWeight.w500,
      ),
      SizedBox(height: 0.5.h),
      Container(
        height: 4.9.h, // 👈 Adjust this to reduce height
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12.sp),
          border: Border.all(
            color: textFeildBorderColor,
            width: 0.2.w,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: selectedItem,
            isExpanded: true,
            isDense: true, // Optional: makes dropdown content more compact
            hint: Text(
              hintText,
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: "Barlow",
                fontWeight: FontWeight.w300,
              ),
            ),
            icon: Icon(Icons.keyboard_arrow_down,color: blackColor,size: 18.sp,),
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: "Barlow",
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString()),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}

