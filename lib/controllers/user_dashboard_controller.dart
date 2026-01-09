import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tire_eagle/core/services/base_services.dart';
import 'package:tire_eagle/models/user_home_model.dart';

import '../core/services/apiendpoints.dart';
import '../utils/utility.dart';

class UserDashboardController extends GetxController{
  RxBool isLoading = true.obs;
  BaseService baseService = BaseService();
  Rx<UserHome?> userHomeModel = Rx<UserHome?>(null);
  TextEditingController searchController = TextEditingController();
  RxList<Tires> filteredTires = <Tires>[].obs;
  void searchTire(String query) {
    if (query.isEmpty) {
      filteredTires.value = userHomeModel.value?.data?.tires ?? [];
      return;
    }

    filteredTires.value = userHomeModel.value!.data!.tires!
        .where((tire) =>
        (tire.serialNumber ?? "")
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }

  Future<void> GetUserHome() async {
    try {
      isLoading.value = true;

      final responseData = await baseService.baseGetAPI(ApiEndPoints.userHome);

      // ❌ API failed
      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      // ✅ Parse JSON into HomeModel
      userHomeModel.value = UserHome.fromJson(responseData);

// Default full list
      filteredTires.value = userHomeModel.value?.data?.tires ?? [];

      print("🏠 HomeModel Parsed:");
      print(userHomeModel.value?.toJson());

      // Example usage:
      print("Total Tires: ${userHomeModel.value?.data?.summary?.totalTires}");
      print("Tires Count: ${userHomeModel.value?.data?.tires?.length}");

    } catch (e) {
      print("❌ Home() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoading.value = false;
    }
  }
}
