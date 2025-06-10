// To parse this JSON data, do
//
//     final initiateChatResponse = initiateChatResponseFromJson(jsonString);

import 'dart:convert';

InitiateChatResponse initiateChatResponseFromJson(String str) =>
    InitiateChatResponse.fromJson(json.decode(str));

String initiateChatResponseToJson(InitiateChatResponse data) =>
    json.encode(data.toJson());

class InitiateChatResponse {
  bool? success;
  InitiateData? data;

  InitiateChatResponse({
    this.success,
    this.data,
  });

  factory InitiateChatResponse.fromJson(Map<String, dynamic> json) =>
      InitiateChatResponse(
        success: json["success"],
        data: json["data"] == null ? null : InitiateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class InitiateData {
  String? id;
  String? name;
  String? email;
  String? profilePic;

  InitiateData({
    this.id,
    this.name,
    this.email,
    this.profilePic,
  });

  factory InitiateData.fromJson(Map<String, dynamic> json) => InitiateData(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "profile_pic": profilePic,
      };
}
