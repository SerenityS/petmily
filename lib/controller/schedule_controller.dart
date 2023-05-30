import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:petmily/controller/auth_controller.dart';
import 'package:petmily/controller/petmily_controller.dart';
import 'package:petmily/data/model/schedule.dart';
import 'package:petmily/data/model/pet.dart';
import 'package:petmily/data/model/user.dart';
import 'package:petmily/data/repository/schedule_repository.dart';

class ScheduleController extends GetxController {
  ScheduleController({required this.repository});

  Pet pet = Get.find<PetmilyController>().petList[0];
  final ScheduleRepository repository;
  RxList<Schedule> scheduleList = <Schedule>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getSchedule();
  }

  Future<void> getSchedule() async {
    try {
      User user = Get.find<AuthController>().user!;
      final response = await repository.getSchedule(pet.chipId, user.jwt);
      scheduleList.assignAll(jsonDecode(response).map<Schedule>((json) => Schedule.fromMap(json)).toList());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> postSchedule() async {
    try {
      User user = Get.find<AuthController>().user!;

      await repository.postSchedule(scheduleList, pet.chipId, user.jwt);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateSchedule(int index, Schedule schedule) {
    scheduleList[index] = schedule;
    update();
  }
}
