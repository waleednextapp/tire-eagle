import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget backButton({VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap ?? () {
      Get.back();
    },
    child: Icon(Icons.arrow_back),
  );
}
