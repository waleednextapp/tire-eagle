import 'package:get/get.dart';
import 'package:tire_eagle/core/services/base_services.dart';
import 'package:tire_eagle/models/diispoes_model.dart';

import '../core/services/apiendpoints.dart';
import '../models/dispose_wheel_model.dart';
import '../utils/utility.dart';


class DisposeController extends GetxController {

  // ---------------- TAB ----------------
  final inventoryTabs = ['Tire', 'Wheel'].obs;
  final inventoryIndexTab = 0.obs;
  BaseService baseService = BaseService();

  void selectInventoryValue(int index) {
    inventoryIndexTab.value = index;
  }

  // ---------------- DATA MODELS ----------------
  // Since the API call only handles one type at a time, this model can be reused.
  Rxn<DisposedModel> disposedData = Rxn<DisposedModel>();
  Rxn<DisposedWheelModel> disposedWheelData = Rxn<DisposedWheelModel>();

  // ---------------- STATES ----------------
  RxBool isLoading = false.obs;
  RxString search = "".obs;

  // ---------------- PAGINATION ----------------
  RxInt page = 1.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxBool hasNextPage = false.obs;

  // // FIXED: Initial call should be here
  // @override
  // void onInit() {
  //   super.onInit();
  //   // Initial data load for 'tire'
  //   getDisposedHistory(inventoryTabs[inventoryIndexTab.value].toLowerCase());
  // }

  // ---------------- API CALL ----------------
  // 'type' will be 'tire' or 'wheel'
  Future<void> getDisposedHistory(String type) async {
    try {
      isLoading.value = true;

      final responseData = await baseService.baseGetAPI(ApiEndPoints.returnDisposedUrl(type));

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      // Assign the response to the correct reactive variable
      if (type.toLowerCase() == 'tire') {
        disposedData.value = DisposedModel.fromJson(responseData);
        // optional: disposedData.refresh(); // only needed if updating internal list
      } else {
        disposedWheelData.value = DisposedWheelModel.fromJson(responseData);
        // optional: disposedWheelData.refresh();
      }

    } catch (e) {
      print("❌ getDisposedHistory($type) ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoading.value = false;
    }
  }


}
