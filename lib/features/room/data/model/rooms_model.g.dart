// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomsModel _$RoomsModelFromJson(Map<String, dynamic> json) => RoomsModel(
    id: json['id'] as String,
    last_message: json['last_message'] as String,
    members:
        (json['members'] as List<dynamic>).map((e) => e as String).toList(),
    unread_message: (json['unread_message'] as num).toInt(),
  )
  ..userInfoModel =
      json['userInfoModel'] == null
          ? null
          : UserInfoModel.fromJson(
            json['userInfoModel'] as Map<String, dynamic>,
          );

Map<String, dynamic> _$RoomsModelToJson(RoomsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'last_message': instance.last_message,
      'unread_message': instance.unread_message,
      'members': instance.members,
      'userInfoModel': instance.userInfoModel,
    };
