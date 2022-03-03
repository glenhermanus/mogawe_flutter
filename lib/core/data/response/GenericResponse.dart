class GenericResponse {
  GenericResponse({
    required this.returnValue,
    required this.message,
  });

  String returnValue;
  String message;

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      GenericResponse(
        returnValue: json["returnValue"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
  };
}