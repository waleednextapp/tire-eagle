class HomeModel {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? statusCode;

  HomeModel({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  Summary? summary;
  List<Tires>? tires;

  Data({
    this.summary,
    this.tires,
  });

  Data.fromJson(Map<String, dynamic> json) {
    summary = (json['summary'] as Map<String,dynamic>?) != null ? Summary.fromJson(json['summary'] as Map<String,dynamic>) : null;
    tires = (json['tires'] as List?)?.map((dynamic e) => Tires.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['summary'] = summary?.toJson();
    json['tires'] = tires?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Summary {
  int? totalTires;
  int? totalWheels;

  Summary({
    this.totalTires,
    this.totalWheels,
  });

  Summary.fromJson(Map<String, dynamic> json) {
    totalTires = json['totalTires'] as int?;
    totalWheels = json['totalWheels'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['totalTires'] = totalTires;
    json['totalWheels'] = totalWheels;
    return json;
  }
}

class Tires {
  String? id;
  String? serialNumber;
  String? brand;
  String? tireSize;
  int? tireHealth;
  int? remainingDistance;
  String? vehicleNumber;
  String? mountedPosition;
  String? status;
  String? imageUrl;
  String? updatedAt;

  Tires({
    this.id,
    this.serialNumber,
    this.brand,
    this.tireSize,
    this.tireHealth,
    this.remainingDistance,
    this.vehicleNumber,
    this.mountedPosition,
    this.status,
    this.imageUrl,
    this.updatedAt,
  });

  Tires.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    serialNumber = json['serialNumber'] as String?;
    brand = json['brand'] as String?;
    tireSize = json['tireSize'] as String?;
    tireHealth = json['tireHealth'] as int?;
    remainingDistance = json['remainingDistance'] as int?;
    vehicleNumber = json['vehicleNumber'] as String?;
    mountedPosition = json['mountedPosition'] as String?;
    status = json['status'] as String?;
    imageUrl = json['imageUrl'] as String?;
    updatedAt = json['updatedAt'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['serialNumber'] = serialNumber;
    json['brand'] = brand;
    json['tireSize'] = tireSize;
    json['tireHealth'] = tireHealth;
    json['remainingDistance'] = remainingDistance;
    json['vehicleNumber'] = vehicleNumber;
    json['mountedPosition'] = mountedPosition;
    json['status'] = status;
    json['imageUrl'] = imageUrl;
    json['updatedAt'] = updatedAt;
    return json;
  }
}
