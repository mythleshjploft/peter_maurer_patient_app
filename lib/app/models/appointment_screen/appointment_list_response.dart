// // To parse this JSON data, do
// //
// //     final appointmentListResponse = appointmentListResponseFromJson(jsonString);

// import 'dart:convert';

// AppointmentListResponse appointmentListResponseFromJson(String str) =>
//     AppointmentListResponse.fromJson(json.decode(str));

// String appointmentListResponseToJson(AppointmentListResponse data) =>
//     json.encode(data.toJson());

// class AppointmentListResponse {
//   bool? success;
//   String? statusText;
//   String? message;
//   Data? data;

//   AppointmentListResponse({
//     this.success,
//     this.statusText,
//     this.message,
//     this.data,
//   });

//   factory AppointmentListResponse.fromJson(Map<String, dynamic> json) =>
//       AppointmentListResponse(
//         success: json["success"],
//         statusText: json["statusText"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "statusText": statusText,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   List<AppointmentDatum>? docs;
//   int? totalDocs;
//   int? limit;
//   int? page;
//   int? totalPages;
//   int? pagingCounter;
//   bool? hasPrevPage;
//   bool? hasNextPage;
//   dynamic prevPage;
//   int? nextPage;

//   Data({
//     this.docs,
//     this.totalDocs,
//     this.limit,
//     this.page,
//     this.totalPages,
//     this.pagingCounter,
//     this.hasPrevPage,
//     this.hasNextPage,
//     this.prevPage,
//     this.nextPage,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         docs: json["docs"] == null
//             ? []
//             : List<AppointmentDatum>.from(
//                 json["docs"]!.map((x) => AppointmentDatum.fromJson(x))),
//         totalDocs: json["totalDocs"],
//         limit: json["limit"],
//         page: json["page"],
//         totalPages: json["totalPages"],
//         pagingCounter: json["pagingCounter"],
//         hasPrevPage: json["hasPrevPage"],
//         hasNextPage: json["hasNextPage"],
//         prevPage: json["prevPage"],
//         nextPage: json["nextPage"],
//       );

//   Map<String, dynamic> toJson() => {
//         "docs": docs == null
//             ? []
//             : List<dynamic>.from(docs!.map((x) => x.toJson())),
//         "totalDocs": totalDocs,
//         "limit": limit,
//         "page": page,
//         "totalPages": totalPages,
//         "pagingCounter": pagingCounter,
//         "hasPrevPage": hasPrevPage,
//         "hasNextPage": hasNextPage,
//         "prevPage": prevPage,
//         "nextPage": nextPage,
//       };
// }

// class AppointmentDatum {
//   dynamic id;
//   dynamic uid;
//   dynamic patientId;
//   DoctorId? doctorId;
//   CategoryId? categoryId;
//   dynamic preExistDiseasesId;
//   dynamic subCategoryId;
//   dynamic status;
//   dynamic description;
//   dynamic date;
//   dynamic slot;
//   dynamic slotDuration;
//   dynamic isDelete;
//   dynamic startDate;
//   dynamic appointmentType;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic v;

//   AppointmentDatum({
//     this.id,
//     this.uid,
//     this.patientId,
//     this.doctorId,
//     this.categoryId,
//     this.preExistDiseasesId,
//     this.subCategoryId,
//     this.status,
//     this.description,
//     this.date,
//     this.slot,
//     this.slotDuration,
//     this.isDelete,
//     this.startDate,
//     this.appointmentType,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory AppointmentDatum.fromJson(Map<String, dynamic> json) =>
//       AppointmentDatum(
//         id: json["_id"],
//         uid: json["uid"],
//         patientId: json["patient_id"],
//         doctorId: json["doctor_id"] == null
//             ? null
//             : DoctorId.fromJson(json["doctor_id"]),
//         categoryId: json["category_id"] == null
//             ? null
//             : CategoryId.fromJson(json["category_id"]),
//         preExistDiseasesId: json["preExistDiseases_id"],
//         subCategoryId: json["sub_category_id"],
//         status: json["status"],
//         description: json["description"],
//         date: json["date"],
//         slot: json["slot"],
//         slotDuration: json["slot_duration"],
//         isDelete: json["is_delete"],
//         startDate: json["start_date"],
//         appointmentType: json["appointment_type"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "uid": uid,
//         "patient_id": patientId,
//         "doctor_id": doctorId?.toJson(),
//         "category_id": categoryId?.toJson(),
//         "preExistDiseases_id": preExistDiseasesId,
//         "sub_category_id": subCategoryId,
//         "status": status,
//         "description": description,
//         "date": date,
//         "slot": slot,
//         "slot_duration": slotDuration,
//         "is_delete": isDelete,
//         "start_date": startDate,
//         "appointment_type": appointmentType,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class CategoryId {
//   dynamic id;
//   dynamic name;
//   dynamic image;
//   dynamic isDelete;
//   dynamic isActive;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic v;
//   dynamic categoryId;
//   dynamic slotDuration;

