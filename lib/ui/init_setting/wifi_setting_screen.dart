import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/controller/wifi_controller.dart';
import 'package:petmily/ui/init_setting/delayed_animation.dart';
import 'package:petmily/ui/init_setting/finish_setting_screen.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiSettingScreen extends StatelessWidget {
  const WifiSettingScreen({super.key});

  Widget wifiPwDialog(WifiController controller, String ssid) {
    return AlertDialog(
      title: Text(ssid),
      content: const TextField(
        autofocus: true,
        obscureText: true,
        decoration: InputDecoration(hintText: "비밀번호"),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('취소')),
        TextButton(
            onPressed: () async {
              Get.back();
              controller.isConnecting.value = true;
              await Future.delayed(const Duration(seconds: 5)).then((value) async {
                controller.isConnecting.value = false;
                controller.isConnected.value = true;
                await Future.delayed(const Duration(seconds: 5)).then((value) => Get.to(() => FinishSettingScreen()));
              });
            },
            child: const Text('연결')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    final WifiController _wifiController = Get.put(WifiController());

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
                  child: GetX<WifiController>(builder: (controller) {
                    return CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        radius: 60.0,
                        child: !controller.isConnected.value
                            ? Image.asset('assets/images/wifi.png', width: 95.0)
                            : Image.asset('assets/images/check.png', width: 75.0));
                  })),
            ),
            GetX<WifiController>(builder: (controller) {
              if (!controller.isConnected.value && !controller.isConnecting.value) {
                return DelayedAnimation(
                  delay: 500,
                  child: const Text(
                    "Wifi를 설정합니다.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: color),
                  ),
                );
              } else if (controller.isConnecting.value) {
                return DelayedAnimation(
                  delay: 500,
                  child: const Text(
                    "Wifi 연결 중입니다.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: color),
                  ),
                );
              } else {
                return DelayedAnimation(
                  delay: 500,
                  child: const Text(
                    "Wifi 연결 성공!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: color),
                  ),
                );
              }
            }),
            Expanded(
              child: GetX<WifiController>(builder: (controller) {
                if (!controller.isConnected.value && !controller.isConnecting.value) {
                  return DelayedAnimation(
                    delay: 1000,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.accessPoints.length,
                              itemBuilder: (context, idx) {
                                WiFiAccessPoint ap = controller.accessPoints[idx];

                                if (ap.frequency < 5000 && ap.ssid.isNotEmpty) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(context: context, builder: (context) => wifiPwDialog(controller, ap.ssid));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                ap.ssid,
                                                style: const TextStyle(fontSize: 20.0, color: color, fontWeight: FontWeight.w500),
                                              )),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            )
          ],
        ),
      )),
    );
  }
}
