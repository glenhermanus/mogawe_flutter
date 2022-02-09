
class ModelUnread {

  Results results;
  int status;

  ModelUnread.fromJson(Map<String, dynamic> json) :
    results= Results.fromJson(json["results"]),
    status= json["status"];

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
    "status": status,
  };
}

class Results {

  List<UnreadCount> unreadCounts;

  Results.fromJson(Map<String, dynamic> json) :
    unreadCounts= List<UnreadCount>.from(json["unread_counts"].map((x) => UnreadCount.fromJson(x)));

  Map<String, dynamic> toJson() => {
    "unread_counts": List<dynamic>.from(unreadCounts.map((x) => x.toJson())),
  };
}

class UnreadCount {

  String roomId;
  int unreadCount;

  UnreadCount.fromJson(Map<String, dynamic> json) :
    roomId= json["room_id"],
    unreadCount= json["unread_count"];

  Map<String, dynamic> toJson() => {
    "room_id": roomId,
    "unread_count": unreadCount,
  };
}
