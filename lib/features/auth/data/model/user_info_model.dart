import 'package:json_annotation/json_annotation.dart';
part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  final String id;
  final String email;
  final String user_name;
  final String phone_number;
  final String? image_profile;

  UserInfoModel({
    required this.email,
    required this.id,
    this.image_profile,
    required this.phone_number,
    required this.user_name,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}

