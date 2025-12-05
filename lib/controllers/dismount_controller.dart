import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tire_eagle/controllers/total_tire_controller.dart';
import 'package:tire_eagle/core/services/base_services.dart';

import '../core/services/apiendpoints.dart';

class DismountController extends GetxController {
  // -1 means no widget is selected initially
  final selectedIndex = (-1).obs;
  final selectedWarehouseIndex = (-1).obs;
  final otherReasonController = TextEditingController();
  BaseService baseService = BaseService();
  final TotalTireController controller = Get.find<TotalTireController>();

  // Dismount reasons list for easy mapping
  final dismountReasons = [
    {"title": "Low Tread", "path": "assets/png/dismount_images/tool.png", "msg": "Tread below safety\nthreshold"},
    {"title": "Damaged", "path": "assets/png/dismount_images/alert.png", "msg": "Significant tire damage"},
    {"title": "Vehicle Service", "path": "assets/png/dismount_images/van.png", "msg": "Removed during\nmaintenance"},
    {"title": "Rotation", "path": "assets/png/dismount_images/recycle.png", "msg": "Regular tire rotation"},
    {"title": "End of Life", "path": "assets/png/dismount_images/bin.png", "msg": "Tread below safety\nthreshold"},
    {"title": "Other", "path": "assets/png/dismount_images/add.png", "msg": "Custom reason"},
  ];

  void selectReason(int index) {
    selectedIndex.value = index;
  }

  // --- Inside DismountController.dart ---

  String getSelectedDismountReason() {
    final index = selectedIndex.value;
    String reasonTitle = "";

    switch (index) {
      case 0:
        reasonTitle = "Low Tread";
        break;
      case 1:
        reasonTitle = "Damaged";
        break;
      case 2:
        reasonTitle = "Vehicle Service";
        break;
      case 3:
        reasonTitle = "Rotation";
        break;
      case 4:
        reasonTitle = "End of Life";
        break;
      case 5:
      // If 'Other' is selected (index 5)
        final customReason = otherReasonController.text.trim();
        if (customReason.isNotEmpty) {
          reasonTitle = "Other: $customReason";
        } else {
          reasonTitle = "Other (Reason not specified)";
        }
        break;
      default:
      // Case where nothing is selected, though validation should prevent this.
        reasonTitle = "No Reason Selected";
        break;
    }
    return reasonTitle;
  }

  // --- Inside DismountController.dart ---

// Ensure you have this variable defined in DismountController:
// final selectedWarehouseIndex = (-1).obs;

  String getSelectedStorageLocation() {
    final index = selectedWarehouseIndex.value;
    String location = "";

    switch (index) {
      case 0:
        location = "Main Warehouse (Bay A-12)";
        break;
      case 1:
        location = "Repair Shop (Service Area)";
        break;
      case 2:
        location = "Recycling Center (Bay A-12)";
        break;
      case 3:
        location = "Old Warehouse (Bay A-12)";
        break;
      default:
        location = "Location Not Assigned";
        break;
    }
    return location;
  }


  // Check if "Other" is selected to show the text field
  bool get isOtherSelected => selectedIndex.value == 5; // Assuming 'Other' is the 6th item (index 5)
  Future<void> DismountTire(BuildContext context,{bool? isWheel}) async {
    final body = {
      "tireId": controller.getTireByIdModel.value?.data?.id,
      "reason":getSelectedDismountReason(),
      "storageLocation":getSelectedStorageLocation()
    };


    final responseMap = await baseService.basePutAPI(
      ApiEndPoints.dismountTire,
      body: body,
      loading: true,
    );

    if (responseMap["success"] != true) return;

    final data = responseMap["data"];
    if (data == null) return;
    clear();
    Get.toNamed("assignstoragelocationone",arguments: isWheel);

    // Clear fields (if needed)
  }
  Future<void> DismountWheel(BuildContext context,{bool? isWheel}) async {
    final body = {
      "wheelId": controller.getWheelByIdModel.value?.data?.id,
      "reason":getSelectedDismountReason(),
      "storageLocation":getSelectedStorageLocation()
    };


    final responseMap = await baseService.basePutAPI(
      ApiEndPoints.dismountWheel,
      body: body,
      loading: true,
    );

    if (responseMap["success"] != true) return;

    final data = responseMap["data"];
    if (data == null) return;
    clear();
    Get.toNamed("assignstoragelocationone",arguments: isWheel);

    // Clear fields (if needed)
  }
  void clear(){
    otherReasonController.clear();
    selectedIndex.value = (-1);
    selectedWarehouseIndex.value = (-1);
  }
  @override
  void onClose() {
    otherReasonController.dispose();
    super.onClose();
  }
}
