// ===================== ROOT MODEL =====================

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

  factory UserGetAllTire.fromJson(Map<String, dynamic> json) {
    return UserGetAllTire(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      errors: json['errors'],
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'errors': errors,
      'statusCode': statusCode,
    };
  }
}

// ===================== DATA =====================

class Data {
  List<Tires>? tires;
  Totals? totals;
  Pagination? pagination;

  Data({this.tires, this.totals, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      tires: (json['tires'] as List?)
          ?.map((e) => Tires.fromJson(e))
          .toList(),
      totals: json['totals'] != null ? Totals.fromJson(json['totals']) : null,
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tires': tires?.map((e) => e.toJson()).toList(),
      'totals': totals?.toJson(),
      'pagination': pagination?.toJson(),
    };
  }
}

// ===================== TIRES =====================

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
  int? remainingDistance;
  String? status;
  String? positionNote;
  String? createdAt;
  String? updatedAt;

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
    this.remainingDistance,
    this.status,
    this.positionNote,
    this.createdAt,
    this.updatedAt,
    this.dismount,
    this.retreadInfo,
    this.damageInfo,
    this.punctureInfo,
    this.totalCost,
  });

  factory Tires.fromJson(Map<String, dynamic> json) {
    return Tires(
      id: json['_id'],
      userId: json['userId'],
      fleetManagerId: json['fleetManagerId'],
      imageUrl: json['imageUrl'],
      serialNumber: json['serialNumber'],
      dateOfEntry: json['dateOfEntry'],
      brand: json['brand'],
      tireSize: json['tireSize'],
      plyRating: json['plyRating'],
      tireHealth: json['tireHealth'],
      vehicalNumber: json['vehicalNumber'],
      mountedPosition: json['mountedPosition'],
      remainingDistance: json['remainingDistance'],
      status: json['status'],
      positionNote: json['positionNote'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      dismount:
      json['dismount'] != null ? Dismount.fromJson(json['dismount']) : null,
      retreadInfo: json['retreadInfo'] != null
          ? RetreadInfo.fromJson(json['retreadInfo'])
          : null,
      damageInfo: json['damageInfo'] != null
          ? DamageInfo.fromJson(json['damageInfo'])
          : null,
      punctureInfo: json['punctureInfo'] != null
          ? PunctureInfo.fromJson(json['punctureInfo'])
          : null,
      totalCost: json['totalCost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'fleetManagerId': fleetManagerId,
      'imageUrl': imageUrl,
      'serialNumber': serialNumber,
      'dateOfEntry': dateOfEntry,
      'brand': brand,
      'tireSize': tireSize,
      'plyRating': plyRating,
      'tireHealth': tireHealth,
      'vehicalNumber': vehicalNumber,
      'mountedPosition': mountedPosition,
      'remainingDistance': remainingDistance,
      'status': status,
      'positionNote': positionNote,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'dismount': dismount?.toJson(),
      'retreadInfo': retreadInfo?.toJson(),
      'damageInfo': damageInfo?.toJson(),
      'punctureInfo': punctureInfo?.toJson(),
      'totalCost': totalCost,
    };
  }
}

// ===================== DISMOUNT =====================

class Dismount {
  String? reason;
  String? storageLocation;

  Dismount({this.reason, this.storageLocation});

  factory Dismount.fromJson(Map<String, dynamic> json) {
    return Dismount(
      reason: json['reason'],
      storageLocation: json['storageLocation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'storageLocation': storageLocation,
    };
  }
}

// ===================== RETREAD INFO =====================

class RetreadInfo {
  String? centerName;
  int? cost;
  String? estimatedReturnDate;

  RetreadInfo({this.centerName, this.cost, this.estimatedReturnDate});

  factory RetreadInfo.fromJson(Map<String, dynamic> json) {
    return RetreadInfo(
      centerName: json['centerName'],
      cost: json['cost'],
      estimatedReturnDate: json['estimatedReturnDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'centerName': centerName,
      'cost': cost,
      'estimatedReturnDate': estimatedReturnDate,
    };
  }
}

// ===================== DAMAGE INFO =====================

class DamageInfo {
  String? createdAt;
  DamageType? damageType;

  DamageInfo({this.createdAt, this.damageType});

  factory DamageInfo.fromJson(Map<String, dynamic> json) {
    return DamageInfo(
      createdAt: json['createdAt'],
      damageType: json['damageType'] != null
          ? DamageType.fromJson(json['damageType'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'damageType': damageType?.toJson(),
    };
  }
}

class DamageType {
  int? puncture;
  int? cut;
  int? bulge;

  DamageType({this.puncture, this.cut, this.bulge});

  factory DamageType.fromJson(Map<String, dynamic> json) {
    return DamageType(
      puncture: json['puncture'] ?? 0,
      cut: json['cut'] ?? 0,
      bulge: json['bulge'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'puncture': puncture,
      'cut': cut,
      'bulge': bulge,
    };
  }
}

// ===================== PUNCTURE INFO =====================

class PunctureInfo {
  String? dateOfPuncture;
  int? cost;
  String? mountedPosition;

  PunctureInfo({this.dateOfPuncture, this.cost, this.mountedPosition});

  factory PunctureInfo.fromJson(Map<String, dynamic> json) {
    return PunctureInfo(
      dateOfPuncture: json['dateOfPuncture'],
      cost: json['cost'],
      mountedPosition: json['mountedPosition'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateOfPuncture': dateOfPuncture,
      'cost': cost,
      'mountedPosition': mountedPosition,
    };
  }
}

// ===================== TOTALS =====================

class Totals {
  int? totalRetreadCost;
  int? totalPunctureCost;
  int? totalCost;

  Totals({this.totalRetreadCost, this.totalPunctureCost, this.totalCost});

  factory Totals.fromJson(Map<String, dynamic> json) {
    return Totals(
      totalRetreadCost: json['totalRetreadCost'],
      totalPunctureCost: json['totalPunctureCost'],
      totalCost: json['totalCost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalRetreadCost': totalRetreadCost,
      'totalPunctureCost': totalPunctureCost,
      'totalCost': totalCost,
    };
  }
}

// ===================== PAGINATION =====================

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

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      itemsPerPage: json['itemsPerPage'],
      hasNextPage: json['hasNextPage'],
      hasPrevPage: json['hasPrevPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalItems': totalItems,
      'itemsPerPage': itemsPerPage,
      'hasNextPage': hasNextPage,
      'hasPrevPage': hasPrevPage,
    };
  }
}
