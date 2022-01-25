
class ChatRoomList {

  Results results;
  int status;

  ChatRoomList.fromJson(Map<String, dynamic> json) :
    results= Results.fromJson(json["results"]),
    status= json["status"];

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
    "status": status,
  };
}

class Results {

  Meta meta;
  List<Room> rooms;

  Results.fromJson(Map<String, dynamic> json) :
    meta= Meta.fromJson(json["meta"]),
    rooms=List<Room>.from(json["rooms"].map((x) => Room.fromJson(x)));

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
  };
}

class Meta {

  int currentPage;

  Meta.fromJson(Map<String, dynamic> json) :
    currentPage= json["current_page"];

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
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
