class UserGetTireById {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? statusCode;

  UserGetTireById({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  UserGetTireById.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? userId;
  String? fleetManagerId;
  String? imageUrl;
  String? serialNumber;
  String? dateOfEntry;
  String? brand;
  String? tireSize;
  String? plyRating;
  int? tireHealth;
  String? vehicalNumber;
  String? mountedPosition;
  String? status;
  String? positionNote;
  String? createdAt;
  String? updatedAt;
  int? v;
  int? totalSpending;
  TotalDamage? totalDamage;
  List<dynamic>? reportDamages;
  List<dynamic>? retreadRecords;

  Data({
    this.id,
    this.userId,
    this.fleetManagerId,
    this.imageUrl,
    this.serialNumber,
    this.dateOfEntry,
    this.brand,
    this.tireSize,
    this.plyRating,
    this.tireHealth,
    this.vehicalNumber,
    this.mountedPosition,
    this.status,
    this.positionNote,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalSpending,
    this.totalDamage,
    this.reportDamages,
    this.retreadRecords,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    userId = json['userId'] as String?;
    fleetManagerId = json['fleetManagerId'] as String?;
    imageUrl = json['imageUrl'] as String?;
    serialNumber = json['serialNumber'] as String?;
    dateOfEntry = json['dateOfEntry'] as String?;
    brand = json['brand'] as String?;
    tireSize = json['tireSize'] as String?;
    plyRating = json['plyRating'] as String?;
    tireHealth = json['tireHealth'] as int?;
    vehicalNumber = json['vehicalNumber'] as String?;
    mountedPosition = json['mountedPosition'] as String?;
    status = json['status'] as String?;
    positionNote = json['positionNote'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
    totalSpending = json['totalSpending'] as int?;
    totalDamage = (json['totalDamage'] as Map<String,dynamic>?) != null ? TotalDamage.fromJson(json['totalDamage'] as Map<String,dynamic>) : null;
    reportDamages = json['reportDamages'] as List?;
    retreadRecords = json['retreadRecords'] as List?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['userId'] = userId;
    json['fleetManagerId'] = fleetManagerId;
    json['imageUrl'] = imageUrl;
    json['serialNumber'] = serialNumber;
    json['dateOfEntry'] = dateOfEntry;
    json['brand'] = brand;
    json['tireSize'] = tireSize;
    json['plyRating'] = plyRating;
    json['tireHealth'] = tireHealth;
    json['vehicalNumber'] = vehicalNumber;
    json['mountedPosition'] = mountedPosition;
    json['status'] = status;
    json['positionNote'] = positionNote;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    json['totalSpending'] = totalSpending;
    json['totalDamage'] = totalDamage?.toJson();
    json['reportDamages'] = reportDamages;
    json['retreadRecords'] = retreadRecords;
    return json;
  }
}

class TotalDamage {
  int? puncture;
  int? cut;
  int? bulge;

  TotalDamage({
    this.puncture,
    this.cut,
    this.bulge,
  });

  TotalDamage.fromJson(Map<String, dynamic> json) {
    puncture = json['puncture'] as int?;
    cut = json['cut'] as int?;
    bulge = json['bulge'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['puncture'] = puncture;
    json['cut'] = cut;
    json['bulge'] = bulge;
    return json;
  }
}
