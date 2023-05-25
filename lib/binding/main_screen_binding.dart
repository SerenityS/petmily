import 'package:get/get.dart';
import 'package:petmily/ui/main/controller/feeding_controller.dart';

class MainScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FeedingPageController());
  }
}
