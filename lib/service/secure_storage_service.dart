import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:petmily/data/model/user.dart';

class SecureStorageService extends GetxService {
  FlutterSecureStorage? _storage;

  Future<SecureStorageService> init() async {
    _storage = const FlutterSecureStorage();
    return this;
  }

  Future<User?> getUser() async {
    final user = await _storage?.read(key: 'user');
    if (user != null) {
      return User.fromJson(json.decode(user));
    } else {
      return null;
    }
  }

  set user(User? user) {
    if (user != null) {
      _storage!.write(key: 'user', value: json.encode(user.toJson()));
    } else {
      _storage!.delete(key: 'user');
    }
  }
}
