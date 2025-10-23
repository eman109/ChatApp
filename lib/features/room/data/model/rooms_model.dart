import 'package:chat/features/auth/data/model/user_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rooms_model.g.dart';

@JsonSerializable()
class RoomsModel {
  final String id;
  final String last_message;
  final int unread_message;
  final List<String> members;
  UserInfoModel? userInfoModel;

  RoomsModel({
    required this.id,
    required this.last_message,
    required this.members,
    required this.unread_message,
  });
  factory RoomsModel.fromJson(Map<String, dynamic> json) =>
      _$RoomsModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoomsModelToJson(this);
}
