// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      email: json['email'] as String,
      id: json['id'] as String,
      image_profile: json['image_profile'] as String?,
      phone_number: json['phone_number'] as String,
      user_name: json['user_name'] as String,
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'user_name': instance.user_name,
      'phone_number': instance.phone_number,
      'image_profile': instance.image_profile,
    };
