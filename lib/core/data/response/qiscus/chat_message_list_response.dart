// To parse this JSON data, do
//
//     final chatRoomMessage = chatRoomMessageFromJson(jsonString);

class ChatRoomMessage {

  Results results;
  int status;

  ChatRoomMessage.fromJson(Map<String, dynamic> json) :
    results= Results.fromJson(json["results"]),
    status= json["status"];

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
    "status": status,
  };
}

class Results {

  List<Comment> comments;

  Results.fromJson(Map<String, dynamic> json) :
    comments= List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x)));

  Map<String, dynamic> toJson() => {
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {

  String message;
  DateTime timestamp;
  String type;
  Payload? payload;
  User user;

  Comment.fromJson(Map<String, dynamic> json) :
    message= json["message"],
    timestamp= DateTime.parse(json["timestamp"]).toLocal(),
    type= json["type"],
    payload= json["payload"] != null ? Payload.fromJson(json["payload"]) : null,
    user= User.fromJson(json["user"]);

  Map<String, dynamic> toJson() => {
    "message": message,
    "timestamp": timestamp.toIso8601String(),
    "type": type,
    "payload": payload,
    "user": user.toJson(),
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

  String avatarUrl;
  String userId;
  String username;
  bool active;

  User.fromJson(Map<String, dynamic> json) :
    avatarUrl= json["avatar_url"],
    userId= json["user_id"],
    active = json["active"],
    username= json["username"];

  Map<String, dynamic> toJson() => {
    "avatar_url": avatarUrl,
    "user_id": userId,
    "username": username,
  };
}
