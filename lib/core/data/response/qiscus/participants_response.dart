
class ParticipantsModel {

  Results results;
  int status;

  ParticipantsModel.fromJson(Map<String, dynamic> json) :
    results= Results.fromJson(json["results"]),
    status= json["status"];

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
    "status": status,
  };
}

class Results {

  List<Participant> participants;

  Results.fromJson(Map<String, dynamic> json) :
    participants= List<Participant>.from(json["participants"].map((x) => Participant.fromJson(x)));

  Map<String, dynamic> toJson() => {
    "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
  };
}

class Participant {

  String avatarUrl;
  String userId;
  String username;

  Participant.fromJson(Map<String, dynamic> json) :
    avatarUrl= json["avatar_url"],
    userId= json["user_id"],
    username= json["username"];

  Map<String, dynamic> toJson() => {
    "avatar_url": avatarUrl,
    "user_id": userId,
    "username": username,
  };
}


