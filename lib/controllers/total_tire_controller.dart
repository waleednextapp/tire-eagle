import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/models/get_inventory_tire_model.dart';
import 'package:tire_eagle/models/tire_model.dart';
import 'package:tire_eagle/models/wheel_model.dart';
import 'package:tire_eagle/views/dashboard_screens/wheel_screens/total_wheels.dart';

import '../core/services/apiendpoints.dart';
import '../core/services/base_services.dart';
import '../models/get_inventory_wheel_model.dart';
import '../models/get_tire_by_id_model.dart';
import '../models/get_wheel_by_id_model.dart';
import '../utils/shared_prefrences_methods.dart';
import '../utils/utility.dart';
import '../widgets/rotation_complete_dialog.dart';

class TotalTireController extends GetxController{
  final DashboardController controller = Get.find<DashboardController>();
  RxBool isLoading = true.obs;
  RxBool isLoadingWheel = true.obs;
  RxBool isLoadingTireInventory = true.obs;
  RxBool isLoadingWheelInventory = true.obs;
  final prefs = SharedPreferencesMethod.storage;
  bool? isUser;
  BaseService baseService = BaseService();
  Rx<TireModel?> tireModel = Rx<TireModel?>(null);
  Rx<WheelModel?> wheelModel = Rx<WheelModel?>(null);
  Rx<GetTireByIdModel?> getTireByIdModel = Rx<GetTireByIdModel?>(null);
  Rx<GetWheelByIdModel?> getWheelByIdModel = Rx<GetWheelByIdModel?>(null);
  Rx<GetTireInventory?> getTireInventory = Rx<GetTireInventory?>(null);
  Rx<GetWheelInventory?> getWheelInventory = Rx<GetWheelInventory?>(null);
  final TextEditingController searchController = TextEditingController();
  final TextEditingController technicianNoteController = TextEditingController();

  // 💡 Pagination State Variables for Tires (Inventory) - REQUIRED FOR INVENTORY SCREEN
  RxInt currentTirePage = 1.obs;
  RxBool hasNextTirePage = false.obs;
  RxInt totalTirePages = 1.obs;

  // 💡 Pagination State Variables for Wheels (Inventory) - REQUIRED FOR INVENTORY SCREEN
  RxInt currentWheelPage = 1.obs;
  RxBool hasNextWheelPage = false.obs;
  RxInt totalWheelPages = 1.obs;

  // 💡 Pagination State Variables for TotalTires Screen (Kept for UI logic/API response parsing)
  RxInt currentTotalTirePage = 1.obs;
  RxBool hasNextTotalTirePage = false.obs;
  RxInt totalTotalTirePages = 1.obs;

  // 💡 Pagination State Variables for TotalWheels Screen (Kept for UI logic/API response parsing)
  RxInt currentTotalWheelPage = 1.obs;
  RxBool hasNextTotalWheelPage = false.obs;
  RxInt totalTotalWheelPages = 1.obs;


  @override
  void onInit() {
    super.onInit();
    isUser = prefs.getBool('isUser') ?? false;
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    // Logic for search debounce is handled in the UI (InventoryScreen)
  }

