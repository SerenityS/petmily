import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/ui/ble_test_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("펫밀리")),
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              Get.to(() => const BLETestScreen());
            },
            child: const Text("BLE Test Screen"))
      ]),
    );
  }
}
