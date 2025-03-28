// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  bool? success;
  String? message;
  Data? data;
  int? exeTime;

  SignUpResponse({
    this.success,
    this.message,
    this.data,
    this.exeTime,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        exeTime: json["exeTime"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "exeTime": exeTime,
      };
}

class Data {
  User? user;
  String? token;

  Data({
    this.user,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  dynamic uid;
  dynamic firstName;
  dynamic lastName;
  dynamic gender;
  dynamic countryCode;
  dynamic mobileNumber;
  dynamic email;
  dynamic dob;
  dynamic countryId;
  dynamic cityId;
  dynamic zipCode;
  dynamic otp;
  dynamic language;
  dynamic image;
  dynamic isActive;
  dynamic isDelete;
  dynamic isOtpVerify;
  dynamic isVerify;
  dynamic addedBy;
  dynamic deviceToken;
  dynamic deviceType;
  dynamic socialId;
  dynamic loginType;
  dynamic categoryId;
  List<dynamic>? subCategoryId;
  dynamic schoolAttended;
  dynamic degreeObtained;
  dynamic graduationYear;
  dynamic additionalCertification;
  dynamic licenseNumber;
  dynamic license;
  dynamic issueDate;
  dynamic expiryDate;
  dynamic specialist;
  dynamic currentEmployer;
  dynamic previousEmployer;
  dynamic areaExpertiseDate;
  dynamic id;
  dynamic password;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  User({
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
    this.isVerify,
    this.addedBy,
    this.deviceToken,
    this.deviceType,
    this.socialId,
    this.loginType,
    this.categoryId,
    this.subCategoryId,
    this.schoolAttended,
    this.degreeObtained,
    this.graduationYear,
    this.additionalCertification,
    this.licenseNumber,
    this.license,
    this.issueDate,
    this.expiryDate,
    this.specialist,
    this.currentEmployer,
    this.previousEmployer,
    this.areaExpertiseDate,
    this.id,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        isVerify: json["is_verify"],
        addedBy: json["added_by"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        socialId: json["social_id"],
        loginType: json["login_type"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"] == null
            ? []
            : List<dynamic>.from(json["sub_category_id"]!.map((x) => x)),
        schoolAttended: json["school_attended"],
        degreeObtained: json["degree_obtained"],
        graduationYear: json["graduation_year"],
        additionalCertification: json["additional_certification"],
        licenseNumber: json["license_number"],
        license: json["license"],
        issueDate: json["issue_date"],
        expiryDate: json["expiry_date"],
        specialist: json["specialist"],
        currentEmployer: json["current_employer"],
        previousEmployer: json["previous_employer"],
        areaExpertiseDate: json["area_expertise_date"],
        id: json["_id"],
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
        "is_verify": isVerify,
        "added_by": addedBy,
        "device_token": deviceToken,
        "device_type": deviceType,
        "social_id": socialId,
        "login_type": loginType,
        "category_id": categoryId,
        "sub_category_id": subCategoryId == null
            ? []
            : List<dynamic>.from(subCategoryId!.map((x) => x)),
        "school_attended": schoolAttended,
        "degree_obtained": degreeObtained,
        "graduation_year": graduationYear,
        "additional_certification": additionalCertification,
        "license_number": licenseNumber,
        "license": license,
        "issue_date": issueDate,
        "expiry_date": expiryDate,
        "specialist": specialist,
        "current_employer": currentEmployer,
        "previous_employer": previousEmployer,
        "area_expertise_date": areaExpertiseDate,
        "_id": id,
        "password": password,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
