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
  Extras payload;
  DateTime timestamp;
  String type;
  String uniqueId;
  User user;

  Comment.fromJson(Map<String, dynamic> json) :
    extras= Extras.fromJson(json["extras"]),
    id= json["id"],
    message= json["message"],
    payload= Extras.fromJson(json["payload"]),
    timestamp= DateTime.parse(json["timestamp"]),
    type= json["type"],
    uniqueId= json["unique_id"],
    user= User.fromJson(json["user"]);

  Map<String, dynamic> toJson() => {
    "extras": extras.toJson(),
    "id": id,
    "message": message,
    "payload": payload.toJson(),
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
