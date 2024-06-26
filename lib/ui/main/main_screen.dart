import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/controller/history_controller.dart';
import 'package:petmily/ui/main/controller/main_screen_controller.dart';
import 'package:petmily/ui/main/page/history_page.dart';
import 'package:petmily/ui/main/page/feeding_page.dart';
import 'package:petmily/ui/main/page/schedule_page.dart';
import 'package:petmily/ui/main/page/setting_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainScreenController controller = Get.find<MainScreenController>();

  static final List<Widget> _buildPage = [FeedingPage(), SchedulePage(), const HistoryPage(), SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        body: _buildPage[controller.currentIndex.value],
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Colors.white,
          margin: const EdgeInsets.all(8.0),
          currentIndex: controller.currentIndex.value,
          onTap: (i) => controller.changeIndex(i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("홈"),
              selectedColor: Colors.purple.withOpacity(0.7),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.alarm),
              title: const Text("스케쥴"),
              selectedColor: Colors.pink,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.history),
              title: const Text("기록"),
              selectedColor: const Color(0xFF5C6BC0),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text("설정"),
              selectedColor: Colors.orange.withOpacity(0.7),
            ),
          ],
        ),
        floatingActionButton: controller.currentIndex.value == 2
            ? FloatingActionButton(
                onPressed: () async {
                  final HistoryController historyController = Get.find<HistoryController>();
                  await historyController.getHistory();
                  historyController.getHistoryByDay(historyController.selectedDay.value);
                },
                child: const Icon(Icons.refresh),
              )
            : null,
      );
    });
  }
}
