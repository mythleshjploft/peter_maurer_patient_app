// To parse this JSON data, do
//
//     final socialLoginResponse = socialLoginResponseFromJson(jsonString);

import 'dart:convert';

SocialLoginResponse socialLoginResponseFromJson(String str) =>
    SocialLoginResponse.fromJson(json.decode(str));

String socialLoginResponseToJson(SocialLoginResponse data) =>
    json.encode(data.toJson());

class SocialLoginResponse {
  final bool? success;
  final String? message;
  final Data? data;

  SocialLoginResponse({
    this.success,
    this.message,
    this.data,
  });

  factory SocialLoginResponse.fromJson(Map<String, dynamic> json) =>
      SocialLoginResponse(
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
  final UserData? user;
  final dynamic token;

  Data({
    this.user,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class UserData {
  final dynamic uid;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic gender;
  final dynamic countryCode;
  final dynamic mobileNumber;
  final dynamic email;
  final dynamic dob;
  final dynamic countryId;
  final dynamic cityId;
  final dynamic zipCode;
  final dynamic otp;
  final dynamic language;
  final dynamic image;
  final dynamic isActive;
  final dynamic isDelete;
  final dynamic isOtpVerify;
  final dynamic addedBy;
  final dynamic type;
  final dynamic deviceToken;
  final dynamic deviceType;
  final dynamic socialId;
  final dynamic loginType;
  final dynamic profession;
  final dynamic startDate;
  final dynamic id;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic v;

  UserData({
    this.uid,
    this.firstName,
    this.lastName,
    this.gender,
    this.countryCode,
    this.mobileNumber,
    this.email,
    this.dob,
    this.countryId,
    this.cityId,
    this.zipCode,
    this.otp,
    this.language,
    this.image,
    this.isActive,
    this.isDelete,
    this.isOtpVerify,
    this.addedBy,
    this.type,
    this.deviceToken,
    this.deviceType,
    this.socialId,
    this.loginType,
    this.profession,
    this.startDate,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uid: json["uid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        countryCode: json["country_code"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        dob: json["dob"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        zipCode: json["zip_code"],
        otp: json["otp"],
        language: json["language"],
        image: json["image"],
        isActive: json["is_active"],
        isDelete: json["is_delete"],
        isOtpVerify: json["is_otp_verify"],
        addedBy: json["added_by"],
        type: json["type"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        socialId: json["social_id"],
        loginType: json["login_type"],
        profession: json["profession"],
        startDate: json["start_date"],
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
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "country_code": countryCode,
        "mobile_number": mobileNumber,
        "email": email,
        "dob": dob,
        "country_id": countryId,
        "city_id": cityId,
        "zip_code": zipCode,
        "otp": otp,
        "language": language,
        "image": image,
        "is_active": isActive,
        "is_delete": isDelete,
        "is_otp_verify": isOtpVerify,
        "added_by": addedBy,
        "type": type,
        "device_token": deviceToken,
        "device_type": deviceType,
        "social_id": socialId,
        "login_type": loginType,
        "profession": profession,
        "start_date": startDate,
        "_id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
