import 'dart:async';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import '../../outh_file/local_db_key.dart';
import '../../utils/shared_prefrences_methods.dart';
import '../../utils/utility.dart';

class BaseService {
  // late String baseURL = "http://172.16.25.79:5000/tire-eagle";
  late String baseURL = "http://app.yourwebsitemockup.net/tire-eagle";
  late String endPoint;
  late String Url = '$baseURL$endPoint';
  late String baseURLStripe = "";
  late String baseS3URL = "";
  final prefs = SharedPreferencesMethod.storage;

  String? token = '';
  String? stripeToken;

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
    var bearerToken = await prefs.getString(LocalDBKeys.TOKEN);
    String basic = '';

    basic = (isStripe == true)
        ? "$stripeToken"
        : (token?.isNotEmpty == true ? "$token" : "");

    // if (!await checkInternetConnection()) {
    //   EasyLoading.dismiss();
    //   Utils.showToast("Check Internet Connection", true);
    //   return {'success': false, 'message': 'Check Internet Connection'};
    // }

    try {
      final response = await http.post(
        Uri.parse(isStripe == true ? baseURLStripe : "$baseURL$endPoint"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken',
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

  Future<Map<String, dynamic>> baseGetAPI(
      String endPoint, {
        bool loading = true,
        bool? isStripe,
      }) async {
    if (loading) {
      // NOTE: Original code had EasyLoading commented out here. Keeping it that way.
      // EasyLoading.show(
      //   status: 'Please wait...',
      //   maskType: EasyLoadingMaskType.black,
      // );
    }

    var bearerToken = await prefs.getString(LocalDBKeys.TOKEN);

    // if (!await checkInternetConnection()) {
    //   EasyLoading.dismiss();
    //   Utils.showToast("Check Internet Connection", true);
    //   return {'success': false, 'message': 'Check Internet Connection'};
    // }

    try {
      final response = await http
          .get(
        Uri.parse(isStripe == true ? baseURLStripe : "$baseURL$endPoint"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken',
        },
      )
          .timeout(const Duration(seconds: 60));

      EasyLoading.dismiss();

      print("GET URL: $baseURL$endPoint");
      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");

      // ---------- SUCCESS ----------
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonData = json.decode(response.body);
        return {"success": true, ...jsonData};
      }

      // ---------- ERROR ----------
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

  Future<Map<String, dynamic>> basePutAPI(
      String endPoint, {
        required Map<String, dynamic> body,
        bool loading = true,
        bool? isStripe,
      }) async {
    if (loading) {
      EasyLoading.show(
        status: 'Please wait...',
        maskType: EasyLoadingMaskType.black,
      );
    }

    var bearerToken = await prefs.getString(LocalDBKeys.TOKEN);

    // if (!await checkInternetConnection()) {
    //   EasyLoading.dismiss();
    //   Utils.showToast("Check Internet Connection", true);
    //   return {'success': false, 'message': 'Check Internet Connection'};
    // }

    try {
      final response = await http
          .put(
        Uri.parse(isStripe == true ? baseURLStripe : "$baseURL$endPoint"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken',
        },
        body: json.encode(body),
      )
          .timeout(const Duration(seconds: 60));

      EasyLoading.dismiss();

      print("PUT URL: $baseURL$endPoint");
      print("Body: $body");
      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");

      // ---------- SUCCESS ----------
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonData = json.decode(response.body);
        return {"success": true, ...jsonData};
      }

      // ---------- ERROR ----------
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

  // 💡 NEW FUNCTION: baseDeleteAPI
  Future<Map<String, dynamic>> baseDeleteAPI(
      String endPoint, {
        bool loading = true,
        bool? isStripe,
      }) async {
    if (loading) {
      EasyLoading.show(
        status: 'Please wait...',
        maskType: EasyLoadingMaskType.black,
      );
    }

    var bearerToken = await prefs.getString(LocalDBKeys.TOKEN);

    // if (!await checkInternetConnection()) {
    //   EasyLoading.dismiss();
    //   Utils.showToast("Check Internet Connection", true);
    //   return {'success': false, 'message': 'Check Internet Connection'};
    // }

    try {
      final response = await http
          .delete(
        Uri.parse(isStripe == true ? baseURLStripe : "$baseURL$endPoint"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $bearerToken',
        },
      )
          .timeout(const Duration(seconds: 60));

      EasyLoading.dismiss();

      print("DELETE URL: $baseURL$endPoint");
      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");

      // ---------- SUCCESS (Typically 200 or 204 No Content for DELETE) ----------
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Handle 204 No Content gracefully (response.body might be empty)
        if (response.body.isEmpty || response.statusCode == 204) {
          Utils.showToast("Deleted successfully", false);
          return {"success": true, "message": "Deleted successfully"};
        }

        var jsonData = json.decode(response.body);
        Utils.showToast(jsonData["message"] ?? "Deleted successfully", false);
        return {"success": true, ...jsonData};
      }

      // ---------- ERROR ----------
      if (response.body.isNotEmpty) {
        var jsonData = json.decode(response.body);
        Utils.showToast(jsonData["message"] ?? "Deletion failed", true);
        return {
          "success": false,
          "message": jsonData["message"] ?? "Deletion failed",
          "statusCode": response.statusCode
        };
      }

      Utils.showToast("Something went wrong during deletion", true);
      return {"success": false, "message": "Something went wrong during deletion"};
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
