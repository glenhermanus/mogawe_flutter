import 'dart:convert';

import 'package:mogawe/core/data/response/qiscus/chat_respnse.dart';
import 'package:mogawe/core/data/response/qiscus/chat_room_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/createm_room_response.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';
import 'package:http/http.dart' as http;

class ChatQiscusRepo {
  var url = 'https://api.qiscus.com/api/v2.1/rest';

  Future<QiscusRoomResponse> createRoom(judul, user) async {
    var body = {
      "room_name": judul,
      "creator": user,
      "participants": ["$user", "ambar.sumapradja@mogawe.id", "glen.hermanus@mogawe.id"],
      "room_avatar_url": "http://placehold.it/20x20",
      "room_options": "{\"background\":\"green\"}"
    };
    final response = await http.post(Uri.parse(
        "$url/create_room"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'QISCUS-SDK-APP-ID' : 'mogawe-i1y2t3fnz2jt32',
          'QISCUS-SDK-SECRET' : '1166e34e4aa282b0f1185da3072790f6'
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {

      return QiscusRoomResponse.fromJson(json.decode(response.body));
    } else {

      throw Exception('Terjadi kegagalan');
    }
  }

  Future<ChatResponse> kirimPesan(room, pesan, user) async {
    var body = {
      "room_id": room,
      "user_id": user,
      "message": pesan,

    };
    final response = await http.post(Uri.parse(
        "$url/post_comment"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'QISCUS-SDK-APP-ID' : 'mogawe-i1y2t3fnz2jt32',
          'QISCUS-SDK-SECRET' : '1166e34e4aa282b0f1185da3072790f6'
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {

      return ChatResponse.fromJson(json.decode(response.body));
    } else {

      throw Exception('Terjadi kegagalan');
    }
  }

  Future<ChatRoomList> getRoomList(user_id) async {

    final requestUrl = '$url/get_user_rooms?user_id=$user_id&page=1&limit=2';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'QISCUS-SDK-APP-ID' : 'mogawe-i1y2t3fnz2jt32',
        'QISCUS-SDK-SECRET' : '1166e34e4aa282b0f1185da3072790f6'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return ChatRoomList.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

}