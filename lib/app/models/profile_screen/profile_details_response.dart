// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileDetailResponse profileResponseFromJson(String str) =>
    ProfileDetailResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileDetailResponse data) =>
    json.encode(data.toJson());

class ProfileDetailResponse {
  bool? success;
  String? message;
  ProfileDetailResponseData? data;

  ProfileDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ProfileDetailResponse.fromJson(Map<String, dynamic> json) =>
      ProfileDetailResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : ProfileDetailResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProfileDetailResponseData {
  ProfileDatum? data;

  ProfileDetailResponseData({
    this.data,
  });

  factory ProfileDetailResponseData.fromJson(Map<String, dynamic> json) =>
      ProfileDetailResponseData(
        data: json["data"] == null ? null : ProfileDatum.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ProfileDatum {
  dynamic id;
  dynamic uid;
  dynamic firstName;
  dynamic lastName;
  dynamic gender;
  dynamic countryCode;
  dynamic mobileNumber;
  dynamic email;
  dynamic dob;
  CountryId? countryId;
  CityId? cityId;
  dynamic zipCode;
  dynamic otp;
  dynamic language;
  dynamic image;
  dynamic isActive;
  dynamic isDelete;
  dynamic isOtpVerify;
  dynamic addedBy;
  dynamic type;
  dynamic deviceToken;
  dynamic deviceType;
  dynamic socialId;
  dynamic loginType;
  dynamic profession;
  dynamic startDate;
  dynamic password;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  ProfileDatum({
    this.id,
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
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileDatum.fromJson(Map<String, dynamic> json) => ProfileDatum(
        id: json["_id"],
        uid: json["uid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        countryCode: json["country_code"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        dob: json["dob"],
        countryId: json["country_id"] == null
            ? null
            : CountryId.fromJson(json["country_id"]),
        cityId:
            json["city_id"] == null ? null : CityId.fromJson(json["city_id"]),
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
        password: json["password"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "country_code": countryCode,
        "mobile_number": mobileNumber,
        "email": email,
        "dob": dob,
        "country_id": countryId?.toJson(),
        "city_id": cityId?.toJson(),
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
        "password": password,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class CityId {
  String? id;
  String? name;

  CityId({
    this.id,
    this.name,
  });

  factory CityId.fromJson(Map<String, dynamic> json) => CityId(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class CountryId {
  String? id;
  String? name;

  CountryId({
    this.id,
    this.name,
  });

  factory CountryId.fromJson(Map<String, dynamic> json) => CountryId(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}
