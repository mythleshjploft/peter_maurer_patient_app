// To parse this JSON data, do
//
//     final preExistDiseaseListResponse = preExistDiseaseListResponseFromJson(jsonString);

import 'dart:convert';

PreExistDiseaseListResponse preExistDiseaseListResponseFromJson(String str) =>
    PreExistDiseaseListResponse.fromJson(json.decode(str));

String preExistDiseaseListResponseToJson(PreExistDiseaseListResponse data) =>
    json.encode(data.toJson());

class PreExistDiseaseListResponse {
  bool? success;
  String? message;
  List<DiseaseDatum>? data;

  PreExistDiseaseListResponse({
    this.success,
    this.message,
    this.data,
  });

  factory PreExistDiseaseListResponse.fromJson(Map<String, dynamic> json) =>
      PreExistDiseaseListResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DiseaseDatum>.from(
                json["data"]!.map((x) => DiseaseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DiseaseDatum {
  dynamic name;
  dynamic surgery;
  dynamic isDelete;
  dynamic isActive;
  dynamic id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  DiseaseDatum({
    this.name,
    this.surgery,
    this.isDelete,
    this.isActive,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DiseaseDatum.fromJson(Map<String, dynamic> json) => DiseaseDatum(
        name: json["name"],
        surgery: json["surgery"],
        isDelete: json["is_delete"],
        isActive: json["is_active"],
        id: json["_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surgery": surgery,
        "is_delete": isDelete,
        "is_active": isActive,
        "_id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
