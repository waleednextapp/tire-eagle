class GetWheelInventory {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? statusCode;

  GetWheelInventory({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  GetWheelInventory.fromJson(Map<String, dynamic> json) {
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
  String? type;
  Filters? filters;
  Pagination? pagination;
  List<Items>? items;

  Data({
    this.type,
    this.filters,
    this.pagination,
    this.items,
  });

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String?;
    filters = (json['filters'] as Map<String,dynamic>?) != null ? Filters.fromJson(json['filters'] as Map<String,dynamic>) : null;
    pagination = (json['pagination'] as Map<String,dynamic>?) != null ? Pagination.fromJson(json['pagination'] as Map<String,dynamic>) : null;
    items = (json['items'] as List?)?.map((dynamic e) => Items.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['type'] = type;
    json['filters'] = filters?.toJson();
    json['pagination'] = pagination?.toJson();
    json['items'] = items?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Filters {
  String? status;
  dynamic search;

  Filters({
    this.status,
    this.search,
  });

  Filters.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['search'] = search;
    return json;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? totalEntries;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({
    this.page,
    this.limit,
    this.totalEntries,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'] as int?;
    limit = json['limit'] as int?;
    totalEntries = json['totalEntries'] as int?;
    totalPages = json['totalPages'] as int?;
    hasNextPage = json['hasNextPage'] as bool?;
    hasPrevPage = json['hasPrevPage'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['page'] = page;
    json['limit'] = limit;
    json['totalEntries'] = totalEntries;
    json['totalPages'] = totalPages;
    json['hasNextPage'] = hasNextPage;
    json['hasPrevPage'] = hasPrevPage;
    return json;
  }
}

class Items {
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

  Items({
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
  });

  Items.fromJson(Map<String, dynamic> json) {
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
    return json;
  }
}
