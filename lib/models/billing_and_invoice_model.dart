class BillingAndInvoiceModel {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;
  int? statusCode;

  BillingAndInvoiceModel({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.statusCode,
  });

  factory BillingAndInvoiceModel.fromJson(Map<String, dynamic> json) {
    return BillingAndInvoiceModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null,
      errors: json['errors'],
      statusCode: json['statusCode'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
    'errors': errors,
    'statusCode': statusCode,
  };
}

class Data {
  List<Transaction>? transactions;
  Pagination? pagination;
  Filters? filters;

  Data({this.transactions, this.pagination, this.filters});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      transactions: (json['transactions'] as List?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
      filters: json['filters'] != null
          ? Filters.fromJson(json['filters'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'transactions': transactions?.map((e) => e.toJson()).toList(),
    'pagination': pagination?.toJson(),
    'filters': filters?.toJson(),
  };
}

class Transaction {
  String? id;
  String? fleetManagerId;
  User? user;
  dynamic punctureId;
  dynamic tireId;
  String? type;
  double? amount;
  String? currency;
  String? paymentStatus;
  String? description;
  Metadata? metadata;
  String? createdAt;
  String? updatedAt;
  int? v;

  Transaction({
    this.id,
    this.fleetManagerId,
    this.user,
    this.punctureId,
    this.tireId,
    this.type,
    this.amount,
    this.currency,
    this.paymentStatus,
    this.description,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'] as String?,
      fleetManagerId: json['fleetManagerId'] as String?,
      user: json['userId'] != null ? User.fromJson(json['userId']) : null,
      punctureId: json['punctureId'],
      tireId: json['tireId'],
      type: json['type'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      description: json['description'] as String?,
      metadata: json['metadata'] != null
          ? Metadata.fromJson(json['metadata'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'fleetManagerId': fleetManagerId,
    'userId': user?.toJson(),
    'punctureId': punctureId,
    'tireId': tireId,
    'type': type,
    'amount': amount,
    'currency': currency,
    'paymentStatus': paymentStatus,
    'description': description,
    'metadata': metadata?.toJson(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class User {
  String? id;
  String? name;
  String? email;

  User({this.id, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
  };
}

class Metadata {
  String? mountedPosition;
  int? punctureCount;
  int? bulgeCount;
  int? cutCount;
  String? dateOfPuncture;

  Metadata({this.mountedPosition, this.punctureCount, this.bulgeCount, this.cutCount, this.dateOfPuncture});

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    mountedPosition: json['mountedPosition'] as String?,
    punctureCount: json['punctureCount'] as int?,
    bulgeCount: json['bulgeCount'] as int?,
    cutCount: json['cutCount'] as int?,
    dateOfPuncture: json['dateOfPuncture'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'mountedPosition': mountedPosition,
    'punctureCount': punctureCount,
    'bulgeCount': bulgeCount,
    'cutCount': cutCount,
    'dateOfPuncture': dateOfPuncture,
  };
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

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json['currentPage'] as int?,
    totalPages: json['totalPages'] as int?,
    totalItems: json['totalItems'] as int?,
    itemsPerPage: json['itemsPerPage'] as int?,
    hasNextPage: json['hasNextPage'] as bool?,
    hasPrevPage: json['hasPrevPage'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'currentPage': currentPage,
    'totalPages': totalPages,
    'totalItems': totalItems,
    'itemsPerPage': itemsPerPage,
    'hasNextPage': hasNextPage,
    'hasPrevPage': hasPrevPage,
  };
}

class Filters {
  String? status;

  Filters({this.status});

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    status: json['status'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
  };
}
