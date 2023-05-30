import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petmily/controller/auth_controller.dart';
import 'package:petmily/controller/history_controller.dart';
import 'package:petmily/controller/petmily_controller.dart';
import 'package:petmily/controller/schedule_controller.dart';
import 'package:petmily/data/provider/api.dart';
import 'package:petmily/data/repository/auth_repository.dart';
import 'package:petmily/data/repository/history_repository.dart';
import 'package:petmily/data/repository/petmily_repository.dart';
import 'package:petmily/data/repository/schedule_repository.dart';

class DependencyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PetmilyController(
        repository: PetmilyRepository(
            apiClient: MyApiClient(
      httpClient: http.Client(),
    ))));
    Get.put(AuthController(
        repository: AuthRepository(
            apiClient: MyApiClient(
      httpClient: http.Client(),
    ))));
    Get.lazyPut(() => HistoryController(
            repository: HistoryRepository(
                apiClient: MyApiClient(
          httpClient: http.Client(),
        ))));
    Get.lazyPut(() => ScheduleController(
            repository: ScheduleRepository(
                apiClient: MyApiClient(
          httpClient: http.Client(),
        ))));
  }
}
