import 'dart:convert';

import 'package:petmily/data/model/pet.dart';
import 'package:petmily/data/provider/api.dart';

class PetmilyRepository {
  final MyApiClient apiClient;

  PetmilyRepository({required this.apiClient});

  feeding(int amount, String chipId, String token) async {
    return await apiClient.post(ApiType.ws, body: jsonEncode({"chip_id": chipId, "command": "feed", "feed_amount": amount}), token: token);
  }

  getDeviceData(String chipId, String token) async {
    return await apiClient.get(ApiType.device, queryParameter: {"chip_id": chipId}, token: token);
  }

  getPet(String token) async {
    return await apiClient.get(ApiType.petmily, token: token);
  }

  postPet(Pet pet, String token) async {
    return await apiClient.post(ApiType.petmily, body: pet.toJson(), token: token);
  }

  postPetImage(String path, String chipId, String token) async {
    return await apiClient.postPetImage(path, chipId: chipId, token: token);
  }
}
