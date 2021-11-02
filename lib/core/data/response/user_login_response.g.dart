// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginResponse _$UserLoginResponseFromJson(Map<String, dynamic> json) {
  return UserLoginResponse(
    returnValue: json['returnValue'] as String,
    message: json['message'] as String,
    uuid: json['uuid'],
    token: json['token'] as String,
    type: json['type'],
    object: json['object'],
  );
}

Map<String, dynamic> _$UserLoginResponseToJson(UserLoginResponse instance) =>
    <String, dynamic>{
      'returnValue': instance.returnValue,
      'message': instance.message,
      'uuid': instance.uuid,
      'token': instance.token,
      'type': instance.type,
      'object': instance.object,
    };
