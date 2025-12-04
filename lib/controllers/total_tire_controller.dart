import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tire_eagle/controllers/dashboard_controller.dart';
import 'package:tire_eagle/models/get_inventory_tire_model.dart';
import 'package:tire_eagle/models/tire_model.dart';
import 'package:tire_eagle/models/wheel_model.dart';

import '../core/services/apiendpoints.dart';
import '../core/services/base_services.dart';
import '../models/get_inventory_wheel_model.dart';
import '../utils/utility.dart';

class TotalTireController extends GetxController{
  final DashboardController controller = Get.find<DashboardController>();
  RxBool isLoading = true.obs;
  RxBool isLoadingWheel = true.obs;
  RxBool isLoadingTireInventory = true.obs;
  RxBool isLoadingWheelInventory = true.obs;
  BaseService baseService = BaseService();
  Rx<TireModel?> tireModel = Rx<TireModel?>(null);
  Rx<WheelModel?> wheelModel = Rx<WheelModel?>(null);
  Rx<GetTireInventory?> getTireInventory = Rx<GetTireInventory?>(null);
  Rx<GetWheelInventory?> getWheelInventory = Rx<GetWheelInventory?>(null);
  final TextEditingController searchController = TextEditingController();





  Future<void> GetAllTire() async {
    try {
      isLoading.value = true;

      final responseData = await baseService.baseGetAPI(ApiEndPoints.getAllTires);

      // ❌ API failed
      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      // ✅ Parse JSON into HomeModel
      tireModel.value = TireModel.fromJson(responseData);

      print("🏠 HomeModel Parsed:");
      print(tireModel.value?.toJson());

      // Example usage:
      print("Total Tires: ${tireModel.value?.data?.tires?.length}");
      print("Tires Count: ${tireModel.value?.data?.tires?.length}");

    } catch (e) {
      print("❌ Home() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> GetAllWheel() async {
    try {
      isLoadingWheel.value = true;

      final responseData = await baseService.baseGetAPI(ApiEndPoints.getAllWheel);

      // ❌ API failed
      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      // ✅ Parse JSON into HomeModel
      wheelModel.value = WheelModel.fromJson(responseData);

      print("🏠 wheelModel Parsed:");
      print(wheelModel.value?.toJson());

      // Example usage:
      print("Total wheel: ${wheelModel.value?.data?.wheels?.length}");
      print("wheel Count: ${wheelModel.value?.data?.wheels?.length}");

    } catch (e) {
      print("❌ Home() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoadingWheel.value = false;
    }
  }


  Future<void> GetAllTireInventory({String? search}) async {
    try {
      isLoadingTireInventory.value = true;

      // 1️⃣ Base URL
      String url = ApiEndPoints.getTireUrl(); // e.g. http://172.16.25.79:3000/api/fleet/assets?type=tire&status=inStorage

      // 2️⃣ Append search query if exists
      if (search != null && search.isNotEmpty) {
        // Agar URL already ?search= nahi hai
        if (!url.contains("search=")) {
          url += "&search=${Uri.encodeComponent(search)}";
        } else {
          // Replace existing search query
          url = url.replaceAll(RegExp(r"search=[^&]*"), "search=${Uri.encodeComponent(search)}");
        }
      }

      // 3️⃣ Call API
      final responseData = await baseService.baseGetAPI(url);

      // 4️⃣ Handle response
      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      getTireInventory.value = GetTireInventory.fromJson(responseData);

      print("🏠 tireInventoryModel Parsed:");
      print(getTireInventory.value?.toJson());
      print(getTireInventory.value?.data?.items?.length);

    } catch (e) {
      print("❌ GetAllTireInventory ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoadingTireInventory.value = false;
    }
  }

  Future<void> GetAllWheelInventory({String? search}) async {
    try {
      isLoadingWheelInventory.value = true;
// 1️⃣ Base URL
      String url = ApiEndPoints.getWheelUrl(); // e.g. http://172.16.25.79:3000/api/fleet/assets?type=tire&status=inStorage

      // 2️⃣ Append search query if exists
      if (search != null && search.isNotEmpty) {
        // Agar URL already ?search= nahi hai
        if (!url.contains("search=")) {
          url += "&search=${Uri.encodeComponent(search)}";
        } else {
          // Replace existing search query
          url = url.replaceAll(RegExp(r"search=[^&]*"), "search=${Uri.encodeComponent(search)}");
        }
      }

      final responseData = await baseService.baseGetAPI(url);

      // ❌ API failed
      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      // ✅ Parse JSON into HomeModel

        getWheelInventory.value = GetWheelInventory.fromJson(responseData);

        print("🏠 wheelInventoryModel Parsed:");
        print(getWheelInventory.value?.toJson());
        print(getWheelInventory.value?.data?.items?.length);



    } catch (e) {
      print("❌ Home() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoadingWheelInventory.value = false;

    }
  }

}
