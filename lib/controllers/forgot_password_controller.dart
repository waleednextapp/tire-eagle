import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tire_eagle/core/services/base_services.dart';

import '../core/services/apiendpoints.dart';
import '../utils/utility.dart';
import '../widgets/success_dialog.dart';

class ForgotPasswordController extends GetxController{
  final RxInt remainingTime = 0.obs;
  BaseService baseService = BaseService();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool isPasswordObscure = true.obs;
  RxBool isConfirmObscure = true.obs;

  Timer? _timer;

  void togglePassword() =>
      isPasswordObscure.value = !isPasswordObscure.value;

  void toggleConfirm() =>
      isConfirmObscure.value = !isConfirmObscure.value;
  void startTimer() {
    const int fixedSeconds = 2 * 60; // 2 minutes = 120 seconds
    remainingTime.value = fixedSeconds;

    _timer?.cancel(); // Cancel previous timer if any
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
      }
    });
  }



  Future<void> emailVerification({String? resentemail}) async {
    final body = {
      'email': resentemail ?? emailController.text.trim().toLowerCase(),
    };

    try {
      // 🔹 Call API
      final response = await baseService.basePostAPI(
        ApiEndPoints.forgotPasswordEmail,
        body,
        loading: true,
      );

      // 🔹 Check network issue
      if (response == false) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }

      // 🔹 Ensure response is Map
      if (response is! Map<String, dynamic>) {
        Utils.showToast(response.toString(), true);
        return;
      }

      // 🔹 Check status code
      final statusCode = response['statusCode'] ?? 0;
      if (statusCode == 200) {
        final data = response['data'] ?? {};
        final email = data['email'] ?? '';
        final expiresIn = data['expiresIn'] ?? 120; // default 2 minutes

        // ✅ Use standard if/else instead of ternary for statements
        if (resentemail!=null) {
          Utils.showToast('OTP Resent Successfully $email', false);
        } else {
          Utils.showToast(response['message'] ?? 'OTP sent successfully', false);
        }

        print('✅ OTP sent to: $email, expires in $expiresIn seconds');

        Get.toNamed('/emailverification', arguments: {
          'email': email,
          'expiresIn': expiresIn,
        });
        emailController.clear();
      } else {
        Utils.showToast(response['message'] ?? 'Something went wrong', true);
      }
    } catch (e) {
      Utils.showToast('Something went wrong. Please try again.', true);
      print('❌ Email Verification Error: $e');
    }
  }

  Future<void> verifyOtp(String? email) async {
    final body = {
      'email': email,
      'otp': int.tryParse(otpController.text.trim()) ?? 0,
    };

    print('✅ verifyOtp body: $body');

    try {
      // Call API
      final response = await baseService.basePostAPI(
        ApiEndPoints.verifyOtp,
        body,
        loading: true,
      );

      print('📥 verifyOtp response: $response'); // 🔹 Print response body
      // Check network issue
      if (response == false) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }

      // Ensure response is Map
      if (response is! Map<String, dynamic>) {
        Utils.showToast(response.toString(), true);
        return;
      }

      // Check status code
      final statusCode = response['statusCode'] ?? 0;
      if (statusCode == 200) {
        final resetToken = response['data']['resetToken'];
        Utils.showToast(response['message'] ?? 'OTP verified successfully', false);
        Get.toNamed('/setpassword',arguments: {
          'email': email,
          'resetToken': resetToken,
        });
        otpController.clear();
      } else {
        Utils.showToast(response['message'] ?? 'Something went wrong', true);
      }
    } catch (e) {
      Utils.showToast('Something went wrong. Please try again.', true);
      print('❌ Email Verification Error: $e');
    }
  }

  Future<void> resetPassword(String? token,String? email,BuildContext context) async {
    final body = {
      'email': email,
      'resetToken': token,
      'newPassword': newPassword.text.trim(),
      'confirmPassword': confirmPassword.text.trim(),
    };

    print('✅ verifyOtp body: $body');

    try {
      // Call API
      final response = await baseService.basePostAPI(
        ApiEndPoints.resetPassword,
        body,
        loading: true,
      );

      print('📥 verifyOtp response: $response'); // 🔹 Print response body
      // Check network issue
      if (response == false) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }

      // Ensure response is Map
      if (response is! Map<String, dynamic>) {
        Utils.showToast(response.toString(), true);
        return;
      }

      // Check status code
      final statusCode = response['statusCode'] ?? 0;
      if (statusCode == 200) {
        final resetToken = response['data']['resetToken'];
        Utils.showToast(response['message'] ?? 'OTP verified successfully', false);
        newPassword.clear();
        confirmPassword.clear();
        successDialog(
          context,
          "Your password has been updated successfully.",
          "Ok",
              () {
                Get.offAllNamed('/loginscreen');
          },
        );

      } else {
        Utils.showToast(response['message'] ?? 'Something went wrong', true);
      }
    } catch (e) {
      Utils.showToast('Something went wrong. Please try again.', true);
      print('❌ Email Verification Error: $e');
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    otpController.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
  }

}
