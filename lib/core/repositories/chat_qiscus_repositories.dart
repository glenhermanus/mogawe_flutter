import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/response/qiscus/chat_message_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/chat_respnse.dart';
import 'package:mogawe/core/data/response/qiscus/chat_room_list_response.dart';
import 'package:mogawe/core/data/response/qiscus/createm_room_response.dart';
import 'package:mogawe/core/data/response/qiscus/get_uuid_user.dart';
import 'package:mogawe/core/data/response/qiscus/participants_response.dart';
import 'package:mogawe/core/data/response/qiscus/unread_response.dart';
import 'package:mogawe/core/data/response/qiscus/upload_file.dart';
import 'package:mogawe/core/data/sources/network/network_service.dart';
import 'package:http/http.dart' as http;

class ChatQiscusRepo {
  var url = 'https://api.qiscus.com/api/v2.1/rest';

  Future<UploadFotoQiscus> uploadFileChat(Map<String, File?>? body, String? realToken, type) async {
    print(realToken);
    var header = { 'token': realToken! }; //Use realToken when implement get from original token
    var map = await uploadFile("$BASE_URL/api/chatroom/upload/multipart", type,
        files: body, header: header);
    return UploadFotoQiscus.fromJson(map);
  }

  Future<dynamic> uploadFile(String endpoint, type, {Map<String, String>? body,
    Map<String, String>? header, Map<String, File?>? files}) async {
    Response response;
    Dio dio = Dio();

    try {
      var uri = Uri.parse(endpoint);
      var request = http.MultipartRequest("PUT", uri);

      if (files!.isNotEmpty) {
        files.forEach((key, value) async {
          print('aas $key bb $value');
          request.files.add(await http.MultipartFile.fromPath(key, value?.path ??'',
              contentType: MediaType('$type', '*')));
        });
      }

      if (header != null) request.headers.addAll(header);
      if (body != null)  request.fields.addAll(body);

      var response = await request.send().then(http.Response.fromStream);
      var res = jsonDecode(response.body);
      if (res["returnValue"] == "000") return res;
      else throw Exception(res["message"]);
    } on SocketException {
      throw Exception("Connection Failed");
    }

  }

