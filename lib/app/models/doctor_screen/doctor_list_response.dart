// To parse this JSON data, do
//
//     final doctoreListResponse = doctoreListResponseFromJson(jsonString);

import 'dart:convert';

DoctorListResponse doctoreListResponseFromJson(String str) =>
    DoctorListResponse.fromJson(json.decode(str));

String doctoreListResponseToJson(DoctorListResponse data) =>
    json.encode(data.toJson());

class DoctorListResponse {
  bool? success;
  String? message;
  Data? data;

  DoctorListResponse({
    this.success,
    this.message,
    this.data,
  });

  factory DoctorListResponse.fromJson(Map<String, dynamic> json) =>
      DoctorListResponse(
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
  List<DoctorDatum>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  int? nextPage;

  Data({
    this.docs,
    this.totalDocs,
    this.limit,
    this.page,
    this.totalPages,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        docs: json["docs"] == null
            ? []
            : List<DoctorDatum>.from(
                json["docs"]!.map((x) => DoctorDatum.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        page: json["page"],
        totalPages: json["totalPages"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "docs": docs == null
            ? []
            : List<dynamic>.from(docs!.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "page": page,
        "totalPages": totalPages,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class DoctorDatum {
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
  dynamic isVerify;
  dynamic addedBy;
  dynamic deviceToken;
  dynamic deviceType;
  dynamic socialId;
  dynamic loginType;
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
  dynamic profession;
  dynamic password;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  DoctorDatum({
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
    this.isVerify,
    this.addedBy,
    this.deviceToken,
    this.deviceType,
    this.socialId,
    this.loginType,
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
    this.profession,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DoctorDatum.fromJson(Map<String, dynamic> json) => DoctorDatum(
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
        isVerify: json["is_verify"],
        addedBy: json["added_by"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        socialId: json["social_id"],
        loginType: json["login_type"],
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
        profession: json["profession"],
        password: json["password"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "country_id": countryId?.toJson(),
        "city_id": cityId?.toJson(),
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
        "sub_category_id": subCategoryId == null
            ? []
            : List<dynamic>.from(subCategoryId!.map((x) => x)),
        "school_attended": schoolAttended,
        "degree_obtained": degreeObtained,
        "graduation_year": graduationYear,
        "additional_certification": additionalCertification,
        "license_number": licenseNumber,
        "license": license,
        "issue_date":
            "${issueDate!.year.toString().padLeft(4, '0')}-${issueDate!.month.toString().padLeft(2, '0')}-${issueDate!.day.toString().padLeft(2, '0')}",
        "expiry_date":
            "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}",
        "specialist": specialist,
        "current_employer": currentEmployer,
        "previous_employer": previousEmployer,
        "area_expertise_date":
            "${areaExpertiseDate!.year.toString().padLeft(4, '0')}-${areaExpertiseDate!.month.toString().padLeft(2, '0')}-${areaExpertiseDate!.day.toString().padLeft(2, '0')}",
        "profession": profession,
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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
