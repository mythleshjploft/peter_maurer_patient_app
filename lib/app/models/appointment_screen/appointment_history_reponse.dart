// To parse this JSON data, do
//
//     final appointmentHistoryResponse = appointmentHistoryResponseFromJson(jsonString);

import 'dart:convert';

AppointmentHistoryResponse appointmentHistoryResponseFromJson(String str) =>
    AppointmentHistoryResponse.fromJson(json.decode(str));

String appointmentHistoryResponseToJson(AppointmentHistoryResponse data) =>
    json.encode(data.toJson());

class AppointmentHistoryResponse {
  bool? success;
  String? statusText;
  String? message;
  Data? data;

  AppointmentHistoryResponse({
    this.success,
    this.statusText,
    this.message,
    this.data,
  });

  factory AppointmentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      AppointmentHistoryResponse(
        success: json["success"],
        statusText: json["statusText"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusText": statusText,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<AppointmentData>? docs;
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
            : List<AppointmentData>.from(
                json["docs"]!.map((x) => AppointmentData.fromJson(x))),
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

class AppointmentData {
  dynamic id;
  dynamic uid;
  dynamic patientId;
  DoctorId? doctorId;
  // CategoryId? categoryId;
  dynamic preExistDiseasesId;
  dynamic subCategoryId;
  dynamic status;
  dynamic description;
  dynamic date;
  dynamic slotDuration;
  dynamic isDelete;
  dynamic startDate;
  dynamic appointmentType;
  dynamic condition;
  PurpleSlot? slot;
  List<SlotElement>? slots;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  AppointmentData({
    this.id,
    this.uid,
    this.patientId,
    this.doctorId,
    // this.categoryId,
    this.preExistDiseasesId,
    this.subCategoryId,
    this.status,
    this.description,
    this.date,
    this.slotDuration,
    this.isDelete,
    this.startDate,
    this.appointmentType,
    this.condition,
    this.slot,
    this.slots,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) =>
      AppointmentData(
        id: json["_id"],
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
        slotDuration: json["slot_duration"],
        isDelete: json["is_delete"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        appointmentType: json["appointment_type"],
        condition: json["condition"],
        slot: json["slot"] == null ? null : PurpleSlot.fromJson(json["slot"]),
        slots: json["slots"] == null
            ? []
            : List<SlotElement>.from(
                json["slots"]!.map((x) => SlotElement.fromJson(x))),
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
        "patient_id": patientId,
        "doctor_id": doctorId?.toJson(),
        // "category_id": categoryId?.toJson(),
        "preExistDiseases_id": preExistDiseasesId,
        "sub_category_id": subCategoryId,
        "status": status,
        "description": description,
        "date": date,
        "slot_duration": slotDuration,
        "is_delete": isDelete,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "appointment_type": appointmentType,
        "condition": condition,
        "slot": slot?.toJson(),
        "slots": slots == null
            ? []
            : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

// class CategoryId {
//   String? id;
//   String? name;
//   dynamic image;
//   bool? isDelete;
//   bool? isActive;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//   String? categoryId;
//   String? slotDuration;

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

class DoctorId {
  String? id;
  String? uid;
  String? firstName;
  String? lastName;
  String? gender;
  String? countryCode;
  String? mobileNumber;
  String? dob;
  CountryId? countryId;
  CityId? cityId;
  String? zipCode;
  dynamic otp;
  String? language;
  bool? isActive;
  bool? isDelete;
  bool? isOtpVerify;
  bool? isVerify;
  dynamic addedBy;
  String? deviceToken;
  String? deviceType;
  dynamic socialId;
  dynamic loginType;
  // CategoryId? categoryId;
  // List<CategoryId>? subCategoryId;
  String? schoolAttended;
  String? degreeObtained;
  String? graduationYear;
  String? additionalCertification;
  String? licenseNumber;
  String? license;
  String? issueDate;
  String? expiryDate;
  String? specialist;
  String? currentEmployer;
  String? previousEmployer;
  String? areaExpertiseDate;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? image;
  List<dynamic>? categoryIds;
  String? email;
  String? totalExperience;
  String? type;

  DoctorId({
    this.id,
    this.uid,
    this.firstName,
    this.lastName,
    this.gender,
    this.countryCode,
    this.mobileNumber,
    this.dob,
    this.countryId,
    this.cityId,
    this.zipCode,
    this.otp,
    this.language,
    this.isActive,
    this.isDelete,
    this.isOtpVerify,
    this.isVerify,
    this.addedBy,
    this.deviceToken,
    this.deviceType,
    this.socialId,
    this.loginType,
    // this.categoryId,
    // this.subCategoryId,
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
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.image,
    this.categoryIds,
    this.email,
    this.totalExperience,
    this.type,
  });

  factory DoctorId.fromJson(Map<String, dynamic> json) => DoctorId(
        id: json["_id"],
        uid: json["uid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        countryCode: json["country_code"],
        mobileNumber: json["mobile_number"],
        dob: json["dob"],
        countryId: json["country_id"] == null
            ? null
            : CountryId.fromJson(json["country_id"]),
        cityId:
            json["city_id"] == null ? null : CityId.fromJson(json["city_id"]),
        zipCode: json["zip_code"],
        otp: json["otp"],
        language: json["language"],
        isActive: json["is_active"],
        isDelete: json["is_delete"],
        isOtpVerify: json["is_otp_verify"],
        isVerify: json["is_verify"],
        addedBy: json["added_by"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        socialId: json["social_id"],
        loginType: json["login_type"],
        // categoryId: json["category_id"] == null
        //     ? null
        //     : CategoryId.fromJson(json["category_id"]),
        // subCategoryId: json["sub_category_id"] == null
        //     ? []
        //     : List<CategoryId>.from(
        //         json["sub_category_id"]!.map((x) => CategoryId.fromJson(x))),
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
        password: json["password"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
        image: json["image"],
        categoryIds: json["category_ids"] == null
            ? []
            : List<dynamic>.from(json["category_ids"]!.map((x) => x)),
        email: json["email"],
        totalExperience: json["total_experience"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "country_code": countryCode,
        "mobile_number": mobileNumber,
        "dob": dob,
        "country_id": countryId?.toJson(),
        "city_id": cityId?.toJson(),
        "zip_code": zipCode,
        "otp": otp,
        "language": language,
        "is_active": isActive,
        "is_delete": isDelete,
        "is_otp_verify": isOtpVerify,
        "is_verify": isVerify,
        "added_by": addedBy,
        "device_token": deviceToken,
        "device_type": deviceType,
        "social_id": socialId,
        "login_type": loginType,
        // "category_id": categoryId?.toJson(),
        // "sub_category_id": subCategoryId == null
        //     ? []
        //     : List<dynamic>.from(subCategoryId!.map((x) => x.toJson())),
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
        "password": password,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "image": image,
        "category_ids": categoryIds == null
            ? []
            : List<dynamic>.from(categoryIds!.map((x) => x)),
        "email": email,
        "total_experience": totalExperience,
        "type": type,
      };
}

class CityId {
  String? id;
  int? cityIdId;
  String? name;
  int? stateId;
  String? stateCode;
  String? stateName;
  int? countryId;
  String? countryCode;
  String? countryName;
  String? latitude;
  String? longitude;
  String? wikiDataId;
  String? country;
  String? state;
  DateTime? updatedAt;
  bool? isDelete;

  CityId({
    this.id,
    this.cityIdId,
    this.name,
    this.stateId,
    this.stateCode,
    this.stateName,
    this.countryId,
    this.countryCode,
    this.countryName,
    this.latitude,
    this.longitude,
    this.wikiDataId,
    this.country,
    this.state,
    this.updatedAt,
    this.isDelete,
  });

  factory CityId.fromJson(Map<String, dynamic> json) => CityId(
        id: json["_id"],
        cityIdId: json["id"],
        name: json["name"],
        stateId: json["state_id"],
        stateCode: json["state_code"],
        stateName: json["state_name"],
        countryId: json["country_id"],
        countryCode: json["country_code"],
        countryName: json["country_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        wikiDataId: json["wikiDataId"],
        country: json["country"],
        state: json["state"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": cityIdId,
        "name": name,
        "state_id": stateId,
        "state_code": stateCode,
        "state_name": stateName,
        "country_id": countryId,
        "country_code": countryCode,
        "country_name": countryName,
        "latitude": latitude,
        "longitude": longitude,
        "wikiDataId": wikiDataId,
        "country": country,
        "state": state,
        "updated_at": updatedAt?.toIso8601String(),
        "is_delete": isDelete,
      };
}

class CountryId {
  String? id;
  int? countryIdId;
  String? name;
  String? iso3;
  String? iso2;
  String? numericCode;
  String? phoneCode;
  String? capital;
  String? currency;
  String? currencyName;
  String? currencySymbol;
  String? tld;
  String? native;
  String? region;
  String? subregion;
  List<Timezone>? timezones;
  Translations? translations;
  String? latitude;
  String? longitude;
  String? emoji;
  String? emojiU;

  CountryId({
    this.id,
    this.countryIdId,
    this.name,
    this.iso3,
    this.iso2,
    this.numericCode,
    this.phoneCode,
    this.capital,
    this.currency,
    this.currencyName,
    this.currencySymbol,
    this.tld,
    this.native,
    this.region,
    this.subregion,
    this.timezones,
    this.translations,
    this.latitude,
    this.longitude,
    this.emoji,
    this.emojiU,
  });

  factory CountryId.fromJson(Map<String, dynamic> json) => CountryId(
        id: json["_id"],
        countryIdId: json["id"],
        name: json["name"],
        iso3: json["iso3"],
        iso2: json["iso2"],
        numericCode: json["numeric_code"],
        phoneCode: json["phone_code"],
        capital: json["capital"],
        currency: json["currency"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
        tld: json["tld"],
        native: json["native"],
        region: json["region"],
        subregion: json["subregion"],
        timezones: json["timezones"] == null
            ? []
            : List<Timezone>.from(
                json["timezones"]!.map((x) => Timezone.fromJson(x))),
        translations: json["translations"] == null
            ? null
            : Translations.fromJson(json["translations"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
        emoji: json["emoji"],
        emojiU: json["emojiU"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": countryIdId,
        "name": name,
        "iso3": iso3,
        "iso2": iso2,
        "numeric_code": numericCode,
        "phone_code": phoneCode,
        "capital": capital,
        "currency": currency,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
        "tld": tld,
        "native": native,
        "region": region,
        "subregion": subregion,
        "timezones": timezones == null
            ? []
            : List<dynamic>.from(timezones!.map((x) => x.toJson())),
        "translations": translations?.toJson(),
        "latitude": latitude,
        "longitude": longitude,
        "emoji": emoji,
        "emojiU": emojiU,
      };
}

class Timezone {
  String? zoneName;
  int? gmtOffset;
  String? gmtOffsetName;
  String? abbreviation;
  String? tzName;

  Timezone({
    this.zoneName,
    this.gmtOffset,
    this.gmtOffsetName,
    this.abbreviation,
    this.tzName,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
        zoneName: json["zoneName"],
        gmtOffset: json["gmtOffset"],
        gmtOffsetName: json["gmtOffsetName"],
        abbreviation: json["abbreviation"],
        tzName: json["tzName"],
      );

  Map<String, dynamic> toJson() => {
        "zoneName": zoneName,
        "gmtOffset": gmtOffset,
        "gmtOffsetName": gmtOffsetName,
        "abbreviation": abbreviation,
        "tzName": tzName,
      };
}

class Translations {
  String? kr;
  String? ptBr;
  String? pt;
  String? nl;
  String? hr;
  String? fa;
  String? de;
  String? es;
  String? fr;
  String? ja;
  String? it;
  String? cn;
  String? tr;

  Translations({
    this.kr,
    this.ptBr,
    this.pt,
    this.nl,
    this.hr,
    this.fa,
    this.de,
    this.es,
    this.fr,
    this.ja,
    this.it,
    this.cn,
    this.tr,
  });

  factory Translations.fromJson(Map<String, dynamic> json) => Translations(
        kr: json["kr"],
        ptBr: json["pt-BR"],
        pt: json["pt"],
        nl: json["nl"],
        hr: json["hr"],
        fa: json["fa"],
        de: json["de"],
        es: json["es"],
        fr: json["fr"],
        ja: json["ja"],
        it: json["it"],
        cn: json["cn"],
        tr: json["tr"],
      );

  Map<String, dynamic> toJson() => {
        "kr": kr,
        "pt-BR": ptBr,
        "pt": pt,
        "nl": nl,
        "hr": hr,
        "fa": fa,
        "de": de,
        "es": es,
        "fr": fr,
        "ja": ja,
        "it": it,
        "cn": cn,
        "tr": tr,
      };
}

class PurpleSlot {
  String? startTime;
  String? endTime;

  PurpleSlot({
    this.startTime,
    this.endTime,
  });

  factory PurpleSlot.fromJson(Map<String, dynamic> json) => PurpleSlot(
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime,
        "end_time": endTime,
      };
}

class SlotElement {
  String? id;
  String? startTime;
  String? endTime;

  SlotElement({
    this.id,
    this.startTime,
    this.endTime,
  });

  factory SlotElement.fromJson(Map<String, dynamic> json) => SlotElement(
        id: json["_id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "start_time": startTime,
        "end_time": endTime,
      };
}
