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
  dynamic payload;
  User user;

  Comment.fromJson(Map<String, dynamic> json) :
    message= json["message"],
    timestamp= DateTime.parse(json["timestamp"]).toLocal(),
    type= json["type"],
    payload= json["payload"],
    user= User.fromJson(json["user"]);

  Map<String, dynamic> toJson() => {
    "message": message,
    "timestamp": timestamp.toIso8601String(),
    "type": type,
    "payload": payload,
    "user": user.toJson(),
  };
}

class User {

  String avatarUrl;
  String userId;
  String username;

  User.fromJson(Map<String, dynamic> json) :
    avatarUrl= json["avatar_url"],
    userId= json["user_id"],
    username= json["username"];

  Map<String, dynamic> toJson() => {
    "avatar_url": avatarUrl,
    "user_id": userId,
    "username": username,
  };
}
