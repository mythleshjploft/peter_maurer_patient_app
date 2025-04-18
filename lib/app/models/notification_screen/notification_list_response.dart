// To parse this JSON data, do
//
//     final notificationListResponse = notificationListResponseFromJson(jsonString);

import 'dart:convert';

NotificationListResponse notificationListResponseFromJson(String str) =>
    NotificationListResponse.fromJson(json.decode(str));

String notificationListResponseToJson(NotificationListResponse data) =>
    json.encode(data.toJson());

class NotificationListResponse {
  bool? success;
  String? message;
  Data? data;

  NotificationListResponse({
    this.success,
    this.message,
    this.data,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) =>
      NotificationListResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<NoticationData>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  Data({
    this.docs,
    this.totalDocs,
    this.limit,
    this.page,
    this.totalPages,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        docs: json["docs"] == null
            ? []
            : List<NoticationData>.from(
                json["docs"]!.map((x) => NoticationData.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        page: json["page"],
        totalPages: json["totalPages"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "docs": docs == null
            ? []
            : List<dynamic>.from(docs!.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "page": page,
        "totalPages": totalPages,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class NoticationData {
  String? id;
  String? title;
  String? description;
  String? type;
  bool? isRead;
  String? toId;
  String? fromId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  User? user;

  NoticationData({
    this.id,
    this.title,
    this.description,
    this.type,
    this.isRead,
    this.toId,
    this.fromId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.user,
  });

  factory NoticationData.fromJson(Map<String, dynamic> json) => NoticationData(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        isRead: json["is_read"],
        toId: json["to_id"],
        fromId: json["from_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "type": type,
        "is_read": isRead,
        "to_id": toId,
        "from_id": fromId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "user": user?.toJson(),
      };
}

class User {
  String? firstName;
  String? lastName;
  String? image;
  String? id;

  User({
    this.firstName,
    this.lastName,
    this.image,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "_id": id,
      };
}
