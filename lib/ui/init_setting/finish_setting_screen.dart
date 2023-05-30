import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/binding/main_screen_binding.dart';
import 'package:petmily/ui/init_setting/delayed_animation.dart';
import 'package:petmily/ui/main/main_screen.dart';

class FinishSettingScreen extends StatefulWidget {
  const FinishSettingScreen({super.key});

  @override
  FinishSettingScreenState createState() => FinishSettingScreenState();
}

class FinishSettingScreenState extends State<FinishSettingScreen> with SingleTickerProviderStateMixin {
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
                  "설정이 완료되었습니다.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0, color: color),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              DelayedAnimation(
                delay: delayedAmount + 1500,
                child: const Text(
                  "Petmily와 함께 행복한 시간되세요!",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              DelayedAnimation(
                  delay: delayedAmount + 2000,
                  child: SizedBox(
                      width: 300.0,
                      height: 60.0,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: color),
                          onPressed: () {
                            Get.offAll(() => MainScreen(), binding: MainScreenBinding(), transition: Transition.fadeIn);
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
