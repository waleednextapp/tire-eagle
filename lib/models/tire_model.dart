class TireModel {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? statusCode;

  TireModel({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  TireModel.fromJson(Map<String, dynamic> json) {
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
  List<Tires>? tires;
  Totals? totals;
  Pagination? pagination;

  Data({
    this.tires,
    this.totals,
    this.pagination,
  });

  Data.fromJson(Map<String, dynamic> json) {
    tires = (json['tires'] as List?)?.map((dynamic e) => Tires.fromJson(e as Map<String,dynamic>)).toList();
    totals = (json['totals'] as Map<String,dynamic>?) != null ? Totals.fromJson(json['totals'] as Map<String,dynamic>) : null;
    pagination = (json['pagination'] as Map<String,dynamic>?) != null ? Pagination.fromJson(json['pagination'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['tires'] = tires?.map((e) => e.toJson()).toList();
    json['totals'] = totals?.toJson();
    json['pagination'] = pagination?.toJson();
    return json;
  }
}

class Tires {
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
  RetreadInfo? retreadInfo;
  DamageInfo? damageInfo;
  PunctureInfo? punctureInfo;
  int? totalCost;

  Tires({
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
    this.retreadInfo,
    this.damageInfo,
    this.punctureInfo,
    this.totalCost,
  });

  Tires.fromJson(Map<String, dynamic> json) {
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
    retreadInfo = (json['retreadInfo'] as Map<String,dynamic>?) != null ? RetreadInfo.fromJson(json['retreadInfo'] as Map<String,dynamic>) : null;
    damageInfo = (json['damageInfo'] as Map<String,dynamic>?) != null ? DamageInfo.fromJson(json['damageInfo'] as Map<String,dynamic>) : null;
    punctureInfo = (json['punctureInfo'] as Map<String,dynamic>?) != null ? PunctureInfo.fromJson(json['punctureInfo'] as Map<String,dynamic>) : null;
    totalCost = json['totalCost'] as int?;
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
    json['retreadInfo'] = retreadInfo?.toJson();
    json['damageInfo'] = damageInfo?.toJson();
    json['punctureInfo'] = punctureInfo?.toJson();
    json['totalCost'] = totalCost;
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

class RetreadInfo {
  String? centerName;
  int? cost;
  String? estimatedReturnDate;

  RetreadInfo({
    this.centerName,
    this.cost,
    this.estimatedReturnDate,
  });

  RetreadInfo.fromJson(Map<String, dynamic> json) {
    centerName = json['centerName'] as String?;
    cost = json['cost'] as int?;
    estimatedReturnDate = json['estimatedReturnDate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['centerName'] = centerName;
    json['cost'] = cost;
    json['estimatedReturnDate'] = estimatedReturnDate;
    return json;
  }
}

class DamageInfo {
  String? createdAt;
  DamageType? damageType;

  DamageInfo({
    this.createdAt,
    this.damageType,
  });

  DamageInfo.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'] as String?;
    damageType = (json['damageType'] as Map<String,dynamic>?) != null ? DamageType.fromJson(json['damageType'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['createdAt'] = createdAt;
    json['damageType'] = damageType?.toJson();
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

class PunctureInfo {
  String? dateOfPuncture;
  int? cost;
  String? mountedPosition;

  PunctureInfo({
    this.dateOfPuncture,
    this.cost,
    this.mountedPosition,
  });

  PunctureInfo.fromJson(Map<String, dynamic> json) {
    dateOfPuncture = json['dateOfPuncture'] as String?;
    cost = json['cost'] as int?;
    mountedPosition = json['mountedPosition'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['dateOfPuncture'] = dateOfPuncture;
    json['cost'] = cost;
    json['mountedPosition'] = mountedPosition;
    return json;
  }
}

class Totals {
  int? totalRetreadCost;
  int? totalPunctureCost;
  int? totalCost;

  Totals({
    this.totalRetreadCost,
    this.totalPunctureCost,
    this.totalCost,
  });

  Totals.fromJson(Map<String, dynamic> json) {
    totalRetreadCost = json['totalRetreadCost'] as int?;
    totalPunctureCost = json['totalPunctureCost'] as int?;
    totalCost = json['totalCost'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['totalRetreadCost'] = totalRetreadCost;
    json['totalPunctureCost'] = totalPunctureCost;
    json['totalCost'] = totalCost;
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
