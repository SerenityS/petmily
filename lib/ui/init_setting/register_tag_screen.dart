import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/controller/ble_controller.dart';
import 'package:petmily/ui/init_setting/delayed_animation.dart';

class RegisterTagScreen extends StatelessWidget {
  const RegisterTagScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        child: controller.tagString.isEmpty
                            ? Image.asset('assets/images/tag.png', width: 90.0)
                            : Image.asset('assets/images/check.png', width: 75.0));
                  })),
            ),
            GetX<BLEController>(builder: (controller) {
              if (controller.tagString.isEmpty) {
                return const DelayedAnimation(
                  delay: 500,
                  child: Text(
                    "태그를 등록해주세요.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: color),
                  ),
                );
              } else {
                return Column(
                  children: [
                    const DelayedAnimation(
                      delay: 500,
                      child: Text(
                        "태그를 발견했습니다.",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: color),
                      ),
                    ),
                    DelayedAnimation(
                      delay: 800,
                      child: Text(
                        controller.tagString.value.toUpperCase().substring(8, 24),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: color),
                      ),
                    ),
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
