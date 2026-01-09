class HistoryAndReportModel {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? statusCode;

  HistoryAndReportModel({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  HistoryAndReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'];
    statusCode = json['statusCode'];
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

class Data {
  Range? range;
  Pagination? pagination;
  int? totalDays;
  List<Entries>? entries;

  Data({
    this.range,
    this.pagination,
    this.totalDays,
    this.entries,
  });

  Data.fromJson(Map<String, dynamic> json) {
    range = json['range'] != null ? Range.fromJson(json['range']) : null;
    pagination =
    json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    totalDays = json['totalDays'];
    entries = json['entries'] != null
        ? List<Entries>.from(
      json['entries'].map((e) => Entries.fromJson(e)),
    )
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'range': range?.toJson(),
      'pagination': pagination?.toJson(),
      'totalDays': totalDays,
      'entries': entries?.map((e) => e.toJson()).toList(),
    };
  }
}

class Range {
  String? startDate;
  String? endDate;

  Range({this.startDate, this.endDate});

  Range.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
    };
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
    page = json['page'];
    limit = json['limit'];
    totalEntries = json['totalEntries'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'totalEntries': totalEntries,
      'totalPages': totalPages,
      'hasNextPage': hasNextPage,
      'hasPrevPage': hasPrevPage,
    };
  }
}

class Entries {
  String? date;
  List<Tiresfull>? tires;
  List<Wheels>? wheels;

  Entries({
    this.date,
    this.tires,
    this.wheels,
  });

  Entries.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    tires = json['tires'] != null
        ? List<Tiresfull>.from(json['tires'].map((e) => Tiresfull.fromJson(e)))
        : null;
    wheels = json['wheels'] != null
        ? List<Wheels>.from(json['wheels'].map((e) => Wheels.fromJson(e)))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'tires': tires?.map((e) => e.toJson()).toList(),
      'wheels': wheels?.map((e) => e.toJson()).toList(),
    };
  }
}

class Tiresfull {
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
  String? positionNote;
  Dismount? dismount;

  Tiresfull({
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
    this.dismount,
  });

  Tiresfull.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    fleetManagerId = json['fleetManagerId'];
    imageUrl = json['imageUrl'];
    serialNumber = json['serialNumber'];
    dateOfEntry = json['dateOfEntry'];
    brand = json['brand'];

    /// Correct Mapping (tireSize field from API)
    tireSize = json['tireSize'];

    /// Add missing plyRating
    plyRating = json['plyRating'];

    tireHealth = json['tireHealth'];
    vehicalNumber = json['vehicalNumber'];
    mountedPosition = json['mountedPosition'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    positionNote = json['positionNote'];

    dismount =
    json['dismount'] != null ? Dismount.fromJson(json['dismount']) : null;
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
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'positionNote': positionNote,
      'dismount': dismount?.toJson(),
    };
  }
}

class Wheels {
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
  dynamic mountedPosition;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? positionNote;
  Dismount? dismount;

  Wheels({
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
    this.dismount,
  });

  Wheels.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    fleetManagerId = json['fleetManagerId'];
    imageUrl = json['imageUrl'];
    serialNumber = json['serialNumber'];
    dateOfEntry = json['dateOfEntry'];
    material = json['material'];
    wheelSize = json['wheelSize'];
    wheelHealth = json['wheelHealth'];
    wheelCondition = json['wheelCondition'];
    vehicalNumber = json['vehicalNumber'];
    mountedPosition = json['mountedPosition'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    positionNote = json['positionNote'];
    dismount = json['dismount'] != null
        ? Dismount.fromJson(json['dismount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'fleetManagerId': fleetManagerId,
      'imageUrl': imageUrl,
      'serialNumber': serialNumber,
      'dateOfEntry': dateOfEntry,
      'material': material,
      'wheelSize': wheelSize,
      'wheelHealth': wheelHealth,
      'wheelCondition': wheelCondition,
      'vehicalNumber': vehicalNumber,
      'mountedPosition': mountedPosition,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'positionNote': positionNote,
      'dismount': dismount?.toJson(),
    };
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
    reason = json['reason'];
    storageLocation = json['storageLocation'];
  }

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'storageLocation': storageLocation,
    };
  }
}
