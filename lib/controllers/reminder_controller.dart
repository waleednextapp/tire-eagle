import 'package:get/get.dart';
import 'package:tire_eagle/core/services/base_services.dart';
import 'package:tire_eagle/models/tire_reminder_model.dart';
import 'package:tire_eagle/models/wheel_reminder_model.dart';

import '../core/services/apiendpoints.dart';
import '../utils/utility.dart';

// Assuming ApiEndPoints.dart has a modified reminder method
// static String reminder({required String type, int page = 1, int limit = 10}) {
//   return '/api/fleet/reminder/$type?page=$page&limit=$limit';
// }

class ReminderController extends GetxController {
  RxBool isLoading = false.obs;
  BaseService baseService = BaseService();
  RxInt selectedRemainderIndex = 0.obs;

  // Reminder Data Models
  Rx<TireReminderModel?> tireReminders = Rx<TireReminderModel?>(null);
  Rx<WheelReminderModel?> wheelReminders = Rx<WheelReminderModel?>(null);

  // ✅ NEW: Pagination variables
  RxInt currentRemindersPage = 1.obs;
  RxInt totalRemindersPages = 1.obs;
  RxBool hasNextRemindersPage = false.obs;

  final List<String> RemainderTabs = [
    "Tire",
    "Wheel",
  ];

  void selectRemainderValue(int index) {
    selectedRemainderIndex.value = index;
  }

  // @override
  // void onInit() {
  //   // Call the API with the default type and page 1
  //   TireReminder(type: "Tire"); // Use "Tire" capitalized as it's used in RemainderTabs
  //   super.onInit();
  // }

  // ✅ MODIFIED: Added page parameter and logic
  Future<void> TireReminder({String? type, int page = 1}) async {
    try {
      isLoading.value = true;
      currentRemindersPage.value = page; // Update current page state immediately

      final selectedType = type?.toLowerCase() ?? "tire"; // Default to tire

      // API CALL - Assuming ApiEndPoints.reminder now handles page/limit
      // You must ensure ApiEndPoints.reminder is updated to accept and use the page/limit arguments.
      final responseData =
      await baseService.baseGetAPI(ApiEndPoints.reminder(type: selectedType, page: page, limit: 10));

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      final meta = responseData["pagination"] ?? {};

      // ✅ Pagination State Update
      totalRemindersPages.value = meta["totalPages"] ?? 1;
      currentRemindersPage.value = meta["page"] ?? page;
      hasNextRemindersPage.value = meta["hasNextPage"] ?? false; // Use API provided boolean

      // ---------------------------
      //   TIRE REMINDER PARSING
      // ---------------------------
      if (selectedType == "tire") {
        tireReminders.value = TireReminderModel.fromJson(responseData);
        return;
      }

      // ---------------------------
      //   WHEEL REMINDER PARSING
      // ---------------------------
      if (selectedType == "wheel") {
        wheelReminders.value = WheelReminderModel.fromJson(responseData);
        return;
      }
    } catch (e) {
      print("❌ Reminder() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ NEW: Pagination methods
  void loadNextReminderPage() {
    if (hasNextRemindersPage.value && !isLoading.value) {
      // Use the currently selected tab type for the next page call
      final nextType = RemainderTabs[selectedRemainderIndex.value];
      TireReminder(type: nextType, page: currentRemindersPage.value + 1);
    }
  }

  void loadPrevReminderPage() {
    if (currentRemindersPage.value > 1 && !isLoading.value) {
      // Use the currently selected tab type for the previous page call
      final prevType = RemainderTabs[selectedRemainderIndex.value];
      TireReminder(type: prevType, page: currentRemindersPage.value - 1);
    }
  }
}
