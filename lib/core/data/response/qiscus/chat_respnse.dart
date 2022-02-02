class ChatResponse {

  Results results;
  int status;

  ChatResponse.fromJson(Map<String, dynamic> json) :
    results= Results.fromJson(json["results"]),
    status= json["status"];

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
    "status": status,
  };
}

class Results {

  Comment comment;

  Results.fromJson(Map<String, dynamic> json) :
    comment= Comment.fromJson(json["comment"]);

  Map<String, dynamic> toJson() => {
    "comment": comment.toJson(),
  };
}

class Comment {

  Extras extras;
  int id;
  String message;
  Payload? payload;
  DateTime timestamp;
  String type;
  String uniqueId;
  User user;

  Comment.fromJson(Map<String, dynamic> json) :
    extras= Extras.fromJson(json["extras"]),
    id= json["id"],
    message= json["message"],
    payload= json["payload"] == null? null : Payload.fromJson(json["payload"]),
    timestamp= DateTime.parse(json["timestamp"]).toLocal(),
    type= json["type"],
    uniqueId= json["unique_id"],
    user= User.fromJson(json["user"]);

  Map<String, dynamic> toJson() => {
    "extras": extras.toJson(),
    "id": id,
    "message": message,
    "payload": payload!.toJson(),
    "timestamp": timestamp.toIso8601String(),
    "type": type,
    "unique_id": uniqueId,
    "user": user.toJson(),
  };
}

class Extras {
  Extras();

  factory Extras.fromJson(Map<String, dynamic> json) => Extras(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Payload {

  String url;
  String caption;
  String fileName;
  int size;
  int pages;
  String encryptionKey;

  Payload.fromJson(Map<String, dynamic> json) :
        url= json["url"] == null ? '' : json["url"],
        caption= json["caption"]== null ? '' :json["caption"],
        fileName= json["file_name"]== null ? '' :json["file_name"],
        size= json["size"]== null ? 0 :json["size"],
        pages= json["pages"]== null ? 0 :json["pages"],
        encryptionKey= json["encryption_key"] == null ? '' : json["encryption_key"];

  Map<String, dynamic> toJson() => {
    "url": url,
    "caption": caption,
    "file_name": fileName,
    "size": size,
    "pages": pages,
    "encryption_key": encryptionKey,
  };
}

class User {

  bool active;
  String avatarUrl;
  Extras extras;
  String userId;
  String username;

  User.fromJson(Map<String, dynamic> json) :
    active= json["active"],
    avatarUrl= json["avatar_url"],
    extras= Extras.fromJson(json["extras"]),
    userId=json["user_id"],
    username= json["username"];

  Map<String, dynamic> toJson() => {
    "active": active,
    "avatar_url": avatarUrl,
    "extras": extras.toJson(),
    "user_id": userId,
    "username": username,
  };
}
