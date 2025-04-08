// To parse this JSON data, do
//
//     final conditionListResponse = conditionListResponseFromJson(jsonString);

import 'dart:convert';

DoctorDetailsResponse conditionListResponseFromJson(String str) =>
    DoctorDetailsResponse.fromJson(json.decode(str));

String conditionListResponseToJson(DoctorDetailsResponse data) =>
    json.encode(data.toJson());

class DoctorDetailsResponse {
  bool? success;
  String? message;
  DoctorDetails? doctors;
  DoctorsAvailability? doctorsAvailability;

  DoctorDetailsResponse({
    this.success,
    this.message,
    this.doctors,
    this.doctorsAvailability,
  });

  factory DoctorDetailsResponse.fromJson(Map<String, dynamic> json) =>
      DoctorDetailsResponse(
        success: json["success"],
        message: json["message"],
        doctors: json["doctors"] == null
            ? null
            : DoctorDetails.fromJson(json["doctors"]),
        doctorsAvailability: json["doctors_availability"] == null
            ? null
            : DoctorsAvailability.fromJson(json["doctors_availability"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "doctors": doctors?.toJson(),
        "doctors_availability": doctorsAvailability?.toJson(),
      };
}

class DoctorDetails {
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
  dynamic description;
  dynamic id;
  dynamic password;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;
  List<dynamic>? categoryIds;

  DoctorDetails({
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
    this.description,
    this.id,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.categoryIds,
  });

  factory DoctorDetails.fromJson(Map<String, dynamic> json) => DoctorDetails(
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
        description: json["description"],
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
        "description": description,
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

class CityId {
  String? name;
  dynamic arName;
  int? cityIdId;
  int? stateId;
  String? stateName;
  String? stateCode;
  int? countryId;
  String? countryCode;
  String? countryName;
  String? latitude;
  String? longitude;
  bool? isActive;
  bool? isDelete;
  String? id;
  String? wikiDataId;
  String? country;
  String? state;
  DateTime? updatedAt;

  CityId({
    this.name,
    this.arName,
    this.cityIdId,
    this.stateId,
    this.stateName,
    this.stateCode,
    this.countryId,
    this.countryCode,
    this.countryName,
    this.latitude,
    this.longitude,
    this.isActive,
    this.isDelete,
    this.id,
    this.wikiDataId,
    this.country,
    this.state,
    this.updatedAt,
  });

  factory CityId.fromJson(Map<String, dynamic> json) => CityId(
        name: json["name"],
        arName: json["ar_name"],
        cityIdId: json["id"],
        stateId: json["state_id"],
        stateName: json["state_name"],
        stateCode: json["state_code"],
        countryId: json["country_id"],
        countryCode: json["country_code"],
        countryName: json["country_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isActive: json["is_active"],
        isDelete: json["is_delete"],
        id: json["_id"],
        wikiDataId: json["wikiDataId"],
        country: json["country"],
        state: json["state"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "ar_name": arName,
        "id": cityIdId,
        "state_id": stateId,
        "state_name": stateName,
        "state_code": stateCode,
        "country_id": countryId,
        "country_code": countryCode,
        "country_name": countryName,
        "latitude": latitude,
        "longitude": longitude,
        "is_active": isActive,
        "is_delete": isDelete,
        "_id": id,
        "wikiDataId": wikiDataId,
        "country": country,
        "state": state,
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class CountryId {
  String? name;
  dynamic arName;
  String? region;
  String? subregion;
  String? native;
  String? tld;
  String? currencySymbol;
  String? currencyName;
  String? currency;
  String? capital;
  String? numericCode;
  String? iso2;
  String? iso3;
  String? emojiU;
  int? countryIdId;
  int? latitude;
  int? longitude;
  String? emoji;
  String? phoneCode;
  Translations? translations;
  List<Timezone>? timezones;
  int? value;
  bool? isActive;
  String? id;

  CountryId({
    this.name,
    this.arName,
    this.region,
    this.subregion,
    this.native,
    this.tld,
    this.currencySymbol,
    this.currencyName,
    this.currency,
    this.capital,
    this.numericCode,
    this.iso2,
    this.iso3,
    this.emojiU,
    this.countryIdId,
    this.latitude,
    this.longitude,
    this.emoji,
    this.phoneCode,
    this.translations,
    this.timezones,
    this.value,
    this.isActive,
    this.id,
  });

  factory CountryId.fromJson(Map<String, dynamic> json) => CountryId(
        name: json["name"],
        arName: json["ar_name"],
        region: json["region"],
        subregion: json["subregion"],
        native: json["native"],
        tld: json["tld"],
        currencySymbol: json["currency_symbol"],
        currencyName: json["currency_name"],
        currency: json["currency"],
        capital: json["capital"],
        numericCode: json["numeric_code"],
        iso2: json["iso2"],
        iso3: json["iso3"],
        emojiU: json["emojiU"],
        countryIdId: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        emoji: json["emoji"],
        phoneCode: json["phone_code"],
        translations: json["translations"] == null
            ? null
            : Translations.fromJson(json["translations"]),
        timezones: json["timezones"] == null
            ? []
            : List<Timezone>.from(
                json["timezones"]!.map((x) => Timezone.fromJson(x))),
        value: json["value"],
        isActive: json["is_active"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "ar_name": arName,
        "region": region,
        "subregion": subregion,
        "native": native,
        "tld": tld,
        "currency_symbol": currencySymbol,
        "currency_name": currencyName,
        "currency": currency,
        "capital": capital,
        "numeric_code": numericCode,
        "iso2": iso2,
        "iso3": iso3,
        "emojiU": emojiU,
        "id": countryIdId,
        "latitude": latitude,
        "longitude": longitude,
        "emoji": emoji,
        "phone_code": phoneCode,
        "translations": translations?.toJson(),
        "timezones": timezones == null
            ? []
            : List<dynamic>.from(timezones!.map((x) => x.toJson())),
        "value": value,
        "is_active": isActive,
        "_id": id,
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

class DoctorsAvailability {
  String? doctorId;
  List<String>? categoryId;
  List<String>? allSlots;
  String? slotDuration;
  bool? isDelete;
  String? id;
  List<Availability>? availableDates;
  List<dynamic>? availability;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  DoctorsAvailability({
    this.doctorId,
    this.categoryId,
    this.allSlots,
    this.slotDuration,
    this.isDelete,
    this.id,
    this.availableDates,
    this.availability,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DoctorsAvailability.fromJson(Map<String, dynamic> json) =>
      DoctorsAvailability(
        doctorId: json["doctor_id"],
        categoryId: json["category_id"] == null
            ? []
            : List<String>.from(json["category_id"]!.map((x) => x)),
        allSlots: json["all_slots"] == null
            ? []
            : List<String>.from(json["all_slots"]!.map((x) => x)),
        slotDuration: json["slot_duration"],
        isDelete: json["is_delete"],
        id: json["_id"],
        availableDates: json["available_dates"] == null
            ? []
            : List<Availability>.from(
                json["available_dates"]!.map((x) => Availability.fromJson(x))),
        availability: json["availability"] == null
            ? []
            : List<dynamic>.from(json["availability"]!.map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "category_id": categoryId == null
            ? []
            : List<dynamic>.from(categoryId!.map((x) => x)),
        "all_slots":
            allSlots == null ? [] : List<dynamic>.from(allSlots!.map((x) => x)),
        "slot_duration": slotDuration,
        "is_delete": isDelete,
        "_id": id,
        "available_dates": availableDates == null
            ? []
            : List<dynamic>.from(availableDates!.map((x) => x.toJson())),
        "availability": availability == null
            ? []
            : List<dynamic>.from(availability!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Availability {
  String? date;
  String? id;
  List<AvailableTimeSlot>? availableTimeSlot;
  String? dateType;
  String? availabilityType;

  Availability({
    this.date,
    this.id,
    this.availableTimeSlot,
    this.dateType,
    this.availabilityType,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        date: json["date"],
        id: json["_id"],
        availableTimeSlot: json["available_time_slot"] == null
            ? []
            : List<AvailableTimeSlot>.from(json["available_time_slot"]!
                .map((x) => AvailableTimeSlot.fromJson(x))),
        dateType: json["date_type"],
        availabilityType: json["availability_type"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "_id": id,
        "available_time_slot": availableTimeSlot == null
            ? []
            : List<dynamic>.from(availableTimeSlot!.map((x) => x.toJson())),
        "date_type": dateType,
        "availability_type": availabilityType,
      };
}

class AvailableTimeSlot {
  String? id;
  String? startTime;
  String? endTime;

  AvailableTimeSlot({
    this.id,
    this.startTime,
    this.endTime,
  });

  factory AvailableTimeSlot.fromJson(Map<String, dynamic> json) =>
      AvailableTimeSlot(
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
