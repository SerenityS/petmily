import 'dart:convert';

import 'package:petmily/data/provider/api.dart';

class AuthRepository {
  final MyApiClient apiClient;

  AuthRepository({required this.apiClient});

  getDevice(String token) async {
    return await apiClient.get(ApiType.device, token: token);
  }

  getNick(String token) async {
    return await apiClient.get(ApiType.me, token: token);
  }

  login(String email, String pw) async {
    return await apiClient.post(
      ApiType.login,
      header: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"username": email, "password": pw},
    );
  }

  register(String email, String pw, String nick) async {
    return await apiClient.post(
      ApiType.register,
      body: jsonEncode({
        "email": email,
        "password": pw,
        "nick": nick,
        "is_active": true,
        "is_superuser": false,
        "is_verified": true,
      }),
    );
  }
}