//   CategoryId({
//     this.id,
//     this.name,
//     this.image,
//     this.isDelete,
//     this.isActive,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.categoryId,
//     this.slotDuration,
//   });

//   factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
//         id: json["_id"],
//         name: json["name"],
//         image: json["image"],
//         isDelete: json["is_delete"],
//         isActive: json["is_active"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         v: json["__v"],
//         categoryId: json["category_id"],
//         slotDuration: json["slot_duration"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "image": image,
//         "is_delete": isDelete,
//         "is_active": isActive,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "__v": v,
//         "category_id": categoryId,
//         "slot_duration": slotDuration,
//       };
// }

// class DoctorId {
//   dynamic id;
//   dynamic uid;
//   dynamic firstName;
//   dynamic lastName;
//   dynamic gender;
//   dynamic countryCode;
//   dynamic mobileNumber;
//   dynamic dob;
//   CountryId? countryId;
//   CityId? cityId;
//   dynamic zipCode;
//   dynamic otp;
//   dynamic language;
//   dynamic isActive;
//   dynamic isDelete;
//   dynamic isOtpVerify;
//   dynamic isVerify;
//   dynamic addedBy;
//   dynamic deviceToken;
//   dynamic deviceType;
//   dynamic socialId;
//   dynamic loginType;
//   CategoryId? categoryId;
//   List<CategoryId>? subCategoryId;
//   dynamic schoolAttended;
//   dynamic degreeObtained;
//   dynamic graduationYear;
//   dynamic additionalCertification;
//   dynamic licenseNumber;
//   dynamic license;
//   dynamic issueDate;
//   dynamic expiryDate;
//   dynamic specialist;
//   dynamic currentEmployer;
//   dynamic previousEmployer;
//   dynamic areaExpertiseDate;
//   dynamic password;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic v;
//   dynamic image;
//   List<dynamic>? categoryIds;
//   dynamic email;
//   dynamic totalExperience;
//   dynamic profession;

//   DoctorId({
//     this.id,
//     this.uid,
//     this.firstName,
//     this.lastName,
//     this.gender,
//     this.countryCode,
//     this.mobileNumber,
//     this.dob,
//     this.countryId,
//     this.cityId,
//     this.zipCode,
//     this.otp,
//     this.language,
//     this.isActive,
//     this.isDelete,
//     this.isOtpVerify,
//     this.isVerify,
//     this.addedBy,
//     this.deviceToken,
//     this.deviceType,
//     this.socialId,
//     this.loginType,
//     this.categoryId,
//     this.subCategoryId,
//     this.schoolAttended,
//     this.degreeObtained,
//     this.graduationYear,
//     this.additionalCertification,
//     this.licenseNumber,
//     this.license,
//     this.issueDate,
//     this.expiryDate,
//     this.specialist,
//     this.currentEmployer,
//     this.previousEmployer,
//     this.areaExpertiseDate,
//     this.password,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.image,
//     this.categoryIds,
//     this.email,
//     this.totalExperience,
//     this.profession,
//   });

