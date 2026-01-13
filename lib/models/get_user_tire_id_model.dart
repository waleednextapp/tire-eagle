class UserGetTireById {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? statusCode;

  UserGetTireById({this.success, this.message, this.data, this.errors, this.statusCode});

  UserGetTireById.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    data = (json['data'] as Map<String, dynamic>?) != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null;
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
  // 💡 dynamic ki jagah ab classes use hongi
  List<ReportDamage>? reportDamages;
  List<RetreadRecord>? retreadRecords;

  Data({
    this.id, this.userId, this.fleetManagerId, this.imageUrl, this.serialNumber,
    this.dateOfEntry, this.brand, this.tireSize, this.plyRating, this.tireHealth,
    this.vehicalNumber, this.mountedPosition, this.status, this.positionNote,
    this.createdAt, this.updatedAt, this.v, this.totalSpending, this.totalDamage,
    this.reportDamages, this.retreadRecords,
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
    totalDamage = (json['totalDamage'] as Map<String, dynamic>?) != null ? TotalDamage.fromJson(json['totalDamage'] as Map<String, dynamic>) : null;

    // 💡 Sahi Mapping for ReportDamages
    if (json['reportDamages'] != null) {
      reportDamages = <ReportDamage>[];
      json['reportDamages'].forEach((v) {
        reportDamages!.add(ReportDamage.fromJson(v));
      });
    }

    // 💡 Sahi Mapping for RetreadRecords
    if (json['retreadRecords'] != null) {
      retreadRecords = <RetreadRecord>[];
      json['retreadRecords'].forEach((v) {
        retreadRecords!.add(RetreadRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userId'] = userId;
    data['fleetManagerId'] = fleetManagerId;
    data['imageUrl'] = imageUrl;
    data['serialNumber'] = serialNumber;
    data['dateOfEntry'] = dateOfEntry;
    data['brand'] = brand;
    data['tireSize'] = tireSize;
    data['plyRating'] = plyRating;
    data['tireHealth'] = tireHealth;
    data['vehicalNumber'] = vehicalNumber;
    data['mountedPosition'] = mountedPosition;
    data['status'] = status;
    data['positionNote'] = positionNote;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    data['totalSpending'] = totalSpending;
    data['totalDamage'] = totalDamage?.toJson();
    data['reportDamages'] = reportDamages?.map((v) => v.toJson()).toList();
    data['retreadRecords'] = retreadRecords?.map((v) => v.toJson()).toList();
    return data;
  }
}

// 💡 New Class for RetreadRecord
class RetreadRecord {
  String? id;
  String? fleetManagerId;
  String? tireId;
  String? serialNumber;
  String? mountedPosition;
  String? tireHealth;
  String? centerName;
  int? averageCost;
  String? pickupLogistics;
  String? dateOfDamage;
  String? estimatedReturnDate;
  int? cost;
  String? paymentStatus;

  RetreadRecord.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fleetManagerId = json['fleetManagerId'];
    tireId = json['tireId'];
    serialNumber = json['serialNumber'];
    mountedPosition = json['mountedPosition'];
    tireHealth = json['tireHealth'].toString();
    centerName = json['centerName'];
    averageCost = json['averageCost'];
    pickupLogistics = json['pickupLogistics'];
    dateOfDamage = json['dateOfDamage'];
    estimatedReturnDate = json['estimatedReturnDate'];
    cost = json['cost'];
    paymentStatus = json['paymentStatus'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'centerName': centerName,
      'averageCost': averageCost,
      'dateOfDamage': dateOfDamage,
      // Baki fields add kar saktay hain agar zaroorat ho
    };
  }
}

// 💡 New Class for ReportDamage
class ReportDamage {
  String? id;
  String? dateOfEntry;
  String? location;
  TotalDamage? damageType; // TotalDamage class reuse ho sakti hai puncture/cut/bulge ke liye

  ReportDamage.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    dateOfEntry = json['dateOfEntry'];
    location = json['location'];
    damageType = json['damageType'] != null ? TotalDamage.fromJson(json['damageType']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'dateOfEntry': dateOfEntry,
      'location': location,
    };
  }
}

class TotalDamage {
  int? puncture;
  int? cut;
  int? bulge;

  TotalDamage({this.puncture, this.cut, this.bulge});

  TotalDamage.fromJson(Map<String, dynamic> json) {
    puncture = json['puncture'] as int?;
    cut = json['cut'] as int?;
    bulge = json['bulge'] as int?;
  }

  Map<String, dynamic> toJson() {
    return {'puncture': puncture, 'cut': cut, 'bulge': bulge};
  }
}
