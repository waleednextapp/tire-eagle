class TireReminderModel {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;
  dynamic errors;
  int? statusCode;

  TireReminderModel({
    this.success,
    this.message,
    this.data,
    this.pagination,
    this.errors,
    this.statusCode,
  });

  TireReminderModel.fromJson(Map<String, dynamic> json) {
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
  String? brand;
  String? tireSize;
  String? plyRating;
  int? tireHealth;
  String? vehicalNumber;
  String? mountedPosition;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? positionNote;
  dynamic latestDamage;
  dynamic latestPuncture;

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
    this.positionNote,
    this.latestDamage,
    this.latestPuncture,
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
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
    positionNote = json['positionNote'] as String?;
    latestDamage = json['latestDamage'];
    latestPuncture = json['latestPuncture'];
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
    json['positionNote'] = positionNote;
    json['latestDamage'] = latestDamage;
    json['latestPuncture'] = latestPuncture;
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
