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
import '../utils/utility.dart';
import '../widgets/rotation_complete_dialog.dart';

class TotalTireController extends GetxController{
  final DashboardController controller = Get.find<DashboardController>();
  RxBool isLoading = true.obs;
  RxBool isLoadingWheel = true.obs;
  RxBool isLoadingTireInventory = true.obs;
  RxBool isLoadingWheelInventory = true.obs;
  BaseService baseService = BaseService();
  Rx<TireModel?> tireModel = Rx<TireModel?>(null);
  Rx<WheelModel?> wheelModel = Rx<WheelModel?>(null);
  Rx<GetTireByIdModel?> getTireByIdModel = Rx<GetTireByIdModel?>(null);
  Rx<GetWheelByIdModel?> getWheelByIdModel = Rx<GetWheelByIdModel?>(null);
  Rx<GetTireInventory?> getTireInventory = Rx<GetTireInventory?>(null);
  Rx<GetWheelInventory?> getWheelInventory = Rx<GetWheelInventory?>(null);
  final TextEditingController searchController = TextEditingController();
  final TextEditingController technicianNoteController = TextEditingController();





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

  Future<void> GetTireById(String id) async {
    try {
      isLoading.value = true;

      final responseData = await baseService.baseGetAPI(ApiEndPoints.getTireId(id));

      // ❌ API failed
      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      // ✅ Parse JSON into HomeModel
      getTireByIdModel.value = GetTireByIdModel.fromJson(responseData);

      print("🏠 getTireByIdModel Parsed:");
      print(getTireByIdModel.value?.toJson());

      // Example usage:
      print("Total Rethread Count: ${getTireByIdModel.value?.data?.retreadRecords?.length}");

    } catch (e) {
      print("❌ Home() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> GetWheelById(String id) async {
    try {
      isLoading.value = true;

      final responseData = await baseService.baseGetAPI(ApiEndPoints.getWheelId(id));

      // ❌ API failed
      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      // ✅ Parse JSON into HomeModel
      getWheelByIdModel.value = GetWheelByIdModel.fromJson(responseData);

      print("🏠 getTireByIdModel Parsed:");
      print(getWheelByIdModel.value?.toJson());

      // Example usage:
      print("Total Rethread Count: ${getWheelByIdModel.value?.data?.retreadRecords?.length}");

    } catch (e) {
      print("❌ Home() ERROR: $e");
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

    print("🔍 BODY SENT TO API:");
    print("tireId: ${body["tireId"]}");
    print("mountedPosition: ${body["mountedPosition"]}");
    print("positionNote: ${body["positionNote"]}");

    final responseMap = await baseService.basePutAPI(
      ApiEndPoints.rotateTire,
      body: body,
      loading: true,
    );

    if (responseMap["success"] != true) return;

    final data = responseMap["data"];
    if (data == null) return;
    updateformClear();

    final date = formatDate(data["updatedAt"]);
    showRotationComplete(context,id: data["_id"], serialNumber: data["serialNumber"], fromPosition: getTireByIdModel.value?.data?.mountedPosition.toString(), toPosition: data["mountedPosition"], date: date, note: data["positionNote"]);
    // ✅ Correct
    print("🎉 ROTATION UPDATE SUCCESS");

  }


  Future<void> updateWheelRotation(BuildContext context) async {
    final body = {
      // "tireId": getTireByIdModel.value?.data?.id.toString(),
      // "mountedPosition": controller.selectedPosition,
      // "positionNote": technicianNoteController.text.trim(),
      "wheelId": getWheelByIdModel.value?.data?.id.toString(),
      "mountedPosition": controller.selectedPosition.value,
      "positionNote": technicianNoteController.text.trim()
    };

    // 🔥 PRINT THE BODY VALUES
    print("🔍 BODY SENT TO API:");
    print("wheelId: ${body["wheelId"]}");
    print("mountedPosition: ${body["mountedPosition"]}");
    print("positionNote: ${body["positionNote"]}");

    final responseMap = await baseService.basePutAPI(
      ApiEndPoints.rotateWheel,
      body: body,
      loading: true,
    );

    if (responseMap["success"] != true) return;

    final data = responseMap["data"];
    if (data == null) return;


    updateformClear();
    // Show success dialog
    final date = formatDate(data["updatedAt"]);
    showRotationComplete(context,id:data["_id"], serialNumber: data["serialNumber"], fromPosition: getWheelByIdModel.value?.data?.mountedPosition.toString(), toPosition: data["mountedPosition"], date: date, note: data["positionNote"], isWheel: true);

    print("🎉 PROFILE UPDATE SUCCESS → ${data["email"]}");

    // Clear fields (if needed)
  }

  void updateformClear(){
    controller.selectedPosition.value = "";
    technicianNoteController.clear();
  }





}
