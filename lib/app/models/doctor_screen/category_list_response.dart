// To parse this JSON data, do
//
//     final categoryListResponse = categoryListResponseFromJson(jsonString);

import 'dart:convert';

CategoryListResponse categoryListResponseFromJson(String str) =>
    CategoryListResponse.fromJson(json.decode(str));

String categoryListResponseToJson(CategoryListResponse data) =>
    json.encode(data.toJson());

class CategoryListResponse {
  bool? success;
  String? message;
  List<CategoryDatum>? data;

  CategoryListResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) =>
      CategoryListResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CategoryDatum>.from(
                json["data"]!.map((x) => CategoryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoryDatum {
  dynamic name;
  dynamic image;
  dynamic isDelete;
  dynamic isActive;
  dynamic id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  CategoryDatum({
    this.name,
    this.image,
    this.isDelete,
    this.isActive,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CategoryDatum.fromJson(Map<String, dynamic> json) => CategoryDatum(
        name: json["name"],
        image: json["image"],
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
        "image": image,
        "is_delete": isDelete,
        "is_active": isActive,
        "_id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
