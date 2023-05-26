import 'package:petmily/data/provider/api.dart';

class HistoryRepository {
  final MyApiClient apiClient;

  HistoryRepository({required this.apiClient});

  getHistory(String token) async {
    return await apiClient.get(ApiType.history, token: token);
  }
}
