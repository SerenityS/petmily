import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petmily/controller/history_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return TableCalendar(
                locale: 'ko_KR',
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                focusedDay: controller.focusedDay.value,
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2033, 12, 31),
                onDaySelected: (selectedDay, focusedDay) {
                  controller.selectedDay.value = selectedDay;
                  controller.focusedDay.value = focusedDay;

                  controller.getHistoryByDay(selectedDay);
                },
                selectedDayPredicate: (day) {
                  return isSameDay(controller.selectedDay.value, day);
                },
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                  defaultTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  disabledTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  selectedTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  weekendTextStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  weekendStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextFormatter: (date, locale) => DateFormat('MMM', 'ko').format(date),
                  titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Divider(
              height: 8.0,
              thickness: 2.0,
              color: Colors.grey[300]!,
            ),
          ),
          Obx(() {
            return Expanded(
              child: Container(
                color: Colors.grey[100],
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.selectedHistoryList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "시간",
                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    DateFormat.jm('ko_KR').format(controller.selectedHistoryList[index].date),
                                    style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "섭취량",
                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    "${controller.selectedHistoryList[index].consume}g",
                                    style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "섭취 칼로리",
                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    "${(controller.selectedHistoryList[index].consume * 3).toInt()}kcal",
                                    style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: Colors.grey[200]!,
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
