// To parse this JSON data, do
//
//     final uplooadMediaResponse = uplooadMediaResponseFromJson(jsonString);

import 'dart:convert';

UplooadMediaResponse uplooadMediaResponseFromJson(String str) =>
    UplooadMediaResponse.fromJson(json.decode(str));

String uplooadMediaResponseToJson(UplooadMediaResponse data) =>
    json.encode(data.toJson());

class UplooadMediaResponse {
  bool? success;
  String? message;
  Data? data;

  UplooadMediaResponse({
    this.success,
    this.message,
    this.data,
  });

  factory UplooadMediaResponse.fromJson(Map<String, dynamic> json) =>
      UplooadMediaResponse(
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
  dynamic image;
  dynamic pdf;
  dynamic audio;
  dynamic video;

  Data({
    this.image,
    this.pdf,
    this.audio,
    this.video,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        image: json["image"],
        pdf: json["pdf"],
        audio: json["audio"],
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "pdf": pdf,
        "audio": audio,
        "video": video,
      };
}