//   factory DoctorId.fromJson(Map<String, dynamic> json) => DoctorId(
//         id: json["_id"],
//         uid: json["uid"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         gender: json["gender"],
//         countryCode: json["country_code"],
//         mobileNumber: json["mobile_number"],
//         dob: json["dob"],
//         countryId: json["country_id"] == null
//             ? null
//             : CountryId.fromJson(json["country_id"]),
//         cityId:
//             json["city_id"] == null ? null : CityId.fromJson(json["city_id"]),
//         zipCode: json["zip_code"],
//         otp: json["otp"],
//         language: json["language"],
//         isActive: json["is_active"],
//         isDelete: json["is_delete"],
//         isOtpVerify: json["is_otp_verify"],
//         isVerify: json["is_verify"],
//         addedBy: json["added_by"],
//         deviceToken: json["device_token"],
//         deviceType: json["device_type"],
//         socialId: json["social_id"],
//         loginType: json["login_type"],
//         categoryId: json["category_id"] == null
//             ? null
//             : CategoryId.fromJson(json["category_id"]),
//         subCategoryId: json["sub_category_id"] == null
//             ? []
//             : List<CategoryId>.from(
//                 json["sub_category_id"]!.map((x) => CategoryId.fromJson(x))),
//         schoolAttended: json["school_attended"],
//         degreeObtained: json["degree_obtained"],
//         graduationYear: json["graduation_year"],
//         additionalCertification: json["additional_certification"],
//         licenseNumber: json["license_number"],
//         license: json["license"],
//         issueDate: json["issue_date"],
//         expiryDate: json["expiry_date"],
//         specialist: json["specialist"],
//         currentEmployer: json["current_employer"],
//         previousEmployer: json["previous_employer"],
//         areaExpertiseDate: json["area_expertise_date"],
//         password: json["password"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         v: json["__v"],
//         image: json["image"],
//         categoryIds: json["category_ids"] == null
//             ? []
//             : List<dynamic>.from(json["category_ids"]!.map((x) => x)),
//         email: json["email"],
//         totalExperience: json["total_experience"],
//         profession: json["profession"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "uid": uid,
//         "first_name": firstName,
//         "last_name": lastName,
//         "gender": gender,
//         "country_code": countryCode,
//         "mobile_number": mobileNumber,
//         "dob": dob,
//         "country_id": countryId?.toJson(),
//         "city_id": cityId?.toJson(),
//         "zip_code": zipCode,
//         "otp": otp,
//         "language": language,
//         "is_active": isActive,
//         "is_delete": isDelete,
//         "is_otp_verify": isOtpVerify,
//         "is_verify": isVerify,
//         "added_by": addedBy,
//         "device_token": deviceToken,
//         "device_type": deviceType,
//         "social_id": socialId,
//         "login_type": loginType,
//         "category_id": categoryId?.toJson(),
//         "sub_category_id": subCategoryId == null
//             ? []
//             : List<dynamic>.from(subCategoryId!.map((x) => x.toJson())),
//         "school_attended": schoolAttended,
//         "degree_obtained": degreeObtained,
//         "graduation_year": graduationYear,
//         "additional_certification": additionalCertification,
//         "license_number": licenseNumber,
//         "license": license,
//         "issue_date": issueDate,
//         "expiry_date": expiryDate,
//         "specialist": specialist,
//         "current_employer": currentEmployer,
//         "previous_employer": previousEmployer,
//         "area_expertise_date": areaExpertiseDate,
//         "password": password,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "__v": v,
//         "image": image,
//         "category_ids": categoryIds == null
//             ? []
//             : List<dynamic>.from(categoryIds!.map((x) => x)),
//         "email": email,
//         "total_experience": totalExperience,
//         "profession": profession,
//       };
// }

// class CityId {
//   String? id;
//   String? name;

//   CityId({
//     this.id,
//     this.name,
//   });

//   factory CityId.fromJson(Map<String, dynamic> json) => CityId(
//         id: json["_id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//       };
// }

// class CountryId {
//   String? id;
//   String? name;

//   CountryId({
//     this.id,
//     this.name,
//   });

//   factory CountryId.fromJson(Map<String, dynamic> json) => CountryId(
//         id: json["_id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//       };
// }
