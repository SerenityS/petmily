import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:intl/intl.dart';
import 'package:petmily/controller/petmily_controller.dart';
import 'package:petmily/data/model/feeding_schedule.dart';
import 'package:petmily/data/model/pet.dart';
import 'package:petmily/ui/main/controller/schedule_controller.dart';
import 'package:petmily/ui/main/widget/flutter_time_picker_spinner.dart';
import 'package:petmily/util/consume_calc.dart';

late ConsumeCalc consumeCalc;

class SchedulePage extends GetView<SchedulePageController> {
  SchedulePage({super.key});

  final PetmilyController _petmilyController = Get.find<PetmilyController>();

  @override
  Widget build(BuildContext context) {
    Pet pet = _petmilyController.petList[0];
    consumeCalc = ConsumeCalc(pet: pet);

    void showScheduleModal(BuildContext context, {required FeedingSchedule schedule, required int index}) {
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          elevation: 0.0,
          isScrollControlled: true,
          builder: (context) {
            return ScheduleEditModal(schedule.copyWith(), index: index);
          });
    }

    return Theme(
      data: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink)),
      child: SafeArea(
        child: Obx(() {
          int totalAmount = controller.scheduleList.fold(0, (previousValue, element) {
            if (element.isEnable) {
              return previousValue += element.amount;
            } else {
              return previousValue;
            }
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Text("총 ${totalAmount}g 급식 예약", style: const TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 20.0),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.pink)),
                          onPressed: () {
                            controller.scheduleList.add(FeedingSchedule(isEnable: true, date: DateTime.now(), amount: 10));
                            showScheduleModal(context, schedule: controller.scheduleList.last, index: controller.scheduleList.length - 1);
                          },
                          child: const Text("+ 급식 스케쥴", style: TextStyle(fontSize: 18.0)))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("총 ${controller.scheduleList.length}끼 급식",
                    style: const TextStyle(color: Colors.grey, fontSize: 18.0, fontWeight: FontWeight.w500)),
              ),
              ListView.separated(
                separatorBuilder: (context, index) => Divider(height: 1.5, thickness: 1.5, color: Colors.grey[200]!),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.scheduleList.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showScheduleModal(context, schedule: controller.scheduleList[i], index: i);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "시간",
                                      style: TextStyle(color: Colors.grey, fontSize: 18.0, fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      DateFormat.jm('ko_KR').format(controller.scheduleList[i].date),
                                      style: TextStyle(
                                          color: controller.scheduleList[i].isEnable ? Colors.black : Colors.grey,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "급식량",
                                      style: TextStyle(color: Colors.grey, fontSize: 18.0, fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${controller.scheduleList[i].amount}g",
                                      style: TextStyle(
                                          color: controller.scheduleList[i].isEnable ? Colors.black : Colors.grey,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Switch(
                                      onChanged: (value) {
                                        controller.updateSchedule(i, controller.scheduleList[i].copyWith(isEnable: value));
                                      },
                                      value: controller.scheduleList[i].isEnable))
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Expanded(
                  child: Container(
                color: Colors.grey[100],
              ))
            ],
          );
        }),
      ),
    );
  }
}

class ScheduleEditModal extends StatefulWidget {
  const ScheduleEditModal(this.schedule, {super.key, required this.index});

  final int index;
  final FeedingSchedule schedule;

  @override
  State<ScheduleEditModal> createState() => _ScheduleEditModalState();
}

class _ScheduleEditModalState extends State<ScheduleEditModal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.alarm, color: Colors.red, size: 25.0),
              const SizedBox(width: 5.0),
              const Text("시간", style: TextStyle(fontSize: 20.0)),
              const SizedBox(width: 10.0),
              Text(
                DateFormat.jm('ko_KR').format(widget.schedule.date),
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[100],
          child: TimePickerSpinner(
            is24HourMode: false,
            normalTextStyle: const TextStyle(fontSize: 24),
            highlightedTextStyle: const TextStyle(color: Colors.pink, fontSize: 24),
            spacing: 20,
            itemHeight: 60,
            isForce2Digits: true,
            time: widget.schedule.date,
            onTimeChange: (newTime) {
              setState(() {
                widget.schedule.date = newTime;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.pets, color: Colors.amber, size: 25.0),
              const SizedBox(width: 5.0),
              const Text("급식량", style: TextStyle(fontSize: 20.0)),
              const SizedBox(width: 10.0),
              Text(
                "${widget.schedule.amount}g",
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        HorizontalPicker(
          height: MediaQuery.of(context).size.height * 0.1,
          minValue: 10,
          maxValue: (consumeCalc.sufficientConsume / 10).round() * 10,
          divisions: (consumeCalc.sufficientConsume / 10).round() * 10 ~/ 10 - 1,
          suffix: " g",
          showCursor: true,
          initialPosition: InitialPosition.start,
          backgroundColor: Colors.grey[100]!,
          activeItemTextColor: Colors.amber,
          passiveItemsTextColor: Colors.grey,
          onChanged: (value) {
            setState(() {
              widget.schedule.amount = value.toInt();
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: FilledButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.withOpacity(0.3),
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () {
                      Get.find<SchedulePageController>().scheduleList.removeAt(widget.index);
                      Get.back();
                    },
                    child: const Text(
                      "삭제",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                const Spacer(flex: 1),
                Expanded(
                  flex: 6,
                  child: FilledButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.withOpacity(0.7),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () {
                      Get.find<SchedulePageController>().updateSchedule(widget.index, widget.schedule);
                      Get.back();
                    },
                    child: const Text(
                      "확인",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
