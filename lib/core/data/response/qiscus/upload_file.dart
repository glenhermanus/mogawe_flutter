class UploadFotoQiscus {
  UploadFotoQiscus({
    this.returnValue,
    this.message,
    this.object,
  });

  String? returnValue;
  String? message;
  String? object;


  factory UploadFotoQiscus.fromJson(Map<String, dynamic> json) => UploadFotoQiscus(
    returnValue: json["returnValue"],
    message: json["message"],
    object: json["object"],
  );

  Map<String, dynamic> toJson() => {
    "returnValue": returnValue,
    "message": message,
    "object": object,
  };
}