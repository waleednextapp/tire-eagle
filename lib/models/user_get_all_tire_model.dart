class UserGetAllTire {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? statusCode;

  UserGetAllTire({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  UserGetAllTire.fromJson(Map<String, dynamic> json) {
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
  String? mountedPosition;
  String? status;
  String? positionNote;
  String? createdAt;
  String? updatedAt;
  dynamic retreadInfo;
  dynamic damageInfo;
  dynamic punctureInfo;
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
    this.positionNote,
    this.createdAt,
    this.updatedAt,
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
    mountedPosition = json['mountedPosition'] as String?;
    status = json['status'] as String?;
    positionNote = json['positionNote'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    retreadInfo = json['retreadInfo'];
    damageInfo = json['damageInfo'];
    punctureInfo = json['punctureInfo'];
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
    json['positionNote'] = positionNote;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['retreadInfo'] = retreadInfo;
    json['damageInfo'] = damageInfo;
    json['punctureInfo'] = punctureInfo;
    json['totalCost'] = totalCost;
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
