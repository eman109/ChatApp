// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  roomId: json['roomId'] as String,
  senderId: json['senderId'] as String,
);

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'senderId': instance.senderId,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
    };
