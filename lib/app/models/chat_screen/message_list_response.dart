// To parse this JSON data, do
//
//     final messageListResponse = messageListResponseFromJson(jsonString);

import 'dart:convert';

MessageListResponse messageListResponseFromJson(String str) =>
    MessageListResponse.fromJson(json.decode(str));

String messageListResponseToJson(MessageListResponse data) =>
    json.encode(data.toJson());

class MessageListResponse {
  List<MessageListDatum>? data;

  MessageListResponse({
    this.data,
  });

  factory MessageListResponse.fromJson(Map<String, dynamic> json) =>
      MessageListResponse(
        data: json["data"] == null
            ? []
            : List<MessageListDatum>.from(
                json["data"]!.map((x) => MessageListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MessageListDatum {
  dynamic text;
  dynamic imageUrl;
  dynamic pdfUrl;
  dynamic videoUrl;
  dynamic seen;
  dynamic id;
  dynamic senderId;
  dynamic senderModel;
  dynamic receiverId;
  dynamic receiverModel;
  dynamic msgByUserId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  MessageListDatum({
    this.text,
    this.imageUrl,
    this.pdfUrl,
    this.videoUrl,
    this.seen,
    this.id,
    this.senderId,
    this.senderModel,
    this.receiverId,
    this.receiverModel,
    this.msgByUserId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MessageListDatum.fromJson(Map<String, dynamic> json) =>
      MessageListDatum(
        text: json["text"],
        imageUrl: json["imageUrl"],
        pdfUrl: json["pdfUrl"],
        videoUrl: json["videoUrl"],
        seen: json["seen"],
        id: json["_id"],
        senderId: json["senderId"],
        senderModel: json["senderModel"],
        receiverId: json["receiverId"],
        receiverModel: json["receiverModel"],
        msgByUserId: json["msgByUserId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "imageUrl": imageUrl,
        "videoUrl": videoUrl,
        "pdfUrl": pdfUrl,
        "seen": seen,
        "_id": id,
        "senderId": senderId,
        "senderModel": senderModel,
        "receiverId": receiverId,
        "receiverModel": receiverModel,
        "msgByUserId": msgByUserId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
