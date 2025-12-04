import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tire_eagle/core/services/apiendpoints.dart';
import 'package:tire_eagle/models/fleet_model.dart';
import 'package:tire_eagle/views/bottom_nav_bar/bottom_nav_bar.dart';

import '../core/services/base_services.dart';
import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';
import '../utils/utility.dart';

class AuthController extends GetxController {
  var isObscure = true.obs;
  final RxBool isSelected = false.obs;
  var loginUserIndex = 1.obs;
  RxBool isUser = true.obs;
  TextEditingController phoneController = TextEditingController();
  BaseService baseService = BaseService();
  Rx<FleetModel> response = FleetModel().obs;


  final roleSelectedItem = Rx<String?>(null);
  // Signup Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController = TextEditingController();

  //Login Controllers
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();



  void toggleObscure (){
    isObscure.value = !isObscure.value;
}
  // Function to update the value
  void updateRoleSelectedItem(String? newValue) {
    roleSelectedItem.value = newValue;
  }
  RxBool isPasswordObscure = true.obs;
  RxBool isConfirmObscure = true.obs;

  void togglePassword() =>
      isPasswordObscure.value = !isPasswordObscure.value;

  void toggleConfirm() =>
      isConfirmObscure.value = !isConfirmObscure.value;
  Rx<Country> selectedCountry = Country.parse('US').obs;

  void updateCountry(Country country) {
    selectedCountry.value = country;
  }
  void toggleIsUser(){
    isUser.value = !isUser.value;
  }

  void clearSignupValues(){
    nameController.clear();
    signupEmailController.clear();
    signupPasswordController.clear();
    signupConfirmPasswordController.clear();
    roleSelectedItem.value = null;
  }

  void clearLoginValues(){
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  Future<void> signUp() async {
    final body = {
      'name': nameController.text.trim(),
      'email': signupEmailController.text.trim().toLowerCase(),
      'password': signupPasswordController.text.trim(),
    };

    final responseMap = await baseService.basePostAPI(
      ApiEndPoints.signupUser,
      body,
      loading: true,
    );

    // 👉 SABSE IMPORTANT CHECK
    if (responseMap["success"] != true) {
      // ❗Toast pehle BaseService mein show ho chuka hai
      return;
    }

    // 👉 YAHAN TAK KA MATLAB API SUCCESS THI
    // ---------------------------------------

    final data = responseMap["data"];  // user object
    if (data == null) return; // Safety guard
    final prefs = SharedPreferencesMethod.storage;
    await prefs.setString(LocalDBKeys.USERFULLNAME, nameController.text);
    // 🚀 AB DASHBOARD PE JAO
    Get.offAllNamed('/loginscreen');
    clearSignupValues();

    print("🎉 SIGNUP SUCCESS → ${data["email"]}");
  }


  Future<void> login() async {
    final body = {
      'email': loginEmailController.text.trim().toLowerCase(),
      'password': loginPasswordController.text.trim(),
    };

    try {
      // 🔹 Call API
      var a = await baseService.basePostAPI(
        ApiEndPoints.loginFleetManager,
        body,
        loading: true,
      );

      // 🔹 Check network issue
      if (a == false) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }

      // 🔹 Ensure response is Map
      if (a is! Map<String, dynamic>) {
        Utils.showToast(a.toString(), true);
        return;
      }

      // 🔹 Check for data & token inside 'data'
      if (a['data'] == null ||
          a['data']['fleetManager'] == null ||
          a['data']['token'] == null) {
        Utils.showToast(a['message'] ?? 'Invalid email or password', true);
        return;
      }

      // 🔹 Extract user & token
      final user = a['data']['fleetManager'];
      final token = a['data']['token'];

      // 🔹 Save user data in SharedPreferences
      final prefs = SharedPreferencesMethod.storage;
      await prefs.setString(LocalDBKeys.USERDETAIL, jsonEncode(user));
      await prefs.setString(LocalDBKeys.KHANTAR, loginPasswordController.text);
      await prefs.setString(LocalDBKeys.USERFULLNAME, user['name'] ?? "");
      await prefs.setString(LocalDBKeys.USERPROFILEPIC, user['profilePicture'] ?? "");
      await prefs.setString(LocalDBKeys.PHONENUMBER, user['phone'] ?? "");
      await prefs.setString(LocalDBKeys.USEREMAIL, user['email'] ?? "");
      await prefs.setString(LocalDBKeys.TOKEN, token ?? "");

      // 🔹 Show success message
      Utils.showToast(a['message'] ?? 'Login successful', false);
      print('✅ Login Successful: ${user['email']}');

      // 🔹 Navigate to dashboard / bottom navbar
      Get.offAllNamed('/bottomnavbar');
      clearLoginValues(); // or: Get.offAll(() => BottomNavbarScreen());

    } catch (e) {
      Utils.showToast('Something went wrong. Please try again.', true);
      print('❌ Login Error: $e');
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
   nameController.dispose();
   signupPasswordController.dispose();
   signupEmailController.dispose();
   signupConfirmPasswordController.dispose();
   loginEmailController.dispose();
   loginPasswordController.dispose();
    super.dispose();
  }
}
