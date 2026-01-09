class GetTireByIdModel {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? statusCode;

  GetTireByIdModel({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  GetTireByIdModel.fromJson(Map<String, dynamic> json) {
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
  dynamic mountedPosition;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;
  Dismount? dismount;
  int? totalSpending;
  TotalDamage? totalDamage;
  List<ReportDamages>? reportDamages;
  List<RetreadRecords>? retreadRecords;

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
    this.createdAt,
    this.updatedAt,
    this.v,
    this.dismount,
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
    mountedPosition = json['mountedPosition'];
    status = json['status'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
    dismount = (json['dismount'] as Map<String,dynamic>?) != null ? Dismount.fromJson(json['dismount'] as Map<String,dynamic>) : null;
    totalSpending = json['totalSpending'] as int?;
    totalDamage = (json['totalDamage'] as Map<String,dynamic>?) != null ? TotalDamage.fromJson(json['totalDamage'] as Map<String,dynamic>) : null;
    reportDamages = (json['reportDamages'] as List?)?.map((dynamic e) => ReportDamages.fromJson(e as Map<String,dynamic>)).toList();
    retreadRecords = (json['retreadRecords'] as List?)?.map((dynamic e) => RetreadRecords.fromJson(e as Map<String,dynamic>)).toList();
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
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    json['dismount'] = dismount?.toJson();
    json['totalSpending'] = totalSpending;
    json['totalDamage'] = totalDamage?.toJson();
    json['reportDamages'] = reportDamages?.map((e) => e.toJson()).toList();
    json['retreadRecords'] = retreadRecords?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Dismount {
  String? reason;
  String? storageLocation;

  Dismount({
    this.reason,
    this.storageLocation,
  });

  Dismount.fromJson(Map<String, dynamic> json) {
    reason = json['reason'] as String?;
    storageLocation = json['storageLocation'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['reason'] = reason;
    json['storageLocation'] = storageLocation;
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

class ReportDamages {
  String? id;
  String? fleetManagerId;
  String? tireId;
  String? location;
  DamageType? damageType;
  String? severity;
  String? dateOfEntry;
  String? note;
  String? createdAt;
  String? updatedAt;
  int? v;

  ReportDamages({
    this.id,
    this.fleetManagerId,
    this.tireId,
    this.location,
    this.damageType,
    this.severity,
    this.dateOfEntry,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  ReportDamages.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    fleetManagerId = json['fleetManagerId'] as String?;
    tireId = json['tireId'] as String?;
    location = json['location'] as String?;
    damageType = (json['damageType'] as Map<String,dynamic>?) != null ? DamageType.fromJson(json['damageType'] as Map<String,dynamic>) : null;
    severity = json['severity'] as String?;
    dateOfEntry = json['dateOfEntry'] as String?;
    note = json['note'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['fleetManagerId'] = fleetManagerId;
    json['tireId'] = tireId;
    json['location'] = location;
    json['damageType'] = damageType?.toJson();
    json['severity'] = severity;
    json['dateOfEntry'] = dateOfEntry;
    json['note'] = note;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    return json;
  }
}

class DamageType {
  int? puncture;
  int? cut;
  int? bulge;

  DamageType({
    this.puncture,
    this.cut,
    this.bulge,
  });

  DamageType.fromJson(Map<String, dynamic> json) {
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

class RetreadRecords {
  String? id;
  String? fleetManagerId;
  String? tireId;
  String? serialNumber;
  String? mountedPosition;
  String? tireHealth;
  List<dynamic>? retreadHistory;
  String? centerName;
  int? averageCost;
  String? pickupLogistics;
  String? dateOfDamage;
  String? estimatedReturnDate;
  int? cost;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  int? v;

  RetreadRecords({
    this.id,
    this.fleetManagerId,
    this.tireId,
    this.serialNumber,
    this.mountedPosition,
    this.tireHealth,
    this.retreadHistory,
    this.centerName,
    this.averageCost,
    this.pickupLogistics,
    this.dateOfDamage,
    this.estimatedReturnDate,
    this.cost,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  RetreadRecords.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    fleetManagerId = json['fleetManagerId'] as String?;
    tireId = json['tireId'] as String?;
    serialNumber = json['serialNumber'] as String?;
    mountedPosition = json['mountedPosition'] as String?;
    tireHealth = json['tireHealth'] as String?;
    retreadHistory = json['retreadHistory'] as List?;
    centerName = json['centerName'] as String?;
    averageCost = json['averageCost'] as int?;
    pickupLogistics = json['pickupLogistics'] as String?;
    dateOfDamage = json['dateOfDamage'] as String?;
    estimatedReturnDate = json['estimatedReturnDate'] as String?;
    cost = json['cost'] as int?;
    paymentStatus = json['paymentStatus'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['fleetManagerId'] = fleetManagerId;
    json['tireId'] = tireId;
    json['serialNumber'] = serialNumber;
    json['mountedPosition'] = mountedPosition;
    json['tireHealth'] = tireHealth;
    json['retreadHistory'] = retreadHistory;
    json['centerName'] = centerName;
    json['averageCost'] = averageCost;
    json['pickupLogistics'] = pickupLogistics;
    json['dateOfDamage'] = dateOfDamage;
    json['estimatedReturnDate'] = estimatedReturnDate;
    json['cost'] = cost;
    json['paymentStatus'] = paymentStatus;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    return json;
  }
}





