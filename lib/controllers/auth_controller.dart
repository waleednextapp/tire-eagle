import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isObscure = true.obs;
  TextEditingController phoneController = TextEditingController();

  void toggleObscure (){
    isObscure.value = !isObscure.value;
}
  Rx<Country> selectedCountry = Country.parse('US').obs;

  void updateCountry(Country country) {
    selectedCountry.value = country;
  }
}
