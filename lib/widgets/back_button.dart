import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget backButton(){
  return GestureDetector(
    onTap: (){
      Get.back();
    },
      child: Icon(Icons.arrow_back)
  );
}
