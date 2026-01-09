import 'package:get/get.dart';
import 'package:tire_eagle/models/user_get_all_tire_model.dart';
import 'package:tire_eagle/models/user_get_all_wheel_model.dart';

import '../core/services/apiendpoints.dart';
import '../core/services/base_services.dart';
import '../models/get_user_tire_id_model.dart';
import '../models/get_wheel_by_id_model.dart';
import '../utils/utility.dart';

class UserTireWheelController extends GetxController{
  RxBool isLoading = true.obs;
  BaseService baseService = BaseService();
  Rx<UserGetAllTire?> usertireModel = Rx<UserGetAllTire?>(null);
  Rx<UserGetAllWheel?> userWheelModel = Rx<UserGetAllWheel?>(null);
  Rx<UserGetTireById?> getTireByIdModel = Rx<UserGetTireById?>(null);
  Rx<GetWheelByIdModel?> getWheelByIdModel = Rx<GetWheelByIdModel?>(null);

  // // 💡 Pagination State Variables for Tires (Inventory) - REQUIRED FOR INVENTORY SCREEN
  // RxInt currentTirePage = 1.obs;
  // RxBool hasNextTirePage = false.obs;
  // RxInt totalTirePages = 1.obs;

  // 💡 Pagination State Variables for TotalTires Screen (Kept for UI logic/API response parsing)
  RxInt currentTotalTirePage = 1.obs;
  RxBool hasNextTotalTirePage = false.obs;
  RxInt totalTotalTirePages = 1.obs;




  // 💡 Pagination State Variables for TotalWheels Screen (Kept for UI logic/API response parsing)
  RxInt currentTotalWheelPage = 1.obs;
  RxBool hasNextTotalWheelPage = false.obs;
  RxInt totalTotalWheelPages = 1.obs;


  Future<void> GetAllTire({int page = 1}) async {
    try {
      isLoading.value = true;

      // Base URL ko fetch karein
      String url = ApiEndPoints.userGetAllTire();

      // 💡 FIX: Page parameter ko URL mein add karein
      // Assuming ApiEndPoints.getAllTires does NOT end with '?' or '&'.
      // Agar ApiEndPoints.getAllTires mein pehle se koi parameter nahi hai, toh '?' use karein.
      // Agar aapka server sirf default data return kar raha tha aur page parameter nahi leta,
      // toh yeh line *problem* kar sakti hai, lekin pagination ke liye zaroori hai.
      url += "?page=$page"; // Ya agar pehle se parameter hain toh '&page=$page'

      // Agar ApiEndPoints.getAllTires mein pehle se koi query parameter nahi hai:
      // String url = "${ApiEndPoints.getAllTires}?page=$page";

      // Agar ApiEndPoints.getAllTires mein pehle se query parameter hai (jaisa ki inventory mein tha):
      // String url = "${ApiEndPoints.getAllTires}&page=$page";

      // Main yeh maan ke chal raha hoon ki ApiEndPoints.getAllTires ek clean endpoint hai:
      // **url += "?page=$page";** // Yeh line use kar raha hoon.

      final responseData = await baseService.baseGetAPI(url);
      print("GET URL: $url"); // Check karne ke liye URL print karein

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        usertireModel.value = null;
        return;
      }

      usertireModel.value = UserGetAllTire.fromJson(responseData);

      // We still update pagination state based on API response
      final pagination = responseData["data"]?["pagination"];
      if (pagination != null) {
        currentTotalTirePage.value = pagination["currentPage"] ?? 1;
        totalTotalTirePages.value = pagination["totalPages"] ?? 1;
        hasNextTotalTirePage.value = pagination["hasNextPage"] ?? false;
      } else {
        currentTotalTirePage.value = 1;
        totalTotalTirePages.value = 1;
        hasNextTotalTirePage.value = false;
      }

      print("Total Tires: ${usertireModel.value?.data?.tires?.length}");

    } catch (e) {
      print("❌ GetAllTire() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
      usertireModel.value = null;
    } finally {
      isLoading.value = false;
    }
  }

// 💡 Pagination methods still call GetAllTire, using the page argument for state management
  void loadNextTotalTirePage() {
    if (hasNextTotalTirePage.value) {
      GetAllTire(page: currentTotalTirePage.value + 1);
    }
  }

  void loadPrevTotalTirePage() {
    if (currentTotalTirePage.value > 1) {
      GetAllTire(page: currentTotalTirePage.value - 1);
    }
  }


  // -------------------------------------------------------------
// ✅ GetAllWheel (Pagination Parameter Added to URL)
// -------------------------------------------------------------
  Future<void> GetAllWheel({int page = 1}) async {
    try {
      isLoading.value = true;

      // Base URL ko fetch karein
      String url = ApiEndPoints.userGetWheelTire();

      // 💡 FIX: Page parameter ko URL mein add karein
      // Assuming ApiEndPoints.getAllWheel ek clean endpoint hai:
      url += "?page=$page";

      final responseData = await baseService.baseGetAPI(url);
      print("GET URL: $url"); // Check karne ke liye URL print karein

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        userWheelModel.value = null; // Clear model on failure
        return;
      }

      // ✅ Parse JSON into WheelModel
      userWheelModel.value = UserGetAllWheel.fromJson(responseData);

      // 💡 Update Pagination State for TotalWheels screen
      final pagination = responseData["data"]?["pagination"];
      if (pagination != null) {
        currentTotalWheelPage.value = pagination["currentPage"] ?? 1;
        totalTotalWheelPages.value = pagination["totalPages"] ?? 1;
        hasNextTotalWheelPage.value = pagination["hasNextPage"] ?? false;
      } else {
        currentTotalWheelPage.value = 1;
        totalTotalWheelPages.value = 1;
        hasNextTotalWheelPage.value = false;
      }

      print("Total wheels: ${userWheelModel.value?.data?.wheels?.length}");

    } catch (e) {
      print("❌ GetAllWheel() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
      userWheelModel.value = null;
    } finally {
      isLoading.value = false;
    }
  }

// 💡 Pagination methods still call GetAllWheel, using the page argument for state management
  void loadNextTotalWheelPage() {
    if (hasNextTotalWheelPage.value) {
      GetAllWheel(page: currentTotalWheelPage.value + 1);
    }
  }

  void loadPrevTotalWheelPage() {
    if (currentTotalWheelPage.value > 1) {
      GetAllWheel(page: currentTotalWheelPage.value - 1);
    }
  }


  // -------------------------------------------------------------
  // ✅ Other utility methods (Unchanged)
  // -------------------------------------------------------------

  Future<void> GetTireById(String id) async {
    try {
      isLoading.value = true;

      final responseData = await baseService.baseGetAPI(ApiEndPoints.getUserTireById(id));

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      getTireByIdModel.value = UserGetTireById.fromJson(responseData);

      print("✅ Controller Data: ${getTireByIdModel.value?.data}");
    } catch (e) {
      print("❌ GetTireById() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> GetWheelById(String id) async {
    try {
      isLoading.value = true;

      final responseData = await baseService.baseGetAPI(ApiEndPoints.getUserWheelById(id));

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      getWheelByIdModel.value = GetWheelByIdModel.fromJson(responseData);

    } catch (e) {
      print("❌ GetWheelById() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoading.value = false;
    }
  }

}
