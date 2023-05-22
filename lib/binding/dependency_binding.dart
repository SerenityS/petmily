import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petmily/controller/auth_controller.dart';
import 'package:petmily/data/provider/api.dart';
import 'package:petmily/data/repository/auth_repository.dart';

class DependencyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(
        repository: AuthRepository(
            apiClient: MyApiClient(
      httpClient: http.Client(),
    ))));
  }
}
