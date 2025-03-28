// To parse this JSON data, do
//
//     final countryListResponse = countryListResponseFromJson(jsonString);

import 'dart:convert';

CountryListResponse countryListResponseFromJson(String str) =>
    CountryListResponse.fromJson(json.decode(str));

String countryListResponseToJson(CountryListResponse data) =>
    json.encode(data.toJson());

class CountryListResponse {
  bool? success;
  String? error;
  List<CountryDatum>? data;

  CountryListResponse({
    this.success,
    this.error,
    this.data,
  });

  factory CountryListResponse.fromJson(Map<String, dynamic> json) =>
      CountryListResponse(
        success: json["success"],
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<CountryDatum>.from(
                json["data"]!.map((x) => CountryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CountryDatum {
  String? name;
  String? id;

  CountryDatum({
    this.name,
    this.id,
  });

  factory CountryDatum.fromJson(Map<String, dynamic> json) => CountryDatum(
        name: json["name"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
      };
}
