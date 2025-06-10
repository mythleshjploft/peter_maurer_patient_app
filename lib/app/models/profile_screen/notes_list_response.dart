// To parse this JSON data, do
//
//     final notesListResponse = notesListResponseFromJson(jsonString);

import 'dart:convert';

NotesListResponse notesListResponseFromJson(String str) =>
    NotesListResponse.fromJson(json.decode(str));

String notesListResponseToJson(NotesListResponse data) =>
    json.encode(data.toJson());

class NotesListResponse {
  bool? success;
  String? message;
  List<NotesDatum>? data;

  NotesListResponse({
    this.success,
    this.message,
    this.data,
  });

  factory NotesListResponse.fromJson(Map<String, dynamic> json) =>
      NotesListResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<NotesDatum>.from(
                json["data"]!.map((x) => NotesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotesDatum {
  dynamic description;
  DoctorId? doctorId;
  dynamic status;
  dynamic patientId;
  dynamic date;
  dynamic isDelete;
  dynamic isActive;
  dynamic id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  NotesDatum({
    this.description,
    this.doctorId,
    this.status,
    this.patientId,
    this.date,
    this.isDelete,
    this.isActive,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotesDatum.fromJson(Map<String, dynamic> json) => NotesDatum(
        description: json["description"],
        doctorId: json["doctor_id"] == null
            ? null
            : DoctorId.fromJson(json["doctor_id"]),
        status: json["status"],
        patientId: json["patient_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
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
        "description": description,
        "doctor_id": doctorId?.toJson(),
        "status": status,
        "patient_id": patientId,
        "date": date?.toIso8601String(),
        "is_delete": isDelete,
        "is_active": isActive,
        "_id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class DoctorId {
  dynamic firstName;
  dynamic lastName;
  dynamic id;

  DoctorId({
    this.firstName,
    this.lastName,
    this.id,
  });

  factory DoctorId.fromJson(Map<String, dynamic> json) => DoctorId(
        firstName: json["first_name"],
        lastName: json["last_name"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "_id": id,
      };
}
