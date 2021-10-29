import 'package:mogawe/core/data/request/reset_password_request.dart';
import 'package:mogawe/core/data/response/reset_password_response.dart';
import 'package:mogawe/core/data/response/user_login_response.dart';
import 'package:mogawe/core/data/response/user_response.dart';
import 'package:mogawe/core/data/sources/network/user_network_service.dart';

class AuthRepository {
  final UserNetworkService _apiService = UserNetworkService();

  Future<UserResponse> getVersionNumber(int versionNumber) async {
    return _apiService.fetchVersion(versionNumber);
  }

  Future<UserLoginResponse> submitLogin(String email, String password) async {
    return _apiService.loginUser(email, password);
  }

  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) {
    return _apiService.resetPassword(request);
  }
}
