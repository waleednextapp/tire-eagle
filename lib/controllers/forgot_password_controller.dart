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


  Future<void> userEmailVerification({String? resentemail}) async {
    final body = {
      'email': resentemail ?? emailController.text.trim().toLowerCase(),
    };

    try {
      // 🔹 Call API
      final response = await baseService.basePostAPI(
        ApiEndPoints.userForgotPasswordEmail,
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
  Future<void> userVerifyOtp(String? email) async {
    // 1. Validate that the OTP field is not empty before calling the API
    String otpValue = otpController.text.trim();

    if (otpValue.isEmpty) {
      Utils.showToast('Please enter the OTP', true);
      return;
    }

    // 2. The FIX: Send 'otp' as a String to match backend requirements
    final body = {
      'email': email,
      'otp': otpValue,
    };

    print('✅ verifyOtp body: $body');

    try {
      // Call API
      final response = await baseService.basePostAPI(
        ApiEndPoints.verifyUserOtp,
        body,
        loading: true,
      );

      print('📥 verifyOtp response: $response');

      // Check network issue
      if (response == false) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }

      // Ensure response is Map
      if (response is! Map<String, dynamic>) {
        Utils.showToast("Unexpected response format", true);
        return;
      }

      // Check status code
      // Note: We use double equals or .toString() comparison for safety
      final statusCode = response['statusCode'];

      if (statusCode == 200) {
        // Extract resetToken from nested data object
        final resetToken = response['data'] != null ? response['data']['resetToken'] : null;

        Utils.showToast(response['message'] ?? 'OTP verified successfully', false);

        // Navigate to Set Password screen
        Get.toNamed('/setpassword', arguments: {
          'email': email,
          'resetToken': resetToken,
        });

        otpController.clear();
      } else {
        // If validation fails (400) or OTP is wrong (401), show the backend error message
        String errorMsg = response['message'] ?? 'Something went wrong';
        Utils.showToast(errorMsg, true);
      }
    } catch (e) {
      Utils.showToast('Something went wrong. Please try again.', true);
      print('❌ Email Verification Error: $e');
    }
  }
  Future<void> verifyOtp(String? email) async {
    // 1. Local validation to ensure OTP is entered
    String otpValue = otpController.text.trim();

    if (otpValue.isEmpty) {
      Utils.showToast('Please enter the verification code', true);
      return;
    }

    // 2. The FIX: Send 'otp' as a String (remove int.tryParse)
    final body = {
      'email': email,
      'otp': otpValue,
    };

    print('✅ verifyOtp body: $body');

    try {
      // Call API
      final response = await baseService.basePostAPI(
        ApiEndPoints.verifyOtp,
        body,
        loading: true,
      );

      print('📥 verifyOtp response: $response');

      // Check network issue
      if (response == false) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }

      // Ensure response is Map
      if (response is! Map<String, dynamic>) {
        Utils.showToast("Unexpected response format", true);
        return;
      }

      // Check status code
      final statusCode = response['statusCode'] ?? 0;

      if (statusCode == 200) {
        // Safely access resetToken from nested data
        final data = response['data'];
        final resetToken = data != null ? data['resetToken'] : null;

        Utils.showToast(response['message'] ?? 'OTP verified successfully', false);

        Get.toNamed('/setpassword', arguments: {
          'email': email,
          'resetToken': resetToken,
        });

        otpController.clear();
      } else {
        // If the backend returns a specific error message (like "Invalid OTP")
        Utils.showToast(response['message'] ?? 'Verification failed', true);
      }
    } catch (e) {
      Utils.showToast('Something went wrong. Please try again.', true);
      print('❌ Email Verification Error: $e');
    }
  }
  Future<void> resetUserPassword(String? token,String? email,BuildContext context) async {
    final body = {
      // 'email': email,
      'token': token,
      'newPassword': newPassword.text.trim(),
      'confirmPassword': confirmPassword.text.trim(),
    };

    print('✅ verifyOtp body: $body');

    try {
      // Call API
      final response = await baseService.basePostAPI(
        ApiEndPoints.userResetPassword,
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
