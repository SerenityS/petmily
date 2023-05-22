import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:petmily/data/model/device.dart';
import 'package:petmily/data/model/me.dart';
import 'package:petmily/data/model/user.dart';
import 'package:petmily/data/provider/api_exception.dart';
import 'package:petmily/data/repository/auth_repository.dart';
import 'package:petmily/service/secure_storage_service.dart';
import 'package:petmily/ui/init_setting/init_setting_screen.dart';
import 'package:petmily/ui/login/login_screen.dart';
import 'package:petmily/ui/main/main_screen.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  AuthController({required this.repository});

  final storage = Get.find<SecureStorageService>();

  late User? user;
  late List<Device> devices;
  Rx<bool> isAutoLogin = false.obs;

  String _jwt = "";
  String get jwt => _jwt;

  @override
  void onInit() async {
    super.onInit();
    user = await storage.getUser();

    if (user != null) {
      isAutoLogin.value = true;
      //await login(user!.email, user!.password);
    }
  }

  Future<List<Device>> getDevice() async {
    try {
      final response = await repository.getDevice(_jwt);
      List<Device> deviceList = jsonDecode(response).map<Device>((json) => Device.fromMap(json)).toList();
      return deviceList;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<Me> getMe() async {
    try {
      final response = await repository.getNick(_jwt);
      return Me.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      return Me(id: "", email: "", nick: "");
    }
  }

  Future<bool> login(String email, String pw) async {
    try {
      await repository.login(email, pw).then((data) async {
        _jwt = jsonDecode(data)['access_token'];
        storage.user = User(email: email, password: pw);
      });
      devices = await getDevice();

      if (devices.isEmpty) {
        Get.offAll(() => InitSettingScreen());
      } else {
        Get.offAll(() => const MainScreen());
      }
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(msg: "Login Failed.\nPlease check your Email and Password");
    }
    return false;
  }

  logout() async {
    storage.user = null;
    _jwt = "";
    isAutoLogin.value = false;

    Get.offAll(() => LoginScreen());
  }

  Future<bool> register(String email, String pw, String nick) async {
    try {
      await repository.register(email, pw, nick);
      Fluttertoast.showToast(
        msg: "Register Success! Please Login.",
      );
      Get.offAll(() => LoginScreen());
      return true;
    } on BadRequestException catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: "Already Exists. Please change your Email or Nickname.",
      );
    } on UnprocessableEntityException catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: "Please check your Email and Password.",
      );
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: "Register Failed. Please try again.",
      );
    }
    return false;
  }
}
