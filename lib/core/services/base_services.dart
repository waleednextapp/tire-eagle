import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../utils/shared_prefrences_methods.dart';
import '../../utils/utility.dart';
import 'apiendpoints.dart';

class BaseService {
  late String baseURL = "http://172.16.25.79:3000";
  late String endPoint;
  late String Url = '$baseURL$endPoint';
  late String baseURLStripe = "";
  late String baseS3URL = "";

  String? token = '';
  String? stripeToken;

  // static NavigationService _navigationService = locator<NavigationService>();

  Future<bool> checkInternetConnection() async {
    bool result = await InternetConnectionChecker.instance.hasConnection;
    return result;
  }


  Future<Map<String, dynamic>> basePostAPI(String endPoint,
      dynamic body, {
        bool loading = true,
        bool? isStripe,
      }) async {
    if (loading) {
      EasyLoading.show(
        status: 'Please wait...',
        maskType: EasyLoadingMaskType.black,
      );
    }

    String basic = '';

    basic = (isStripe == true)
        ? "$stripeToken"
        : (token?.isNotEmpty == true ? "$token" : "");

    if (!await checkInternetConnection()) {
      EasyLoading.dismiss();
      Utils.showToast("Check Internet Connection", true);
      return {'success': false, 'message': 'Check Internet Connection'};
    }

    try {
      final response = await http.post(
        Uri.parse(isStripe == true ? baseURLStripe : "$baseURL$endPoint"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          if (endPoint !=
              ApiEndPoints.signupUser) 'Authorization': 'Bearer $basic',
        },
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 60));

      EasyLoading.dismiss();

      print("URL: $baseURL$endPoint");
      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");

      // -------------------------------------------
      // 🔥 SUCCESS (ANY 2xx)
      // -------------------------------------------
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonData = json.decode(response.body);

        Utils.showToast(jsonData["message"] ?? "Success", false);
        return {
          "success": true,
          ...jsonData,
        };
      }

      // -------------------------------------------
      // ❌ ERROR CASES
      // -------------------------------------------
      if (response.body.isNotEmpty) {
        var jsonData = json.decode(response.body);
        Utils.showToast(jsonData["message"] ?? "Something went wrong", true);

        return {
          "success": false,
          "message": jsonData["message"] ?? "Something went wrong",
          "statusCode": response.statusCode
        };
      }

      Utils.showToast("Something went wrong", true);
      return {"success": false, "message": "Something went wrong"};
    } on TimeoutException {
      EasyLoading.dismiss();
      Utils.showToast("Request timed out", true);
      return {"success": false, "message": "Request timed out"};
    } catch (e) {
      EasyLoading.dismiss();
      Utils.showToast("Unexpected error", true);
      return {"success": false, "message": "Unexpected error"};
    }
  }
}
