class FleetModel {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? statusCode;

  FleetModel({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  FleetModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;
    errors = json['errors'];
    statusCode = json['statusCode'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['message'] = message;
    json['data'] = data?.toJson();
    json['errors'] = errors;
    json['statusCode'] = statusCode;
    return json;
  }
}

class Data {
  FleetManager? fleetManager;
  String? token;

  Data({
    this.fleetManager,
    this.token,
  });

  Data.fromJson(Map<String, dynamic> json) {
    fleetManager = (json['fleetManager'] as Map<String,dynamic>?) != null ? FleetManager.fromJson(json['fleetManager'] as Map<String,dynamic>) : null;
    token = json['token'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['fleetManager'] = fleetManager?.toJson();
    json['token'] = token;
    return json;
  }
}

class FleetManager {
  String? id;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;

  FleetManager({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  FleetManager.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    name = json['name'] as String?;
    email = json['email'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['name'] = name;
    json['email'] = email;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    return json;
  }
}
