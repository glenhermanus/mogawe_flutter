import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:mogawe/constant/api_path.dart';
import 'package:mogawe/core/data/request/reset_password_request.dart';
import 'package:mogawe/core/data/response/hire_me/category_list_response.dart';
import 'package:mogawe/core/data/response/hire_me/favorite_hire_me_sales_response.dart';
import 'package:mogawe/core/data/response/hire_me/hire_me_sales_response.dart';
import 'package:mogawe/core/data/response/hire_me/provinsi_response.dart';
import 'package:mogawe/core/data/response/hire_me/sales_detail_response.dart';
import 'package:mogawe/core/data/response/hire_me/seller_addres_response.dart';
import 'package:mogawe/core/data/response/hire_me/servis_ekspedisi_response.dart';
import 'package:mogawe/core/data/response/hire_me/shipment_city_response.dart';
import 'package:mogawe/core/data/response/merchant/alamat_merchant_pickup.dart';
import 'package:mogawe/core/data/response/merchant/alamat_merchant_pickup.dart';
import 'package:mogawe/core/data/response/merchant/category_response.dart';
import 'package:mogawe/core/data/response/merchant/supplier_product.dart';
import 'package:mogawe/core/data/response/merchant/supplier_product_detail.dart';
import 'package:mogawe/core/data/response/notification/notification_response.dart';
import 'package:mogawe/core/data/response/pesona/detail_pesona_response.dart';
import 'package:mogawe/core/data/response/pesona/pesona_response.dart';
import 'package:mogawe/core/data/response/reset_password_response.dart';
import 'package:mogawe/core/data/response/user_login_response.dart';
import 'package:mogawe/core/data/response/user_profile_response.dart';
import 'package:mogawe/core/data/response/user_response.dart';

