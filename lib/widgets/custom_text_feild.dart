import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tire_eagle/constants/color_constants.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import '../constants/constants_widgets.dart';

Widget customTextFeild(
    String title,
    String hintText, {
      bool isPassword = false,
      TextEditingController? controller,
      bool? isSuffix = false,
      bool? isPrefix = false,
      dynamic validator,
      RxBool? obscureController,       // 🔹 Added
      Function()? toggleObscure,       // 🔹 Added
      void Function(String)? onChanged,
      void Function(String)? onSubmitted,
      Color? color,
      VoidCallback? onDropDown
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customText(
        text: title,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: greyTextColor,
      ),
      SizedBox(height: 1.h),

      // PASSWORD FIELD
      isPassword
          ? Obx(() => TextFormField(
        controller: controller,
        cursorColor: yellowColor,
        obscureText: obscureController?.value ?? true,
        style: TextStyle(
          fontSize: 16.sp,
          color: customGreyColor,
          fontFamily: "Barlow",
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            color: textFeildInnerColor,
            fontFamily: 'Barlow',
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 4.w, vertical: 2.h),
          filled: true,
          fillColor: color ?? backgroundColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide:
            BorderSide(color: Colors.grey.shade300, width: 0.2.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: yellowColor, width: 2),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: IconButton(
              icon: Icon(
                (obscureController?.value ?? true)
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey.shade400,
                size: 19.sp,
              ),
              onPressed: toggleObscure,
            ),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ))

      // NORMAL FIELD
          : TextFormField(
        controller: controller,
        cursorColor: yellowColor,
        obscureText: false,
        style: TextStyle(
          fontSize: 16.sp,
          color: yellowColor,
          fontFamily: "Barlow",
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            color: textFeildInnerColor,
            fontFamily: 'Barlow',
            fontWeight: FontWeight.w500,
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          filled: true,
          fillColor: color ?? backgroundColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide:
            BorderSide(color: Colors.grey.shade300, width: 0.2.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: yellowColor, width: 2),
          ),
          prefixIcon: isPrefix == true
              ? Padding(
            padding: EdgeInsets.only(left: 3.w, right: 2.w),
            child: Image.asset(
              "assets/png/circle_tick.png",
              width: 4.w,
              height: 4.w,
              fit: BoxFit.contain,
            ),
          )
              : null,
          prefixIconConstraints:
          BoxConstraints(minWidth: 6.w, minHeight: 6.w),
          suffixIcon: isSuffix == true
              ? InkWell(
            onTap: onDropDown,
                child: Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 19.sp,
                color: Colors.grey.shade500,
                            ),
                          ),
              )
              : null,
        ),
        onChanged: onChanged,
        validator: validator,
      )
    ],
  );
}


// Widget customDropdownTextField(
//     String title,
//     String hintText, {
//       TextEditingController? controller,
//       bool isSuffix = true,
//       Color? color,
//       Function(String?)? onChanged,
//       dynamic validator,
//       required List<String> dropdownItems,
//     }) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       customText(
//         text: title,
//         fontSize: 15.sp,
//         fontWeight: FontWeight.w500,
//         color: Colors.grey,
//       ),
//       SizedBox(height: 1.h),
//       GestureDetector(
//         onTap: () {
//           // Show full-width dialog
//           showDialog(
//             context: Get.context!,
//             builder: (context) {
//               return Dialog(
//                 insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 2.h),
//                   constraints: BoxConstraints(
//                     maxHeight: 50.h, // Max height for scroll
//                   ),
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: dropdownItems.length,
//                     itemBuilder: (context, index) {
//                       final item = dropdownItems[index];
//                       return ListTile(
//                         title: Text(item),
//                         onTap: () {
//                           controller?.text = item;
//                           if (onChanged != null) onChanged(item);
//                           Navigator.pop(context);
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//         child: AbsorbPointer(
//           child: TextFormField(
//             controller: controller,
//             cursorColor: Colors.yellow,
//             obscureText: false,
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: Colors.yellow,
//               fontFamily: "Barlow",
//               fontWeight: FontWeight.w700,
//             ),
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: TextStyle(
//                 fontSize: 15.sp,
//                 color: Colors.grey,
//                 fontFamily: 'Barlow',
//                 fontWeight: FontWeight.w500,
//               ),
//               contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
//               filled: true,
//               fillColor: color ?? Colors.white,
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.sp),
//                 borderSide: BorderSide(color: Colors.grey.shade300, width: 0.2.w),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.sp),
//                 borderSide: BorderSide(color: Colors.yellow, width: 2),
//               ),
//               suffixIcon: isSuffix
//                   ? Padding(
//                 padding: EdgeInsets.only(right: 2.w),
//                 child: Icon(
//                   Icons.keyboard_arrow_down_rounded,
//                   size: 19.sp,
//                   color: Colors.grey.shade500,
//                 ),
//               )
//                   : null,
//             ),
//             validator: validator,
//           ),
//         ),
//       ),
//     ],
//   );
// }

