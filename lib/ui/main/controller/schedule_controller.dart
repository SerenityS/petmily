import 'package:get/get.dart';
import 'package:petmily/data/model/feeding_schedule.dart';

class SchedulePageController extends GetxController {
  RxList<FeedingSchedule> scheduleList = <FeedingSchedule>[].obs;

  void updateSchedule(int index, FeedingSchedule schedule) {
    scheduleList[index] = schedule;
    update();
  }
}
