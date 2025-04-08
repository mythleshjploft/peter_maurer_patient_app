// To parse this JSON data, do
//
//     final conditionListResponse = conditionListResponseFromJson(jsonString);

import 'dart:convert';

ConditionListResponse conditionListResponseFromJson(String str) =>
    ConditionListResponse.fromJson(json.decode(str));

String conditionListResponseToJson(ConditionListResponse data) =>
    json.encode(data.toJson());

class ConditionListResponse {
  String? message;
  bool? success;
  List<ConditionDatum>? data;

  ConditionListResponse({
    this.message,
    this.success,
    this.data,
  });

  factory ConditionListResponse.fromJson(Map<String, dynamic> json) =>
      ConditionListResponse(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<ConditionDatum>.from(
                json["data"]!.map((x) => ConditionDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ConditionDatum {
  dynamic name;
  dynamic isDelete;
  dynamic isActive;
  dynamic id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  ConditionDatum({
    this.name,
    this.isDelete,
    this.isActive,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ConditionDatum.fromJson(Map<String, dynamic> json) => ConditionDatum(
        name: json["name"],
        isDelete: json["is_delete"],
        isActive: json["is_active"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "is_delete": isDelete,
        "is_active": isActive,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
