// To parse this JSON data, do
//
//     final chatListResponse = chatListResponseFromJson(jsonString);

import 'dart:convert';

ChatListResponse chatListResponseFromJson(String str) =>
    ChatListResponse.fromJson(json.decode(str));

String chatListResponseToJson(ChatListResponse data) =>
    json.encode(data.toJson());

class ChatListResponse {
  List<ChatListData>? data;

  ChatListResponse({
    this.data,
  });

  factory ChatListResponse.fromJson(Map<String, dynamic> json) =>
      ChatListResponse(
        data: json["data"] == null
            ? []
            : List<ChatListData>.from(
                json["data"]!.map((x) => ChatListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ChatListData {
  dynamic id;
  LastMsg? lastMsg;
  dynamic unseenMsg;
  UserDetails? userDetails;

  ChatListData({
    this.id,
    this.lastMsg,
    this.unseenMsg,
    this.userDetails,
  });

  factory ChatListData.fromJson(Map<String, dynamic> json) => ChatListData(
        id: json["_id"],
        lastMsg:
            json["lastMsg"] == null ? null : LastMsg.fromJson(json["lastMsg"]),
        unseenMsg: json["unseenMsg"],
        userDetails: json["userDetails"] == null
            ? null
            : UserDetails.fromJson(json["userDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "lastMsg": lastMsg?.toJson(),
        "unseenMsg": unseenMsg,
        "userDetails": userDetails?.toJson(),
      };
}

class LastMsg {
  dynamic text;
  dynamic imageUrl;
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

  LastMsg({
    this.text,
    this.imageUrl,
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

  factory LastMsg.fromJson(Map<String, dynamic> json) => LastMsg(
        text: json["text"],
        imageUrl: json["imageUrl"],
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

class UserDetails {
  String? uid;
  String? firstName;
  String? lastName;
  String? image;
  dynamic id;
  dynamic specialist;

  UserDetails(
      {this.uid,
      this.firstName,
      this.lastName,
      this.image,
      this.id,
      this.specialist});

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        uid: json["uid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        id: json["_id"],
        specialist: json["specialist"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "_id": id,
        "specialist": specialist,
      };
}
