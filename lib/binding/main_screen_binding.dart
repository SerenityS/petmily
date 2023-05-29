import 'package:get/get.dart';
import 'package:petmily/ui/main/controller/feeding_controller.dart';
import 'package:petmily/ui/main/controller/main_screen_controller.dart';
import 'package:petmily/ui/main/controller/schedule_controller.dart';

class MainScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainScreenController());
    Get.lazyPut(() => FeedingPageController());
    Get.lazyPut(() => SchedulePageController());
  }
}
