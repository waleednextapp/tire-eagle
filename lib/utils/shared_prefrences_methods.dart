import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../outh_file/local_db_key.dart';

class SharedPreferencesMethod {
  static SharedPreferences storage = Get.find<SharedPreferences>();

  /// ========================= CLEAR STORAGE ========================= ///
  static Future<void> clearLocalStorage() async {
    await storage.clear();
  }

  /// ========================= BOOL ========================= ///
  static Future<bool> setBool({
    required String key,
    required bool value,
  }) async {
    return storage.setBool(key, value);
  }

  static bool getBool({
    required String key,
    bool defaultValue = false,
  }) {
    return storage.getBool(key) ?? defaultValue;
  }

  /// ========================= STRING ========================= ///
  static Future<bool> setString({
    required String key,
    required String value,
  }) async {
    return storage.setString(key, value);
  }

  static String getString(
      String key, {
        String defaultValue = "",
      }) {
    return storage.getString(key) ?? defaultValue;
  }

  /// ========================= USER INFO (SIMPLE MAP) ========================= ///
  static Map<String, String> getUserInfo() {
    return {
      "token": storage.getString(LocalDBKeys.TOKEN) ?? "",
      "id": storage.getString(LocalDBKeys.USERID) ?? "",
      "email": storage.getString(LocalDBKeys.USEREMAIL) ?? "",
    };
  }

  /// ========================= USER INFO (DATA MODEL) ========================= ///
  static Future<Data?> getUserInfo1() async {
    final raw = storage.getString(LocalDBKeys.USERDETAIL);
    if (raw == null) return null;

    return Data.fromJson(jsonDecode(raw));
  }

  static Future<bool> setUserInfo1(Data user) async {
    return storage.setString(
      LocalDBKeys.USERDETAIL,
      jsonEncode(user.toJson()),
    );
  }

  /// ========================= USER ID ONLY ========================= ///
  static String? getUserId() {
    return storage.getString(LocalDBKeys.USERID);
  }
}

/// **********************************************************************
/// *                             DATA MODEL                             *
/// **********************************************************************
class Data {
  final String? id;
  final String? email;
  final String? token;

  Data({
    this.id,
    this.email,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "token": token,
    };
  }
}
