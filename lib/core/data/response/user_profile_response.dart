import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response.g.dart';

UserProfileResponse userProfileResponseFromJson(String str) =>
    UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) =>
    json.encode(data.toJson());


@JsonSerializable()
class UserProfileResponse {
  String returnValue;
  String message, mogawers_code, full_name, email, password, id_device, gender, profil_picture, edu;
  int id_mogawers, birthdate, level, gawean_selesai, pending_payment, downline_count, balance, points;
  dynamic uuid;
  dynamic type;
  dynamic object;
  bool termsAgreed, is_phone_active;

  UserProfileResponse({
    required this.returnValue,
    required this.uuid,
    required this.message,
    required this.mogawers_code,
    required this.full_name,
    required this.email,
    required this.password,
    required this.id_device,
    required this.gender,
    required this.profil_picture,
    required this.edu,
    required this.id_mogawers,
    required this.birthdate,
    required this.level,
    required this.gawean_selesai,
    required this.pending_payment,
    required this.downline_count,
    required this.balance,
    required this.points,
    required this.termsAgreed,
    required this.is_phone_active
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
