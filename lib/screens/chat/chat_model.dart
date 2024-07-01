// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  String senderId;
  String senderName;
  String receiverId;
  String receiverName;
  DateTime sendDateTime;
  String message;
  String? attachment;

  ChatModel({
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.sendDateTime,
    required this.message,
    this.attachment,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        senderId: json["senderId"],
        senderName: json["senderName"],
        receiverId: json["receiverId"],
        receiverName: json["receiverName"],
        sendDateTime: DateTime.parse(json["sendDateTime"]),
        message: json["message"],
        attachment: json["attachment"],
      );

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "senderName": senderName,
        "receiverId": receiverId,
        "receiverName": receiverName,
        "sendDateTime": sendDateTime.toIso8601String(),
        "message": message,
        "attachment": attachment,
      };
}
