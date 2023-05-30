import 'dart:convert';

import 'package:petmily/data/model/schedule.dart';
import 'package:petmily/data/provider/api.dart';

class ScheduleRepository {
  ScheduleRepository({required this.apiClient});

  final MyApiClient apiClient;

  getSchedule(String chipId, String token) async {
    return await apiClient.get(ApiType.schedule, queryParameter: {"chip_id": chipId}, token: token);
  }

  postSchedule(List<Schedule> scheduleList, String chipId, String token) async {
    return await apiClient.post(ApiType.schedule,
        body: jsonEncode({"chip_id": chipId, "schedule_json": scheduleList.map((e) => e.toJson()).toList().toString()}), token: token);
  }
}
