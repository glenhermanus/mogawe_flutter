// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) {
      return UserProfileResponse(
          returnValue: json['returnValue'] as String,
          message: json['message'] as String,
          uuid: json['uuid'],
          termsAgreed: json['object']['termsAgreed'],
          id_device: json['object']['id_device'] != null? json['object']['id_device'] : '',
          id_mogawers: json['object']['id_mogawers']!= null? json['object']['id_mogawers'] : '',
          full_name: json['object']['full_name']!= null? json['object']['full_name'] : '',
          edu: json['object']['edu']!= null? json['object']['edu'] : '',
          email: json['object']['email']!= null? json['object']['email'] : '',
          password: json['object']['password']!= null? json['object']['password'] : '',
          profil_picture: json['object']['profile_picture']!= null? json['object']['profile_picture'] : '',
          gawean_selesai: json['object']['gawean_selesai']!= null? json['object']['gawean_selesai'] : '',
          gender: json['object']['gender']!= null? json['object']['gender'] : '',
          birthdate: json['object']['birthdate']!= null? json['object']['birthdate'] : 0,
          level: json['object']['level']!= null? json['object']['level'] : '',
          mogawers_code: json['object']['mogawers_code']!= null? json['object']['mogawers_code'] : '',
          downline_count: json['object']['douwnline_count']!= null? json['object']['douwnline_count'] : '',
          pending_payment: json['object']['pending_payment']!= null? json['object']['pending_payment'] : '',
          is_phone_active: json['object']['is_phone_active']!= null? json['object']['is_phone_active'] : '',
          balance: json['object']['balance']!= null? json['object']['balance'] : '',
          points: json['object']['points']!= null? json['object']['points'] : ''
      );
}

Map<String, dynamic> _$UserProfileResponseToJson(UserProfileResponse instance) =>
    <String, dynamic>{
          'returnValue': instance.returnValue,
          'message': instance.message,
          'uuid': instance.uuid,
          'termsAgreed' : instance.termsAgreed,
          'id_device' : instance.id_device,
          'id_mogawers' : instance.id_mogawers,
          'full_name' : instance.full_name,
          'edu' : instance.edu,
          'email' : instance.email,
          'profile_picture' : instance.profil_picture,
          'gawean_selesai' : instance.gawean_selesai,
          'gender' : instance.gender,
          'birthdate' : instance.birthdate,
          'level' : instance.level,
          'mogawers_code' : instance.mogawers_code,
          'douwnline_count' : instance.downline_count,
          'pending_payment' : instance.pending_payment,
          'is_phone_active' : instance.is_phone_active,
          'balance' : instance.balance,
          'points' : instance.points,

    };
