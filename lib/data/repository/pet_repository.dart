import 'package:petmily/data/provider/api.dart';

class PetRepository {
  final MyApiClient apiClient;

  PetRepository({required this.apiClient});

  getPet(String token) async {
    return await apiClient.get(ApiType.pet, token: token);
  }
}
