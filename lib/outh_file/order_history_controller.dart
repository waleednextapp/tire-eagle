// import 'dart:async';
//
// import 'package:counteract_balancing/models/category_model.dart';
// import 'package:counteract_balancing/models/order_history_model.dart';
// import 'package:counteract_balancing/models/result_model.dart';
// import 'package:counteract_balancing/services/base_services.dart';
// import 'package:counteract_balancing/utils/dummy_content.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import '../components/custom_ads.dart';
// import '../components/custom_toast.dart';
// import '../models/product_size_model.dart';
// import '../models/transition_model.dart';
// import '../services/api_endpoints.dart';
// import '../utils/SharedPreferencesMethod.dart';
// import '../utils/utils.dart';
//
// class OrderHistoryController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   BaseService baseService = BaseService();
//   Rx<OrderHistoryModel> orderHistoryResponse = OrderHistoryModel().obs;
//   Rx<TransitionModel> qrTransactionResponse = TransitionModel().obs;
//
//   RxBool isFetch = false.obs;
//   RxBool isFetch1 = false.obs;
//   RxBool isConnected = false.obs;
//
//   RxInt selectedIndex = 1.obs;
//
//
//
//   Future<void> getOrderHistory() async {
//     isFetch.value = false;
//     Map data = await SharedPreferencesMethod.getUserInfo();
//     baseService.token = data['token'];
//     var a = await baseService.baseGetAPI('${APIEndpoints.claimRewardsHistoryUrl}');
//     if (a != false) {
//       orderHistoryResponse.value = OrderHistoryModel.fromJson(a);
//       isConnected.value = true;
//       if (orderHistoryResponse.value.status == true) {
//         isFetch.value = true;
//         print('arsalan here');
//       } else {
//         isFetch.value = true;
//       }
//     } else {
//       isConnected.value = false;
//     }
//   }
//
//
//   Future<void> getTransitionHistory() async {
//     isFetch1.value = false;
//     Map data = await SharedPreferencesMethod.getUserInfo();
//     baseService.token = data['token'];
//     var a = await baseService.baseGetAPI('${APIEndpoints.qrTransactionHistoryUrl}');
//     if (a != false) {
//       qrTransactionResponse.value = TransitionModel.fromJson(a);
//       isConnected.value = true;
//       if (qrTransactionResponse.value.status == true) {
//         isFetch1.value = true;
//         print('arsalan here');
//       } else {
//         isFetch1.value = true;
//       }
//     } else {
//       isConnected.value = false;
//     }
//   }
//
//
//
// }
