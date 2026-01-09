class WheelReminderModel {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;
  dynamic errors;
  int? statusCode;

  WheelReminderModel({
    this.success,
    this.message,
    this.data,
    this.pagination,
    this.errors,
    this.statusCode,
  });

  WheelReminderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();
    pagination = (json['pagination'] as Map<String,dynamic>?) != null ? Pagination.fromJson(json['pagination'] as Map<String,dynamic>) : null;
    errors = json['errors'];
    statusCode = json['statusCode'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['message'] = message;
    json['data'] = data?.map((e) => e.toJson()).toList();
    json['pagination'] = pagination?.toJson();
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
  String? material;
  String? wheelSize;
  int? wheelHealth;
  String? wheelCondition;
  String? vehicalNumber;
  String? mountedPosition;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? positionNote;
  LatestDamage? latestDamage;

  Data({
    this.id,
    this.userId,
    this.fleetManagerId,
    this.imageUrl,
    this.serialNumber,
    this.dateOfEntry,
    this.material,
    this.wheelSize,
    this.wheelHealth,
    this.wheelCondition,
    this.vehicalNumber,
    this.mountedPosition,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.positionNote,
    this.latestDamage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    userId = json['userId'] as String?;
    fleetManagerId = json['fleetManagerId'] as String?;
    imageUrl = json['imageUrl'] as String?;
    serialNumber = json['serialNumber'] as String?;
    dateOfEntry = json['dateOfEntry'] as String?;
    material = json['material'] as String?;
    wheelSize = json['wheelSize'] as String?;
    wheelHealth = json['wheelHealth'] as int?;
    wheelCondition = json['wheelCondition'] as String?;
    vehicalNumber = json['vehicalNumber'] as String?;
    mountedPosition = json['mountedPosition'] as String?;
    status = json['status'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
    positionNote = json['positionNote'] as String?;
    latestDamage = (json['latestDamage'] as Map<String,dynamic>?) != null ? LatestDamage.fromJson(json['latestDamage'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['userId'] = userId;
    json['fleetManagerId'] = fleetManagerId;
    json['imageUrl'] = imageUrl;
    json['serialNumber'] = serialNumber;
    json['dateOfEntry'] = dateOfEntry;
    json['material'] = material;
    json['wheelSize'] = wheelSize;
    json['wheelHealth'] = wheelHealth;
    json['wheelCondition'] = wheelCondition;
    json['vehicalNumber'] = vehicalNumber;
    json['mountedPosition'] = mountedPosition;
    json['status'] = status;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    json['positionNote'] = positionNote;
    json['latestDamage'] = latestDamage?.toJson();
    return json;
  }
}

class LatestDamage {
  String? id;
  String? fleetManagerId;
  String? wheelId;
  String? location;
  DamageType? damageType;
  String? severity;
  String? dateOfEntry;
  String? note;
  String? createdAt;
  String? updatedAt;
  int? v;

  LatestDamage({
    this.id,
    this.fleetManagerId,
    this.wheelId,
    this.location,
    this.damageType,
    this.severity,
    this.dateOfEntry,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  LatestDamage.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    fleetManagerId = json['fleetManagerId'] as String?;
    wheelId = json['wheelId'] as String?;
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
    json['wheelId'] = wheelId;
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
  int? cut;
  int? bulge;

  DamageType({
    this.cut,
    this.bulge,
  });

  DamageType.fromJson(Map<String, dynamic> json) {
    cut = json['cut'] as int?;
    bulge = json['bulge'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['cut'] = cut;
    json['bulge'] = bulge;
    return json;
  }
}

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'] as int?;
    page = json['page'] as int?;
    limit = json['limit'] as int?;
    totalPages = json['totalPages'] as int?;
    hasNextPage = json['hasNextPage'] as bool?;
    hasPrevPage = json['hasPrevPage'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['total'] = total;
    json['page'] = page;
    json['limit'] = limit;
    json['totalPages'] = totalPages;
    json['hasNextPage'] = hasNextPage;
    json['hasPrevPage'] = hasPrevPage;
    return json;
  }
}
