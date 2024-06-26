import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/data/model/history.dart';
import 'package:petmily/data/model/user.dart';
import 'package:petmily/data/repository/history_repository.dart';
import 'package:petmily/service/secure_storage_service.dart';

class HistoryController extends GetxController {
  final HistoryRepository repository;
  HistoryController({required this.repository});

  final storage = Get.find<SecureStorageService>();

  final RxList<History> _historyList = <History>[].obs;

  final RxList<History> _selectedHistoryList = <History>[].obs;
  RxList<History> get selectedHistoryList => _selectedHistoryList;

  final Rx<int> _todayConsume = 0.obs;
  Rx<int> get todayConsume => _todayConsume;

  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  @override
  void onInit() async {
    super.onInit();
    await getHistory();
    getHistoryByDay(focusedDay.value);
    calculateTodayConsume();
  }

  void calculateTodayConsume() {
    _todayConsume.value = 0;
    for (var history in _historyList) {
      if (history.date.day == DateTime.now().day) {
        todayConsume.value += history.consume;
      }
    }
  }

  Future<void> getHistory() async {
    try {
      User? user = await storage.getUser();
      final response = await repository.getHistory(user!.jwt);
      _historyList.assignAll(jsonDecode(response).map<History>((json) => History.fromMap(json)).toList());
      calculateTodayConsume();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getHistoryByDay(DateTime day) {
    _selectedHistoryList.assignAll(_historyList.where((history) => history.date.day == day.day).toList());
  }
}
