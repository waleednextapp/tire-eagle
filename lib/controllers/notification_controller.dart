import 'package:get/get.dart';

class NotificationController extends GetxController {
  // Observable variables for the switch states, initialized to true (as seen in image)
  final paymentsEnabled = true.obs;
  final reminderEnabled = true.obs;
  void togglePayments(bool value) {
    paymentsEnabled.value = value;
    // In a real app, you would save this preference here
    // print('Payments Notification toggled to: ${paymentsEnabled.value}');
  }

  void toggleReminder(bool value) {
    reminderEnabled.value = value;
    // In a real app, you would save this preference here
    // print('Reminder Notification toggled to: ${reminderEnabled.value}');
  }

}
