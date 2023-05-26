import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/controller/auth_controller.dart';
import 'package:petmily/data/model/pet.dart';
import 'package:petmily/data/model/user.dart';
import 'package:petmily/data/repository/petmily_repository.dart';

class PetmilyController extends GetxController {
  final PetmilyRepository repository;
  PetmilyController({required this.repository});

  final RxList<Pet> _petList = <Pet>[].obs;
  List<Pet> get petList => _petList;

  Future<void> feeding(int amount, String chipId) async {
    try {
      User user = Get.find<AuthController>().user!;
      final response = await repository.feeding(amount, chipId, user.jwt);
      debugPrint(response);
    } catch (e) {
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
