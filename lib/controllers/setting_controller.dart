import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tire_eagle/controllers/auth_controller.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/core/services/apiendpoints.dart';
import 'package:tire_eagle/core/services/base_services.dart';
import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';
import '../widgets/success_dialog.dart';

class SettingController extends GetxController {
  final DashboardController controller = Get.find<DashboardController>();
  final AuthController authController = Get.find<AuthController>();
  final twoFactorAuthentication = true.obs;
  final prefs = SharedPreferencesMethod.storage;






  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  //Password and Security Controllers
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();


  RxBool isOldPasswordObscure = true.obs;
  RxBool isNewPasswordObscure = true.obs;
  RxBool isConfirmObscure = true.obs;
  void loadUserData() {
    final userDataRaw = prefs.getString(LocalDBKeys.USERDETAIL);
    final user = prefs.getString(LocalDBKeys.USERFULLNAME);
    final email = prefs.getString(LocalDBKeys.USEREMAIL);
    final profilePic = prefs.getString(LocalDBKeys.USERPROFILEPIC);
    if (userDataRaw != null) {
      final userData = jsonDecode(userDataRaw); // converts JSON string -> Map
      final name = userData["name"];
      final email = userData["email"];
      print("User Full Name: $name");
      print("User Email: $email");
    } else {
      print("No user data found in SharedPreferences");
    }
      prefs.setString(LocalDBKeys.USERFULLNAME, nameController.text);
      prefs.setString(LocalDBKeys.USEREMAIL, emailController.text);
      prefs.setString(LocalDBKeys.USERPROFILEPIC, controller.uploadedImageUrl!);
      print(prefs.getString(LocalDBKeys.USERFULLNAME));
      print(prefs.getString(LocalDBKeys.USERPROFILEPIC));
  }

  void toggleOldPassword() =>
      isOldPasswordObscure.value = !isOldPasswordObscure.value;
  void toggleNewPassword() =>
      isNewPasswordObscure.value = !isNewPasswordObscure.value;
  void toggleConfirmPassword() =>
      isConfirmObscure.value = !isConfirmObscure.value;


  BaseService baseService = BaseService();
  RxInt selectedTab = 0.obs;
  var profilePicture = Rxn<File>();

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void toggle2FA(bool value) {
    twoFactorAuthentication.value = value;
  }

  /// ✅ Function to clear all input fields and reset profile picture
  void clearFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    profilePicture.value = null;
    // Optional: reset selected country if needed
    // authController.selectedCountry.value = defaultCountry;
  }

  void clearPassword() {
    oldPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
    // Optional: reset selected country if needed
    // authController.selectedCountry.value = defaultCountry;
  }

  Future<void> updateProfile(BuildContext context) async {
    final body = {
      "profilePicture": controller.uploadedImageUrl,
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "phone": '+${authController.selectedCountry.value.phoneCode}${phoneController.text}',
    };

    final responseMap = await baseService.basePutAPI(
      ApiEndPoints.profileUpdate,
      body: body,
      loading: true
    );

    if (responseMap["success"] != true) return;

    final data = responseMap["data"];
    if (data == null) return;

    // Show success dialog
    loadUserData();
    clearFields();

    successDialog(
      context,
      "Profile has been updated successfully.",
      "Ok",
      title: "Congratulations!",
          () {
        Get.back();
      },
    );

    print("🎉 PROFILE UPDATE SUCCESS → ${data["email"]}");

    // ✅ Clear all fields after successful update

  }

  Future<void> updatePassword(BuildContext context) async {
    final body = {
      "oldPassword": oldPassword.text.trim(),
      "newPassword": newPassword.text.trim(),
      "confirmPassword": confirmPassword.text.trim(),
    };

    final responseMap = await baseService.basePutAPI(
      ApiEndPoints.updatePassword,
      body: body,
      loading: true,
    );

    if (responseMap["success"] != true) return;

    // Clear password fields
    clearPassword();

    // Show success dialog (works even if data is null)
    successDialog(
      context,
      "Password has been updated successfully.",
      "Ok",
      title: "Congratulations!",
          () {
        Get.back();
      },
    );

    print("🎉 PASSWORD UPDATE SUCCESS");
  }


  @override
  void onClose() {
    // Dispose controllers when this controller is removed from memory
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
