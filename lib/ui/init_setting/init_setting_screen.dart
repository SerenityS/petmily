import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/ui/init_setting/delayed_animation.dart';
import 'package:petmily/ui/init_setting/find_device_screen.dart';

class InitSettingScreen extends StatefulWidget {
  @override
  _InitSettingScreenState createState() => _InitSettingScreenState();
}

class _InitSettingScreenState extends State<InitSettingScreen> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;

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
                    child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        radius: 60.0,
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 75.0,
                        ))),
              ),
              DelayedAnimation(
                delay: delayedAmount + 1000,
                child: const Text(
                  "안녕하세요!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0, color: color),
                ),
              ),
              DelayedAnimation(
                delay: delayedAmount + 1500,
                child: const Text(
                  "Petmily 입니다.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0, color: color),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              DelayedAnimation(
                delay: delayedAmount + 2000,
                child: const Text(
                  "사용에 앞서 초기 설정을 진행합니다!",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              DelayedAnimation(
                  delay: delayedAmount + 2500,
                  child: SizedBox(
                      width: 300.0,
                      height: 60.0,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: color),
                          onPressed: () {
                            Get.to(() => const FindDeviceScreen(), transition: Transition.fade);
                          },
                          child: const Text(
                            "시작하기",
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
                          )))),
            ],
          ),
        ),
      ),
    );
  }
}