  // -------------------------------------------------------------
  // ✅ GetAllTire (Original State - No Pagination Parameters in URL)
  // -------------------------------------------------------------
// -------------------------------------------------------------
// ✅ GetAllTire (Pagination Parameter Added to URL)
// -------------------------------------------------------------
  Future<void> GetAllTire({int page = 1}) async {
    try {
      isLoading.value = true;

      // Base URL ko fetch karein
      String url = ApiEndPoints.getAllTires;

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
        tireModel.value = null;
        return;
      }

      tireModel.value = TireModel.fromJson(responseData);

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

      print("Total Tires: ${tireModel.value?.data?.tires?.length}");

    } catch (e) {
      print("❌ GetAllTire() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
      tireModel.value = null;
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
  // ✅ GetAllWheel (Original State - No Pagination Parameters in URL)
  // -------------------------------------------------------------
// -------------------------------------------------------------
// ✅ GetAllWheel (Pagination Parameter Added to URL)
// -------------------------------------------------------------
  Future<void> GetAllWheel({int page = 1}) async {
    try {
      isLoadingWheel.value = true;

      // Base URL ko fetch karein
      String url = ApiEndPoints.getAllWheel;

      // 💡 FIX: Page parameter ko URL mein add karein
      // Assuming ApiEndPoints.getAllWheel ek clean endpoint hai:
      url += "?page=$page";

      final responseData = await baseService.baseGetAPI(url);
      print("GET URL: $url"); // Check karne ke liye URL print karein

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        wheelModel.value = null; // Clear model on failure
        return;
      }

      // ✅ Parse JSON into WheelModel
      wheelModel.value = WheelModel.fromJson(responseData);

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

      print("Total wheels: ${wheelModel.value?.data?.wheels?.length}");

    } catch (e) {
      print("❌ GetAllWheel() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
      wheelModel.value = null;
    } finally {
      isLoadingWheel.value = false;
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
  // ✅ GetAllTireInventory (Page/Search Required for Inventory Screen)
  // -------------------------------------------------------------
  Future<void> GetAllTireInventory({String? search, int page = 1}) async {
    try {
      isLoadingTireInventory.value = true;

      // ApiEndPoints.getTireUrl() returns: "/api/fleet/assets?type=tire&status=inStorage&search="
      String url = ApiEndPoints.getTireUrl();

      // 1. Search Logic: Append search value to the existing "search="
      if (search != null && search.isNotEmpty) {
        url += Uri.encodeComponent(search);
      }

      // 2. Pagination Logic: Append page parameter for next/previous page functionality
      // Kyunki ApiEndPoints.getTireUrl() mein pehle se '?' aur '&' hai, hum sirf '&page=' add karenge.
      url += "&page=$page";

      final responseData = await baseService.baseGetAPI(url);

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        getTireInventory.value = null;
        return;
      }

      final GetTireInventory newInventory = GetTireInventory.fromJson(responseData);

      final pagination = newInventory.data?.pagination;
      if (pagination != null) {
        currentTirePage.value = pagination.page ?? 1;
        totalTirePages.value = pagination.totalPages ?? 1;
        hasNextTirePage.value = pagination.hasNextPage ?? false;
      } else {
        currentTirePage.value = page;
        totalTirePages.value = 1;
        hasNextTirePage.value = false;
      }

      getTireInventory.value = newInventory;

    } catch (e) {
      print("❌ GetAllTireInventory ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
      getTireInventory.value = null;
    } finally {
      isLoadingTireInventory.value = false;
    }
  }

  void loadNextTirePage() {
    if (hasNextTirePage.value) {
      // Calls GetAllTireInventory with the next page number
      GetAllTireInventory(
        search: searchController.text.trim(),
        page: currentTirePage.value + 1,
      );
    }
  }

  void loadPrevTirePage() {
    if (currentTirePage.value > 1) {
      // Calls GetAllTireInventory with the previous page number
      GetAllTireInventory(
        search: searchController.text.trim(),
        page: currentTirePage.value - 1,
      );
    }
  }


// -------------------------------------------------------------
// ✅ GetAllWheelInventory (FIXED: Search & Page Parameters added correctly)
// -------------------------------------------------------------
  Future<void> GetAllWheelInventory({String? search, int page = 1}) async {
    try {
      isLoadingWheelInventory.value = true;

      // ApiEndPoints.getWheelUrl() returns: "/api/fleet/assets?type=wheel&status=inStorage&search="
      String url = ApiEndPoints.getWheelUrl();

      // 1. Search Logic: Append search value to the existing "search="
      if (search != null && search.isNotEmpty) {
        url += Uri.encodeComponent(search);
      }

      // 2. Pagination Logic: Append page parameter for next/previous page functionality
      url += "&page=$page";

      final responseData = await baseService.baseGetAPI(url);

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        getWheelInventory.value = null;
        return;
      }

      final GetWheelInventory newInventory = GetWheelInventory.fromJson(responseData);

      final pagination = newInventory.data?.pagination;
      if (pagination != null) {
        currentWheelPage.value = pagination.page ?? 1;
        totalWheelPages.value = pagination.totalPages ?? 1;
        hasNextWheelPage.value = pagination.hasNextPage ?? false;
      } else {
        currentWheelPage.value = page;
        totalWheelPages.value = 1;
        hasNextWheelPage.value = false;
      }

      getWheelInventory.value = newInventory;

    } catch (e) {
      print("❌ GetAllWheelInventory ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
      getWheelInventory.value = null;
    } finally {
      isLoadingWheelInventory.value = false;
    }
  }

  void loadNextWheelPage() {
    if (hasNextWheelPage.value) {
      // Calls GetAllWheelInventory with the next page number
      GetAllWheelInventory(
        search: searchController.text.trim(),
        page: currentWheelPage.value + 1,
      );
    }
  }

  void loadPrevWheelPage() {
    if (currentWheelPage.value > 1) {
      // Calls GetAllWheelInventory with the previous page number
      GetAllWheelInventory(
        search: searchController.text.trim(),
        page: currentWheelPage.value - 1,
      );
    }
  }
  // -------------------------------------------------------------
  // ✅ Other utility methods (Unchanged)
  // -------------------------------------------------------------

  Future<void> GetTireById(String id) async {
    try {
      isLoading.value = true;

      final responseData = await baseService.baseGetAPI(ApiEndPoints.getTireId(id));

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      getTireByIdModel.value = GetTireByIdModel.fromJson(responseData);

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

      final responseData = await baseService.baseGetAPI(ApiEndPoints.getWheelId(id));

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

  Future<void> updateTireRotation(BuildContext context) async {
    final body = {
      "tireId": getTireByIdModel.value?.data?.id.toString(),
      "mountedPosition": controller.selectedPosition.value,
      "positionNote": technicianNoteController.text.trim(),
    };

    final responseMap = await baseService.basePutAPI(
      ApiEndPoints.rotateTire,
      body: body,
      loading: true,
    );

    if (responseMap["success"] != true) return;

    final data = responseMap["data"];
    if (data == null) return;
    updateformClear();

    // Assuming formatDate is available globally or defined in a utility file
    final date = formatDate(data["updatedAt"]);
    showRotationComplete(context,id: data["_id"], serialNumber: data["serialNumber"], fromPosition: getTireByIdModel.value?.data?.mountedPosition.toString(), toPosition: data["mountedPosition"], date: date, note: data["positionNote"]);
  }


  Future<void> updateWheelRotation(BuildContext context) async {
    final body = {
      "wheelId": getWheelByIdModel.value?.data?.id.toString(),
      "mountedPosition": controller.selectedPosition.value,
      "positionNote": technicianNoteController.text.trim()
    };

    final responseMap = await baseService.basePutAPI(
      ApiEndPoints.rotateWheel,
      body: body,
      loading: true,
    );

    if (responseMap["success"] != true) return;

    final data = responseMap["data"];
    if (data == null) return;


    updateformClear();
    // Assuming formatDate is available globally or defined in a utility file
    final date = formatDate(data["updatedAt"]);
    showRotationComplete(context,id:data["_id"], serialNumber: data["serialNumber"], fromPosition: getWheelByIdModel.value?.data?.mountedPosition.toString(), toPosition: data["mountedPosition"], date: date, note: data["positionNote"], isWheel: true);

  }

  Future<void> deleteTire(String id) async{
    final responseMap = await baseService.baseDeleteAPI(
      ApiEndPoints.deleteTire(id),
      loading: true,
    );

    if (responseMap["success"] != true) return;

    final data = responseMap["data"];
    if (data == null) return;

    GetAllTireInventory();
  }

  Future<void> deleteWheel(String id) async{
    final responseMap = await baseService.baseDeleteAPI(
      ApiEndPoints.deleteWheel(id),
      loading: true,
    );

    if (responseMap["success"] != true) return;

    final data = responseMap["data"];
    if (data == null) return;

    GetAllWheelInventory();
  }

  void updateformClear(){
    controller.selectedPosition.value = "";
    technicianNoteController.clear();
  }



}
