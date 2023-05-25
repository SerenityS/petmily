import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/data/model/pet.dart';
import 'package:petmily/data/model/user.dart';
import 'package:petmily/data/repository/pet_repository.dart';
import 'package:petmily/service/secure_storage_service.dart';

class PetController extends GetxController {
  final PetRepository repository;
  PetController({required this.repository});

  final storage = Get.find<SecureStorageService>();

  final RxList<Pet> _petList = <Pet>[].obs;
  List<Pet> get petList => _petList;

  Future<List<Pet>> getPet() async {
    try {
      User? user = await storage.getUser();
      final response = await repository.getPet(user!.jwt);
      _petList.assignAll(jsonDecode(response).map<Pet>((json) => Pet.fromMap(json)).toList());
      return _petList;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
