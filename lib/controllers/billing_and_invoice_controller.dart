import 'package:get/get.dart';
import 'package:tire_eagle/core/services/base_services.dart';
import 'package:tire_eagle/models/billing_and_invoice_model.dart';

import '../core/services/apiendpoints.dart';
import '../utils/utility.dart';

class BillingAndInvoiceController extends GetxController{
  BaseService baseService = BaseService();
  RxBool isLoading = true.obs;

  Rx<BillingAndInvoiceModel?> billingData = Rx<BillingAndInvoiceModel?>(null);
  Future<void> GetAllBillingAndInvoices(String status) async {
    // If the selected tab data is already loaded, you might want to skip the call,
    // but for simplicity and fresh data, we call it every time the tab changes.
    try {
      // Clear previous data before loading new type's data
      billingData.value = null;
      isLoading.value = true;

      // The API call logic remains the same, it now depends on the 'type' parameter
        // Assuming returnDisposedUrl handles both 'tire' and 'wheel' API endpoints
        final responseData = await baseService.baseGetAPI(ApiEndPoints.returnBillingUrl(status));

        if (responseData["success"] != true) {
          Utils.showToast(responseData["message"] ?? "Something went wrong", true);
          return;
        }

      billingData.value = BillingAndInvoiceModel.fromJson(responseData);

    } catch (e) {
      print("❌ getDisposedHistory($status) ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoading.value = false;
    }
  }
}
