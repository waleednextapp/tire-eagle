class UserGetAllWheel {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? statusCode;

  UserGetAllWheel({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  UserGetAllWheel.fromJson(Map<String, dynamic> json) {
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
  List<UserWheels>? wheels;
  Pagination? pagination;

  Data({
    this.wheels,
    this.pagination,
  });

  Data.fromJson(Map<String, dynamic> json) {
    wheels = (json['wheels'] as List?)?.map((dynamic e) => UserWheels.fromJson(e as Map<String,dynamic>)).toList();
    pagination = (json['pagination'] as Map<String,dynamic>?) != null ? Pagination.fromJson(json['pagination'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['wheels'] = wheels?.map((e) => e.toJson()).toList();
    json['pagination'] = pagination?.toJson();
    return json;
  }
}

class UserWheels {
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
  String? positionNote;
  String? createdAt;
  String? updatedAt;
  int? v;
  dynamic retreadInfo;
  dynamic damageInfo;

  UserWheels({
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
    this.positionNote,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.retreadInfo,
    this.damageInfo,
  });

  UserWheels.fromJson(Map<String, dynamic> json) {
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
    positionNote = json['positionNote'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
    retreadInfo = json['retreadInfo'];
    damageInfo = json['damageInfo'];
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
    json['positionNote'] = positionNote;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    json['retreadInfo'] = retreadInfo;
    json['damageInfo'] = damageInfo;
    return json;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalItems;
  int? itemsPerPage;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.itemsPerPage,
    this.hasNextPage,
    this.hasPrevPage,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'] as int?;
    totalPages = json['totalPages'] as int?;
    totalItems = json['totalItems'] as int?;
    itemsPerPage = json['itemsPerPage'] as int?;
    hasNextPage = json['hasNextPage'] as bool?;
    hasPrevPage = json['hasPrevPage'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['currentPage'] = currentPage;
    json['totalPages'] = totalPages;
    json['totalItems'] = totalItems;
    json['itemsPerPage'] = itemsPerPage;
    json['hasNextPage'] = hasNextPage;
    json['hasPrevPage'] = hasPrevPage;
    return json;
  }
}
