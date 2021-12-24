class ProfileResponse {
  String? returnValue;
  String? message;
  ObjectData? object;

  ProfileResponse.fromJsonMap(Map<String, dynamic> map):
    returnValue = map["returnValue"],
    message = map["message"],
    object = map["object"] == null? null: ObjectData.fromJsonMap(map["object"]);

  Map<String, dynamic> toJson() {
    return {
      "returnValue": returnValue,
      "message": message,
      "object": object!.toJson()
    };
  }
}

class ObjectData {
  dynamic certification;
  List<PostTimelinesData>? postTImelines;
  ConfigData? config;
  bool? termsAgreed;
  int? idMogawers;
  String? uuid;
  String? mogawersCode;
  String? fullName;
  String? email;
  String? phone;
  String? idDevice;
  String? profilePicture;
  String? gender;
  int? birthdate;
  double? latitude;
  double? longitude;
  String? address;
  String? city;
  int? level;
  int? gaweanSelesai;
  int? downlineCount;
  int? pendingPayment;
  String? refCode;
  String? edu;
  bool? isPhoneActive;
  int? balance;
  int? point;
  bool? hasPassword;
  bool? isTermsAgreed;
  int? balanceLatestUpdated;
  String? statusTimeline;

  ObjectData.fromJsonMap(Map<String, dynamic> map):
    certification = map["certification"] == null? []: [],
    postTImelines = map["postTimelines"] == null? []: List.from(
      map["postTimelines"].map((it) => PostTimelinesData.fromJsonMap(it))),
    config = map["config"] == null? null: ConfigData.fromJsonMap(map["config"]),
        termsAgreed = map["termsAgreed"],
        idMogawers = map["id_mogawers"],
    uuid = map["uuid"],
    mogawersCode = map["mogawers_code"],
    fullName = map["full_name"],
    email = map["email"],
    phone = map["phone"],
    idDevice = map["id_device"],
    profilePicture = map["profile_picture"],
    gender = map["gender"],
    birthdate = map["birthdate"] != null ? map["birthdate"] : 0,
    latitude = map["latitude"],
    longitude = map["longitude"],
    address = map["address"],
    city = map["city"],
    level = map["level"],
    gaweanSelesai = map["gawean_selesai"],
    downlineCount = map["douwnline_count"],
    pendingPayment = map["pending_payment"],
    refCode = map["ref_code"],
    edu = map["edu"],
    isPhoneActive = map["is_phone_active"],
    balance = map["balance"],
    point = map["point"],
    hasPassword = map["has_password"],
    isTermsAgreed = map["is_terms_agreed"],
    balanceLatestUpdated = map["balance_latest_updated"],
    statusTimeline = map["status_timeline"];

  Map<String, dynamic> toJson() {
    return {
      "certification": certification,
      "postTimelines": postTImelines,
      "termsAgreed": termsAgreed,
      "id_mogawers": idMogawers,
      "uuid": uuid,
      "mogawers_code": mogawersCode,
      "full_name": fullName,
      "email": email,
      "phone": phone,
      "id_device": idDevice,
      "profile_picture": profilePicture,
      "gender": gender,
      "birthdate": birthdate,
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "city": city,
      "level": level,
      "gawean_selesai": gaweanSelesai,
      "downline_count": downlineCount,
      "pending_payment": pendingPayment,
      "ref_code": refCode,
      "edu": edu,
      "is_phone_active": isPhoneActive,
      "balance": balance,
      "point": point,
      "has_password": hasPassword,
      "is_terms_agreed": isTermsAgreed,
      "balance_latest_updated": balanceLatestUpdated,
      "status_timeline": statusTimeline,
    };
  }
}

class PostTimelinesData {
  String? uuid;
  String? uuidPostType;
  String? uuidMogawers;
  String? fullName;
  String? mogawersCode;
  String? phone;
  String? profilePicture;
  String? content;
  int? likesCount;
  bool? isLiked;
  bool? isCommentable;
  bool? isShareable;
  bool? isLikeable;
  String? imgUrl;
  String? relationshipStatus;
  bool? isActive;

  PostTimelinesData.fromJsonMap(Map<String, dynamic> map):
    uuid = map["uuid"],
    uuidPostType = map["uuidPostType"],
    uuidMogawers = map["uuidMogawers"],
    fullName = map["fullName"],
    mogawersCode = map["mogawersCode"],
    phone = map["phone"],
    profilePicture = map["profilePicture"],
    content = map["content"],
    likesCount = map["likesCount"],
    isLiked = map["isLiked"],
    isCommentable = map["isCommentable"],
    isShareable = map["isShareable"],
    isLikeable = map["isLikeable"],
    imgUrl = map["imgUrl"],
    relationshipStatus = map["relationshipStatus"],
    isActive = map["isActive"];

  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid,
      "uuidPostType": uuidPostType,
      "uuidMogawers": uuidMogawers,
      "fullName": fullName,
      "mogawersCode": mogawersCode,
      "phone": phone,
      "profilePicture": profilePicture,
      "content": content,
      "likesCount": likesCount,
      "isLiked": isLiked,
      "isCommentable": isCommentable,
      "isShareable": isShareable,
      "isLikeable": isLikeable,
      "imgUrl": imgUrl,
      "relationshipStatus": relationshipStatus,
      "isActive": isActive,
    };
  }
}

class ConfigData {
  int? limitGawean;
  double? targetRevenue;
  int? updatedDate;
  String? updatedBy;

  ConfigData.fromJsonMap(Map<String, dynamic> map):
    limitGawean = map["limitGawean"],
    targetRevenue = map["targetRevenue"],
    updatedDate = map["updatedDate"],
    updatedBy = map["updatedBy"];

  Map<String, dynamic> toJson() {
    return {
      "limitGawean": limitGawean,
      "targetRevenue": targetRevenue,
      "updatedDate": updatedDate,
      "updatedBy": updatedBy,
    };
  }
}