  Future deleteMessage(uniqueid) async {
    var body = {

      "unique_ids": [uniqueid],

    };
    final response = await http.delete(Uri.parse(
        "$url/delete_messages"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'QISCUS-SDK-APP-ID' : 'mogawe-i1y2t3fnz2jt32',
          'QISCUS-SDK-SECRET' : '1166e34e4aa282b0f1185da3072790f6'
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {

      print('sukses');
    } else {

      throw Exception('Terjadi kegagalan');
    }
  }

  Future kirimTokenDevice(idDevice, token) async {
    var body = {

      "idDevice": idDevice,

    };
    final response = await http.post(Uri.parse(
        "$BASE_URL/api/mogawers/updateDeviceID"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token' : token,

        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {

      print('sukses');
    } else {

      throw Exception('Terjadi kegagalan');
    }
  }

  Future notificationSend(pesan, title, iduser, token) async{
    var body = {
      "isPushNotification": true,
      "message": pesan,
      "title": title,
      "uuidMogawers": iduser
    };

    final response = await http.post(Uri.parse(
        "$BASE_URL/api/fcm/mogawers"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token' : token,

        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      print(response.body);
      print('sukses');
    } else {

      throw Exception('Terjadi kegagalan');
    }
  }

  Future<ModelGetUuid> getUuiduser(email) async{

    var token = 'Syt3mMog4w3B4ck3nd';

    final response = await http.get(Uri.parse(
        "$BASE_URL/api/mogawers/get?offset=1&page=1&q=$email"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token' : token,

        } );

    if (response.statusCode == 200) {

      return ModelGetUuid.fromJson(json.decode(response.body));
    } else {

      throw Exception('Terjadi kegagalan');
    }
  }

  Future<QiscusRoomResponse> createRoom(judul, user, avatar) async {
    var avatarUrl;
    if(avatar !=''){
      avatarUrl = avatar;
    }
    else{
      avatarUrl = "http://placehold.it/20x20";
    }
    var body = {
      "room_name": judul,
      "creator": user,
      "participants": ["$user", "azizahif99@gmail.com", "demo@mogawe.id"],
      //"participants": ["$user", "azizahif99@gmail.com" ,"ambar.sumapradja@mogawe.id", "glen.hermanus@mogawe.id"],
      "room_avatar_url": avatarUrl,
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

  Future createUserorLogin(email, password, nama, foto) async {
    var body = {
      "user_id": email,
      "password": password,
      "username": nama,
      "avatar_url": foto
    };
    final response = await http.post(Uri.parse(
        "$url/login_or_register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'QISCUS-SDK-APP-ID' : 'mogawe-i1y2t3fnz2jt32',
          'QISCUS-SDK-SECRET' : '1166e34e4aa282b0f1185da3072790f6'
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {

      print('berhasil');
    } else {

      throw Exception('Terjadi kegagalan');
    }
  }

  Future<ParticipantsModel> getParticipants(roomid) async {

    final response = await http.get(Uri.parse(
        "$url/get_room_participants?room_id=$roomid"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'QISCUS-SDK-APP-ID' : 'mogawe-i1y2t3fnz2jt32',
        'QISCUS-SDK-SECRET' : '1166e34e4aa282b0f1185da3072790f6'
      },
    );

    if (response.statusCode == 200) {

      return ParticipantsModel.fromJson(json.decode(response.body));
    } else {

      throw Exception('Terjadi kegagalan');
    }
  }

  Future<ModelUnread> getUnread(user, roomid) async {

    final response = await http.get(Uri.parse(
        "$url/get_unread_count?user_id=$user&room_ids[]=$roomid"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'QISCUS-SDK-APP-ID' : 'mogawe-i1y2t3fnz2jt32',
        'QISCUS-SDK-SECRET' : '1166e34e4aa282b0f1185da3072790f6'
      },
    );

    if (response.statusCode == 200) {

      return ModelUnread.fromJson(json.decode(response.body));
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

  Future deleteroom(room, user) async {
    var body = {
      "room_id": room,
      "user_ids": [user],

    };
    final response = await http.post(Uri.parse(
        "$url/remove_room_participants"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'QISCUS-SDK-APP-ID' : 'mogawe-i1y2t3fnz2jt32',
          'QISCUS-SDK-SECRET' : '1166e34e4aa282b0f1185da3072790f6'
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {

      print('berhasil');
    } else {

      throw Exception('Terjadi kegagalan');
    }
  }

  Future<ChatResponse> kirimPesanFile(room, pesan, user, file) async {

    var body = {
      "room_id": room,
      "user_id": user,
      "type": "file_attachment",
      "payload": {
        "url" : file,
        "caption" : pesan
      }

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

  Future kirimPesanButton(room, pesan, user) async {
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

      print('ok');
    } else {

      throw Exception('Terjadi kegagalan');
    }
  }

  Future<ChatRoomList?> getRoomList(user_id) async {

    final requestUrl = '$url/get_user_rooms?user_id=$user_id';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'QISCUS-SDK-APP-ID' : 'mogawe-i1y2t3fnz2jt32',
        'QISCUS-SDK-SECRET' : '1166e34e4aa282b0f1185da3072790f6'
      },
    );
    if(response.statusCode == 200){
      final maps = json.decode(response.body);
      if (maps.isNotEmpty) {
        return ChatRoomList.fromJson(maps);
      }
      else {
        throw Exception('not found');
      }
    }

    return null;
  }

  Future<ChatRoomMessage> getMessageList(room_id) async {

    final requestUrl = '$url/load_comments?room_id=$room_id&page=1&limit=20';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'QISCUS-SDK-APP-ID' : 'mogawe-i1y2t3fnz2jt32',
        'QISCUS-SDK-SECRET' : '1166e34e4aa282b0f1185da3072790f6'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return ChatRoomMessage.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

}