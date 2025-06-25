// To parse this JSON data, do
//
//     final homeScreenResponse = homeScreenResponseFromJson(jsonString);

import 'dart:convert';

HomeScreenResponse homeScreenResponseFromJson(String str) =>
    HomeScreenResponse.fromJson(json.decode(str));

String homeScreenResponseToJson(HomeScreenResponse data) =>
    json.encode(data.toJson());

class HomeScreenResponse {
  bool? success;
  String? message;
  HomeScreenDatum? data;

  HomeScreenResponse({
    this.success,
    this.message,
    this.data,
  });

  factory HomeScreenResponse.fromJson(Map<String, dynamic> json) =>
      HomeScreenResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : HomeScreenDatum.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class HomeScreenDatum {
  List<Appointemnt>? pastAppointment;
  Blog? blog;
  UserDetail? userDetail;
  List<Appointemnt>? appointemnt;
  dynamic notificationCount;

  HomeScreenDatum({
    this.pastAppointment,
    this.blog,
    this.userDetail,
    this.appointemnt,
    this.notificationCount,
  });

  factory HomeScreenDatum.fromJson(Map<String, dynamic> json) =>
      HomeScreenDatum(
        pastAppointment: json["pastAppointment"] == null
            ? []
            : List<Appointemnt>.from(
                json["pastAppointment"]!.map((x) => Appointemnt.fromJson(x))),
        blog: json["blog"] == null ? null : Blog.fromJson(json["blog"]),
        userDetail: json["userDetail"] == null
            ? null
            : UserDetail.fromJson(json["userDetail"]),
        appointemnt: json["appointemnt"] == null
            ? []
            : List<Appointemnt>.from(
                json["appointemnt"]!.map((x) => Appointemnt.fromJson(x))),
        notificationCount: json["notificationCount"],
      );

  Map<String, dynamic> toJson() => {
        "pastAppointment": pastAppointment == null
            ? []
            : List<dynamic>.from(pastAppointment!.map((x) => x.toJson())),
        "blog": blog?.toJson(),
        "userDetail": userDetail?.toJson(),
        "appointemnt": appointemnt == null
            ? []
            : List<dynamic>.from(appointemnt!.map((x) => x.toJson())),
        "notificationCount": notificationCount,
      };
}

class Appointemnt {
  dynamic uid;
  dynamic patientId;
  DoctorId? doctorId;
  // CategoryId? categoryId;
  dynamic preExistDiseasesId;
  dynamic subCategoryId;
  dynamic status;
  dynamic description;
  dynamic date;
  dynamic slot;
  dynamic slotDuration;
  dynamic isDelete;
  dynamic startDate;
  dynamic appointmentType;
  dynamic id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  Appointemnt({
    this.uid,
    this.patientId,
    this.doctorId,
    // this.categoryId,
    this.preExistDiseasesId,
    this.subCategoryId,
    this.status,
    this.description,
    this.date,
    this.slot,
    this.slotDuration,
    this.isDelete,
    this.startDate,
    this.appointmentType,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Appointemnt.fromJson(Map<String, dynamic> json) => Appointemnt(
        uid: json["uid"],
        patientId: json["patient_id"],
        doctorId: json["doctor_id"] == null
            ? null
            : DoctorId.fromJson(json["doctor_id"]),
        // categoryId: json["category_id"] == null
        //     ? null
        //     : CategoryId.fromJson(json["category_id"]),
        preExistDiseasesId: json["preExistDiseases_id"],
        subCategoryId: json["sub_category_id"],
        status: json["status"],
        description: json["description"],
        date: json["date"],
        slot: json["slot"],
        slotDuration: json["slot_duration"],
        isDelete: json["is_delete"],
        startDate: json["start_date"],
        appointmentType: json["appointment_type"],
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
        "patient_id": patientId,
        "doctor_id": doctorId?.toJson(),
        // "category_id": categoryId?.toJson(),
        "preExistDiseases_id": preExistDiseasesId,
        "sub_category_id": subCategoryId,
        "status": status,
        "description": description,
        "date": date,
        "slot": slot,
        "slot_duration": slotDuration,
        "is_delete": isDelete,
        "start_date": startDate,
        "appointment_type": appointmentType,
        "_id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class CategoryId {
  dynamic name;
  dynamic image;
  dynamic isDelete;
  dynamic isActive;
  dynamic id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  CategoryId({
    this.name,
    this.image,
    this.isDelete,
    this.isActive,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
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

class DoctorId {
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
  List<String>? categoryId;
  List<String>? subCategoryId;
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
  dynamic totalExperience;
  dynamic id;
  dynamic password;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;
  List<dynamic>? categoryIds;

  DoctorId({
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
    this.profession,
    this.totalExperience,
    this.id,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.categoryIds,
  });

  factory DoctorId.fromJson(Map<String, dynamic> json) => DoctorId(
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
        categoryId: json["category_id"] == null
            ? []
            : List<String>.from(json["category_id"]!.map((x) => x)),
        subCategoryId: json["sub_category_id"] == null
            ? []
            : List<String>.from(json["sub_category_id"]!.map((x) => x)),
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
        totalExperience: json["total_experience"],
        id: json["_id"],
        password: json["password"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
        categoryIds: json["category_ids"] == null
            ? []
            : List<dynamic>.from(json["category_ids"]!.map((x) => x)),
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
        "category_id": categoryId == null
            ? []
            : List<dynamic>.from(categoryId!.map((x) => x)),
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
        "profession": profession,
        "total_experience": totalExperience,
        "_id": id,
        "password": password,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "category_ids": categoryIds == null
            ? []
            : List<dynamic>.from(categoryIds!.map((x) => x)),
      };
}

class Blog {
  dynamic title;
  dynamic description;
  dynamic image;
  dynamic date;
  dynamic isDelete;
  dynamic isActive;
  dynamic id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;
  dynamic blogUrl;

  Blog({
    this.title,
    this.description,
    this.image,
    this.date,
    this.isDelete,
    this.isActive,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.blogUrl,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        title: json["title"],
        description: json["description"],
        image: json["image"],
        date: json["date"],
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
        blogUrl: json["blog_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "image": image,
        "date": date,
        "is_delete": isDelete,
        "is_active": isActive,
        "_id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "blog_url": blogUrl,
      };
}

class UserDetail {
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
  dynamic addedBy;
  dynamic type;
  dynamic deviceToken;
  dynamic deviceType;
  dynamic socialId;
  dynamic loginType;
  dynamic profession;
  dynamic startDate;
  dynamic id;
  dynamic password;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  UserDetail({
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
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
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
        "added_by": addedBy,
        "type": type,
        "device_token": deviceToken,
        "device_type": deviceType,
        "social_id": socialId,
        "login_type": loginType,
        "profession": profession,
        "start_date": startDate,
        "_id": id,
        "password": password,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
