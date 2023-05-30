import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/controller/ble_controller.dart';
import 'package:petmily/ui/init_setting/delayed_animation.dart';

class FindDeviceScreen extends StatelessWidget {
  const FindDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BLEController());

    const color = Colors.white;

    return Scaffold(
      backgroundColor: const Color(0xFF8185E2),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            AvatarGlow(
              endRadius: 90,
              duration: const Duration(seconds: 2),
              glowColor: Colors.white24,
              repeat: true,
              repeatPauseDuration: const Duration(seconds: 2),
              startDelay: const Duration(seconds: 1),
              child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: GetX<BLEController>(builder: (controller) {
                    return CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        radius: 60.0,
                        child: !controller.isFound.value
                            ? Image.asset('assets/images/pet-feeder.png', width: 80.0)
                            : Image.asset('assets/images/check.png', width: 75.0));
                  })),
            ),
            GetX<BLEController>(builder: (controller) {
              if (controller.isScanning.value && !controller.isFound.value) {
                return const DelayedAnimation(
                  delay: 500,
                  child: Text(
                    "기기를 검색하는 중입니다.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: color),
                  ),
                );
              } else if (controller.isFound.value) {
                return const Column(
                  children: [
                    DelayedAnimation(
                      delay: 500,
                      child: Text(
                        "기기를 찾았습니다.",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: color),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    const Text(
                      "기기를 찾지 못했어요.",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: color),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    SizedBox(
                        width: 300.0,
                        height: 60.0,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: color),
                            onPressed: () {
                              controller.scan();
                            },
                            child: const Text(
                              "다시 시도하기",
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
                            )))
                  ],
                );
              }
            }),
          ],
        ),
      )),
    );
  }
}