class UserNetworkService {
  Future<UserResponse> fetchVersion(int versionNumber) async {
    final response = await http.get(Uri.parse(
        "$BASE_URL/api/mogawers/versionCheckerV2?versionNumber=$versionNumber"));
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Terjadi kegagalan');
    }
  }

  Future<UserLoginResponse> loginUser(String email, String password) async {
    // var encodedata = utf8.encode(password);         // data being hashed
    // var password_baru = sha256.convert(encodedata);
    // var convert_string = password_baru.toString();
    final response = await http.post(
      Uri.parse("$BASE_URL/api/mogawers/logIn/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    return UserLoginResponse.fromJson(json.decode(response.body));
  }

  Future<UserLoginResponse> loginUserFacebook(String email, String id, String nama) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/api/mogawers/logInSocMed"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'fullName': nama, 'email': email, 'idFacebook': id}),
    );
    return UserLoginResponse.fromJson(json.decode(response.body));
  }

  Future<UserLoginResponse> loginUserTwitter(String email, String id, String nama) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/api/mogawers/logInSocMed"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'fullName': nama, 'email': email, 'idTwitter': id}),
    );
    return UserLoginResponse.fromJson(json.decode(response.body));
  }

  Future<UserProfileResponse> profileUser(String token) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/api/mogawers/v2/getProfile"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
      body: jsonEncode(<String, String>{'token': token}),
    );
    return UserProfileResponse.fromJson(json.decode(response.body));
  }

  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest request) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/api/mogawers/forgotPassword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );
    return ResetPasswordResponse.fromJson(json.decode(response.body));
  }

  Future<PesonaResponses> pesonaresponse(token) async {
    print(token);
    final requestUrl = '$BASE_URL/api/mogawers/certificate/mine';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return PesonaResponses.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<DetailPesonaResponses> detailpesonaresponse(token, uuidjob) async {
    final requestUrl = '$BASE_URL/api/fieldtask/job/get/$uuidjob';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return DetailPesonaResponses.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<HireMeSalesResponses> hiremeSalesresponse(token) async {
    print(token);
    final requestUrl = '$BASE_URL/api/sales/product/get?page=1&offset=30';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },

    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return HireMeSalesResponses.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<HireMeSalesResponses> CategoryhiremeSalesresponse(token, uuid) async {
    print(token);
    final requestUrl = '$BASE_URL/api/sales/product/get?uuidCategory=$uuid&page=1&offset=30';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return HireMeSalesResponses.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<AddressPickupMerchant> AddressPickupMerchants(token) async {
    print(token);
    final requestUrl = '$BASE_URL/api/mogawers/supplier/address/get';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return AddressPickupMerchant.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<HireMeSalesResponses> SearchhiremeSalesresponse(token, string) async {
    final requestUrl = '$BASE_URL/api/sales/product/get?q=$string&page=1&offset=30';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return HireMeSalesResponses.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<NotificationResponse> getListNotification(token) async {
    final requestUrl = '$BASE_URL/api/mogawers/notification/get?page=1&offset=50';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return NotificationResponse.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<SupplierProduct> SearchProductMerchant(token, string) async {
    final requestUrl = '$BASE_URL/api/supplier/product/get?q=$string&page=1&offset=30';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return SupplierProduct.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future  InputProduct(token, uuidCategory, name, desk, brand, isDangerous, berat, width, height, length, condition, price, commission, stock, youtubeurl,
      isPublished, images, isFavorite, isFreeOngkir, isShippingTakeAway, imageUrl, isShippingOwnCourier, isShippingExpedition, shippingExpeditionService,
      alamat, toko, noteAlamat, radius, tokoSup, uuidSupplierAddress,  supplierAddressLatitude, supplierAddressLongitude, supplierAddressShipmentCityId,
      supplierAddressShipmentCityName, supplierAddressShipmentProvinceId, supplierAddressShipmentProvinceName) async {
    final requestUrl = '$BASE_URL/api/supplier/product/create';
    final response = await http.post(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
        body: jsonEncode(<String, dynamic>{
          "uuidCategory": uuidCategory,
          "name":name,
          "description":desk,
          "brand":brand,
          "isDangerous": isDangerous,
          "weight":berat,
          "width":0,
          "height":0,
          "length":0,
          "condition":"new",
          "price":price,
          "commission":commission,
          "stock":stock,
          "youtubeUrl":youtubeurl,
          "isPublished":true,
          "minimumOrder": 0,
          "imageUrl": imageUrl,
          "images":images,
          "isFavorite":false,
          "isFreeOngkir": isFreeOngkir,
          "isShippingTakeAway":isShippingTakeAway,
          "isShippingOwnCourier": isShippingOwnCourier,
          "isShippingExpedition": isShippingExpedition,
          "shippingExpeditionServices":shippingExpeditionService,
          "supplierAddressAddress": alamat,
          "supplierAddressName": toko,
          "supplierAddressNotes": noteAlamat,
          "supplierSelfPickupRadius": radius,
          "supplierStoreName": tokoSup,
          "productAddresses": [
            {
              "supplierAddressAddress": alamat,
              "supplierAddressLatitude": supplierAddressLatitude,
              "supplierAddressLongitude": supplierAddressLongitude,
              "supplierAddressName": toko,
              "supplierAddressNotes": noteAlamat,
              "supplierAddressShipmentCityId": supplierAddressShipmentCityId,
              "supplierAddressShipmentCityName": supplierAddressShipmentCityName,
              "supplierAddressShipmentProvinceId": supplierAddressShipmentProvinceId,
              "supplierAddressShipmentProvinceName": supplierAddressShipmentProvinceName,
              "uuidProduct": "",
              "uuidSupplierAddress": uuidSupplierAddress
            }
          ],
        }
    ));
    return json.decode(response.body);
  }

  Future UpdateProduct(token, uuidCategory, name, desk, brand, isDangerous, berat, width, height, length, condition, price, commission, stock, youtubeurl,
      isPublished, images, isFavorite, isFreeOngkir, imageUrl, isShippingTakeAway,  isShippingOwnCourier, isShippingExpedition, shippingExpeditionService,
      alamat, toko, tokoSup,noteAlamat, radius,) async {
    final requestUrl = '$BASE_URL/api/supplier/product/update';
    final response = await http.put(Uri.parse(requestUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8','token': '$token'
        },
        body: jsonEncode(<String, dynamic>{
          "uuidCategory": uuidCategory,
          "name":name,
          "description":desk,
          "brand":brand,
          "isDangerous": isDangerous,
          "weight":berat,
          "width":0,
          "height":0,
          "length":0,
          "condition":"new",
          "price":price,
          "commission":commission,
          "stock":stock,
          "youtubeUrl":youtubeurl,
          "isPublished":true,
          "minimumOrder": 0,
          "imageUrl": imageUrl,
          "images":images,
          "isFavorite":false,
          "isFreeOngkir": isFreeOngkir,
          "isShippingTakeAway":isShippingTakeAway,
          "isShippingOwnCourier": isShippingOwnCourier,
          "isShippingExpedition": isShippingExpedition,
          "shippingExpeditionServices":shippingExpeditionService,
          "supplierAddressAddress": alamat,
          "supplierAddressName": toko,
          "supplierAddressNotes": noteAlamat,
          "supplierSelfPickupRadius": radius,
          "supplierStoreName": tokoSup,
        }
        ));
    return json.decode(response.body);
  }


  Future<FavHireMeSalesResponses> favhiremeSalesresponse(token) async {

    print(token);
    final requestUrl = '$BASE_URL/api/sales/product/favorite/get?q=&page=1&offset=20';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return FavHireMeSalesResponses.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<HireMeSalesResponses> postFavHireMeSales(bool fav, String token, String uuid) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/api/sales/product/favorite/$uuid"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8', 'token': '$token'
      },
      body: jsonEncode(<String, String>{'isFavorite': fav.toString()}),
    );
    return HireMeSalesResponses.fromJson(json.decode(response.body));
  }

  Future<HireMeSalesResponses> deleteFavHireMeSales(bool fav, String token, String uuid) async {
    final response = await http.delete(
      Uri.parse("$BASE_URL/api/sales/product/favorite/$uuid"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8', 'token': '$token'
      },
      body: jsonEncode(<String, String>{'isFavorite': fav.toString()}),
    );
    return HireMeSalesResponses.fromJson(json.decode(response.body));
  }

  Future<CategoryListResponse> getCategory(String token) async {
    final requestUrl = '$BASE_URL/api/sales/product/category/get';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8', 'token': '$token'
      },

    );

    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return CategoryListResponse.fromJson(maps);
    }

    else {
      throw Exception('not found');
    }
  }

  Future<CategoryResponse> getCategoryDetail(String token, uuid) async {
    final requestUrl = '$BASE_URL/api/sales/product/category/get/$uuid';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8', 'token': '$token'
      },

    );

    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return CategoryResponse.fromJson(maps);
    }

    else {
      throw Exception('not found');
    }
  }

  Future<SalesDetailResponses> getSalesDetailresponse(token, uuid) async {
    print(token);
    final requestUrl = '$BASE_URL/api/sales/product/get/$uuid';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },

    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return SalesDetailResponses.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<ProvinsiResponse> getProvinceCheckout(token) async {
    print(token);
    final requestUrl = '$BASE_URL/api/sales/shipment/province';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return ProvinsiResponse.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<ShipmentCityResponse> getShipmentCheckout(token, id) async {
    print(token);
    final requestUrl = '$BASE_URL/api/sales/shipment/city?province=$id';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return ShipmentCityResponse.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<SellerAddress> getSellerAddress(token, uuidSuppAddress) async {
    print(token);
    final requestUrl = '$BASE_URL/api/mogawers/supplier/address/get/$uuidSuppAddress';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return SellerAddress.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<ServisEkspedisiResponse> getServisEkspedisi(token, buyerCity, supCity, weight, ekspedisi) async {
    print(token);
    final requestUrl = '$BASE_URL/api/sales/shipment/v2/cost?origin=$buyerCity&destination=$supCity&weight=$weight&courier=$ekspedisi';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return ServisEkspedisiResponse.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<SupplierProduct> getSupplierProduct(token ) async {
    print(token);
    final requestUrl = '$BASE_URL/api/supplier/product/get';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return SupplierProduct.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future<SupplierProductDetail> getSupplierProductId(token,id ) async {
    print(token);
    final requestUrl = '$BASE_URL/api/supplier/product/get/$id';
    final response = await http.get(Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8','token': '$token'
      },
    );
    final maps = json.decode(response.body);
    if (maps.isNotEmpty) {
      return SupplierProductDetail.fromJson(maps);
    }
    else {
      throw Exception('not found');
    }
  }

  Future checkout(uuid, buyername, buyerphone, buyeraddres, buyerlat, buyerlng, quantity, shipmentType, shipmentFee, shipmentProvinceId,
      shipmentProvinceName, shipmentCityId, shipmentCityName, shipmentEstMax, shipmentEstMin, price,total, commission, adminFee,
      resellerName, resellerPhone, resellerAddress, paymentMethod, trackingToken, refundStatus, additionalNotes, token) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/api/sales/product/checkout"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8', 'token': '$token'
      },
      body: jsonEncode(<String, dynamic>{'uuid' : uuid,
        'buyerName': buyername,
        'buyerPhone': buyerphone,
        'buyerAddres': buyeraddres,
        'buyerLat': buyerlat,
        'buyerLng' :buyerlng,
        'quantity': quantity,
        'shipmentType': shipmentType,
        'shipmentFee': shipmentFee,
        'shipmentProvinceId':shipmentProvinceId,
        'shipmentProvinceName': shipmentProvinceName,
        'shipmentCityId': shipmentCityId,
        'shipmentCityName': shipmentCityName,
        'shipmentEstMax':shipmentEstMax,
        'shipmentEstMin':shipmentEstMin,
        'price':price,
        'total':total,
        'commission':commission,
        'adminFee': adminFee,
        'resellerName':
        resellerName, 'resellerPhone':resellerPhone, 'resellerAddress':resellerAddress, 'paymentMethod': paymentMethod,
        'trackingToken':trackingToken, 'refundStatus' :refundStatus, 'additionalNotes': additionalNotes}),
    );
    return json.decode(response.body);
  }

}
