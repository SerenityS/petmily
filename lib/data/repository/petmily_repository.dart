import 'dart:convert';

import 'package:petmily/data/provider/api.dart';

class PetmilyRepository {
  final MyApiClient apiClient;

  PetmilyRepository({required this.apiClient});

  feeding(int amount, String chipId, String token) async {
    return await apiClient.post(ApiType.ws, body: jsonEncode({"chip_id": chipId, "command": "feed", "amount": amount}), token: token);
  }

  getPet(String token) async {
    return await apiClient.get(ApiType.petmily, token: token);
  }
}
