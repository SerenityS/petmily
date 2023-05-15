import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/controller/ble_controller.dart';

class BLETestScreen extends StatefulWidget {
  const BLETestScreen({super.key});

  @override
  State<BLETestScreen> createState() => _BLETestScreenState();
}

class _BLETestScreenState extends State<BLETestScreen> {
  final BLEController _bleController = Get.put(BLEController());
  final TextEditingController _bleMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _bleMessageController.text = '{"ssid": "U+Net8640", "pw": "1000000312"}';

    return Scaffold(
      appBar: AppBar(title: const Text("펫밀리")),
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              _bleController.scan();
            },
            child: const Text("Scan")),
        ElevatedButton(
            onPressed: () {
              _bleController.connect();
            },
            child: const Text("Connect")),
        ElevatedButton(
            onPressed: () {
              _bleController.findServices();
            },
            child: const Text("Find Services")),
        ElevatedButton(
            onPressed: () {
              _bleController.disconnect();
            },
            child: const Text("Disconnect")),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _bleMessageController,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _bleController.write(_bleMessageController.text);
                      },
                      child: const Text("Write")),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              _bleController.enableGetTag();
            },
            child: const Text("Enable Tag Notify")),
        ElevatedButton(
            onPressed: () {
              _bleController.disableNotify();
            },
            child: const Text("Disable Tag Notify")),
        ElevatedButton(
            onPressed: () {
              _bleController.enableGetWifiStatus();
            },
            child: const Text("Enable Wifi Notify")),
        ElevatedButton(
            onPressed: () {
              _bleController.clear();
            },
            child: const Text("Clear GATT Cache")),
      ]),
    );
  }
}
