import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/controller/auth_controller.dart';
import 'package:petmily/ui/ble_test_screen.dart';
import 'package:petmily/ui/main/widget/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("펫밀리"),
        actions: [
          IconButton(
              onPressed: () {
                Get.find<AuthController>().logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              Get.to(() => const BLETestScreen());
            },
            child: const Text("BLE Test Screen"))
      ]),
      bottomNavigationBar: BottomNavBar(key: key),
    );
  }
}
