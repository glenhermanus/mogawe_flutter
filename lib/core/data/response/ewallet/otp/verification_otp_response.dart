import 'package:meta/meta.dart';
import 'dart:convert';

VerificationOtpResponse verificationOtpResponseFromJson(String str) => VerificationOtpResponse.fromJson(json.decode(str));

String verificationOtpResponseToJson(VerificationOtpResponse data) => json.encode(data.toJson());

class VerificationOtpResponse {
    VerificationOtpResponse({
        required this.returnValue,
        required this.message,
        required this.uuid,
        required this.object,
        required this.object2,
    });

    String returnValue;
    String message;
    dynamic uuid;
    dynamic object;
    dynamic object2;

    factory VerificationOtpResponse.fromJson(Map<String, dynamic> json) => VerificationOtpResponse(
        returnValue: json["returnValue"],
        message: json["message"],
        uuid: json["uuid"],
        object: json["object"],
        object2: json["object2"],
    );

    Map<String, dynamic> toJson() => {
        "returnValue": returnValue,
        "message": message,
        "uuid": uuid,
        "object": object,
        "object2": object2,
    };
}
