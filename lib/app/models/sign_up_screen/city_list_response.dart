// To parse this JSON data, do
//
//     final cityListResponse = cityListResponseFromJson(jsonString);

import 'dart:convert';

CityListResponse cityListResponseFromJson(String str) =>
    CityListResponse.fromJson(json.decode(str));

String cityListResponseToJson(CityListResponse data) =>
    json.encode(data.toJson());

class CityListResponse {
  bool? success;
  String? message;
  List<CityDatum>? data;

  CityListResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CityListResponse.fromJson(Map<String, dynamic> json) =>
      CityListResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CityDatum>.from(
                json["data"]!.map((x) => CityDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CityDatum {
  String? name;
  String? id;

  CityDatum({
    this.name,
    this.id,
  });

  factory CityDatum.fromJson(Map<String, dynamic> json) => CityDatum(
        name: json["name"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
      };
}
