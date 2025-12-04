import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/constants_widgets.dart';

import '../constants/color_constants.dart';

Widget customTextFeildM(
    String title,
    String hintText, {
      TextEditingController? controller,
      IconData? icon,
      String? path,
      int? maxlines,
      bool? readonly,
      RxBool? obscureController,
      Function()? toggleObscure,
      VoidCallback? ontap,
      bool isPassword = false,
      dynamic validator,
    }) {
  Widget buildTextField() {
    return TextFormField(
      controller: controller,
      readOnly: readonly ?? false,
      obscureText: isPassword ? (obscureController?.value ?? true) : false,
      validator: validator,
      maxLines: isPassword ? 1 : maxlines,
      cursorColor: yellowColor,
      style: TextStyle(
        fontSize: 15.sp,
        fontFamily: "Barlow",
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 1.2.h,
          horizontal: 4.w,
        ),
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
        suffixIcon: isPassword
            ? Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: IconButton(
            icon: Icon(
              obscureController?.value ?? true
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.grey.shade400,
              size: 19.sp,
            ),
            onPressed: toggleObscure,
          ),
        )
            : path != null
            ? Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: InkWell(
            onTap: ontap,
            child: Image.asset(
              path,
              height: 2.h,
              width: 2.h,
            ),
          ),
        )
            : icon != null
            ? Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: Icon(icon, color: blackColor, size: 18.sp),
        )
            : null,
        suffixIconConstraints: BoxConstraints(
          minHeight: 2.h,
          minWidth: 2.h,
        ),
      ),
    );
  }

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
      obscureController != null ? Obx(() => buildTextField()) : buildTextField(),
    ],
  );
}





Widget customDropdownField<T>({
  required String title,
  required String hintText,
  required List<T> items,
  required T? selectedItem,
  required void Function(T?) onChanged,
  String? Function(T?)? validator, // <-- simple validator
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

      FormField<T>(
        validator: validator, // just pass the validator
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 4.9.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12.sp),
                  border: Border.all(
                    color: state.hasError ? Colors.red : textFeildBorderColor,
                    width: 0.2.w,
                  ),
                ),

                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<T>(
                    isExpanded: true,
                    hint: Text(
                      hintText,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    items: items.map((item) {
                      return DropdownMenuItem<T>(
                        value: item,
                        child: Text(
                          item.toString(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }).toList(),
                    value: selectedItem,
                    onChanged: (value) {
                      onChanged(value);
                      state.didChange(value); // update state
                    },
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey.shade500,
                        size: 19.sp,
                      ),
                      iconSize: 19.sp,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: Get.width * 0.88,
                      maxHeight: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Colors.white,
                      ),
                      offset: const Offset(-18, -5),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
              if (state.hasError)
                Padding(
                  padding: EdgeInsets.only(top: 2.sp, left: 4.w),
                  child: Text(
                    state.errorText!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    ],
  );
}


