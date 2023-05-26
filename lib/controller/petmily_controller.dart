import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/controller/auth_controller.dart';
import 'package:petmily/data/model/device_data.dart';
import 'package:petmily/data/model/pet.dart';
import 'package:petmily/data/model/user.dart';
import 'package:petmily/data/repository/petmily_repository.dart';

class PetmilyController extends GetxController {
  final PetmilyRepository repository;
  PetmilyController({required this.repository});

  final RxList<Pet> _petList = <Pet>[].obs;
  List<Pet> get petList => _petList;

  final Rx<DeviceData> _deviceData = DeviceData(chipId: "", bowlAmount: 0, feedBoxAmount: 0).obs;
  DeviceData get deviceData => _deviceData.value;

  Future<void> feeding(int amount, String chipId) async {
    try {
      User user = Get.find<AuthController>().user!;
      await repository.feeding(amount, chipId, user.jwt);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getDeviceData() async {
    try {
      User user = Get.find<AuthController>().user!;
      final response = await repository.getDeviceData(petList[0].chipId, user.jwt);
      _deviceData.value = DeviceData.fromMap(jsonDecode(response));
    } catch (e) {
      print("Error");
      debugPrint(e.toString());
    }
  }

  Future<List<Pet>> getPet() async {
    try {
      User user = Get.find<AuthController>().user!;
      final response = await repository.getPet(user.jwt);
      _petList.assignAll(jsonDecode(response).map<Pet>((json) => Pet.fromMap(json)).toList());
      return _petList;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