// Ensure you have imported the dropdown_button2 package:
// import 'package:dropdown_button2/dropdown_button2.dart';
// And that you have imported your custom classes/constants (like customText,
// backgroundColor, textFeildInnerColor, yellowColor, and your size extensions 15.sp, 1.h, etc.)

Widget customDropdownTextField(
    String title,
    BuildContext context,
    String hintText, {
      String? value,
      Function(String?)? onChanged,
      dynamic validator,
      required List<String> dropdownItems,
      Color? color,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customText( // Your customText widget for the title
        text: title,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      SizedBox(height: 1.h),
      Container(
        width: double.infinity,
        height: 6.5.h,// Full width
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: color ?? backgroundColor, // 🔹 aapka TextFormField fill color
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(color: Colors.grey.shade300, width: 0.2.w),
        ),
        child: DropdownButtonHideUnderline( // Hiding the default underline
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              hintText,
              style: TextStyle(
                fontSize: 15.sp,
                color: textFeildInnerColor, // 🔹 same as your TextFormField hint color
                fontFamily: 'Barlow',
                fontWeight: FontWeight.w500,
              ),
            ),
            items: dropdownItems.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600, // 🔹 same as TF style
                    color: yellowColor,           // 🔹 same as TF text color
                    fontFamily: 'Barlow',
                  ),
                ),
              );
            }).toList(),
            value: value,
            onChanged: onChanged,
            iconStyleData: IconStyleData( // Customizing the icon
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade500, size: 19.sp), // 🔹 size same as your TF
              iconSize: 19.sp, // Ensuring the icon size is respected
            ),
            dropdownStyleData: DropdownStyleData(
              width: MediaQuery.of(context).size.width * 0.88, // Adjust width as needed
              maxHeight: 300, // Max height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                color: Colors.white, // Setting dropdown color to white
              ),
              // *** Yahan aap offset de sakte hain: ***
              offset: const Offset(-18, -5), // Example: Shift 20 pixels left
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40, // Height of each item
            ),
            // Note: validator needs to be handled externally if you use this standalone DropdownButton2.
            // If this widget is used within a Form, you'd typically wrap this in a custom FormField.
            // For now, I'm keeping the original signature but the direct validator is not
            // a property of DropdownButton2 like it is for DropdownButtonFormField.
            // For validation with DropdownButton2, the usual approach is to wrap it
            // in a TextFormField or use the onMenuStateChange property.
            // Since you specifically asked to retain the validator, I've kept it in the function signature,
            // but it's important to know that direct validation requires a FormField wrapper.
          ),
        ),
      ),
      if (validator != null && value == null) // A basic way to show error if value is null
        Padding(
          padding: EdgeInsets.only(top: 0.5.h, left: 1.w),
          child: Text(
            validator(value), // Assuming validator returns an error string
            style: TextStyle(color: Colors.red, fontSize: 15.sp,fontFamily: 'Barlow'),
          ),
        ),
    ],
  );
}

Widget customPhoneTextField({
  required String title,
  required String hintText,
  required TextEditingController controller,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
}) {
  final authController = Get.find<AuthController>();

  return Obx(() => Column(
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
        controller: controller,
        keyboardType: TextInputType.phone,
        cursorColor: yellowColor,
        style: TextStyle(
          fontSize: 16.sp,
          color: blackColor,
          fontFamily: "Barlow",
          fontWeight: FontWeight.w300,
        ),

        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            color: textFeildInnerColor,
            fontFamily: 'Barlow',
            fontWeight: FontWeight.w500
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.1.h),
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
          prefixIcon: GestureDetector(
            onTap: () {
              showCountryPicker(
                context: Get.context!,
                showPhoneCode: true,
                onSelect: (Country country) {
                  authController.selectedCountry.value = country;
                },
              );
            },
            child: Container(
              padding: EdgeInsets.only(left: 3.w, right: 2.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    authController.selectedCountry.value.flagEmoji,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded, color: blackColor,size: 18.sp,),
                ],
              ),
            ),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    ],
  ));
}
