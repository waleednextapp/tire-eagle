import 'package:get/get.dart';

class SettingController extends GetxController{
  final twoFactorAuthentication = true.obs;

  RxInt selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void toggle2FA(bool value) {
    twoFactorAuthentication.value = value;
    // In a real app, you would save this preference here
    // print('Reminder Notification toggled to: ${reminderEnabled.value}');
  }
}
