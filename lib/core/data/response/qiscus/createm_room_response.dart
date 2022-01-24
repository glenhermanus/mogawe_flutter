class QiscusRoomResponse {

  Results results;
  int status;

  QiscusRoomResponse.fromJson(Map<String, dynamic> json) :
    results= Results.fromJson(json["results"]),
    status= json["status"];

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
    "status": status,
  };
}

class Results {

  Room room;

  Results.fromJson(Map<String, dynamic> json) :
    room= Room.fromJson(json["room"]);

  Map<String, dynamic> toJson() => {
    "room": room.toJson(),
  };
}

class Room {

  String roomAvatarUrl;
  String roomChannelId;
  String roomId;
  String roomName;
  String roomOptions;
  String roomType;

  Room.fromJson(Map<String, dynamic> json) :
    roomAvatarUrl= json["room_avatar_url"],
    roomChannelId= json["room_channel_id"],
    roomId= json["room_id"],
    roomName= json["room_name"],
    roomOptions= json["room_options"],
    roomType= json["room_type"];

  Map<String, dynamic> toJson() => {
    "room_avatar_url": roomAvatarUrl,
    "room_channel_id": roomChannelId,
    "room_id": roomId,
    "room_name": roomName,
    "room_options": roomOptions,
    "room_type": roomType,
  };
}
