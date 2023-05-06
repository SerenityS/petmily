import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:petmily/ui/init_setting/wifi_setting_screen.dart';

class BLEController extends GetxController {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  RxBool isScanning = false.obs;
  RxBool isFound = false.obs;

  ScanResult? device;
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;
  StreamSubscription<BluetoothDeviceState>? deviceStateSubscription;

  List<BluetoothService> bleServices = [];
  List<int> tagData = [];
  RxString tagString = "".obs;

  BluetoothCharacteristic? readChar;
  BluetoothCharacteristic? writeChar;
  StreamSubscription<List<int>>? _subscription;

  @override
  void onInit() async {
    super.onInit();
    initBle();
    await scan();
  }

  @override
  void onClose() {
    super.onClose();
    _subscription!.cancel();
    disconnect();
  }

  void initBle() {
    flutterBlue.isScanning.listen((val) {
      isScanning.value = val;
    });
  }

  Future<void> scan() async {
    if (!isScanning.value) {
      flutterBlue.startScan(timeout: const Duration(seconds: 10));
      flutterBlue.scanResults.listen((results) {
        for (ScanResult r in results) {
          print(r.device.name);
          if (r.device.name == "Petmily") {
            device = r;
            isFound.value = true;
            print('${r.device.name} found! rssi: ${r.rssi}');
            flutterBlue.stopScan();
            //connect();
          }
        }
      });
    } else {
      flutterBlue.stopScan();
    }
  }

  Future<bool> connect() async {
    Future<bool>? returnValue;

    if (deviceState == BluetoothDeviceState.disconnected) {
      device!.device.connect(autoConnect: false).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          returnValue = Future.value(false);
          debugPrint("Connection timeout");
        },
      ).then((value) async {
        if (returnValue == null) {
          returnValue = Future.value(true);
          deviceState = BluetoothDeviceState.connected;
          deviceStateSubscription = device!.device.state.listen((s) {
            deviceState = s;
          });
          //await findServices().then((_) => enableGetTag());
          debugPrint("Connection success");

          //await Future.delayed(const Duration(seconds: 3))
          //.then((_) => Get.to(() => const RegisterTagScreen(), transition: Transition.fadeIn));
        }
      });
      return returnValue ?? Future.value(false);
    } else {
      debugPrint("Already connected");
      return Future.value(false);
    }
  }

  void disconnect() {
    readChar!.setNotifyValue(false);
    device!.device.disconnect();
    deviceState = BluetoothDeviceState.disconnected;
    Get.snackbar('Information', "Disconnected");
  }

  Future<void> findServices() async {
    bleServices.clear();
    bleServices = await device!.device.discoverServices();

    for (BluetoothService service in bleServices) {
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.uuid == Guid("11e787ed-7900-4594-9180-4699986ad978")) {
          debugPrint("Find Write Charateristic");
          writeChar = c;
        }

        if (c.uuid == Guid("fe82f81a-ca0c-47d1-ac7d-b35901796fad")) {
          debugPrint("Find Read Charateristic");
          readChar = c;
        }
      }
    }
  }

  void enableGetTag() async {
    tagData.clear();
    await readChar!.setNotifyValue(true);
    _subscription = readChar!.value.listen((event) async {
      if (event.isNotEmpty) {
        tagData.add(event[0]);

        if (tagData.length == 13) {
          for (int tagInt in tagData) {
            tagString.value += tagInt.toRadixString(16).padLeft(2, '0');
          }
          print("tagStr: ${tagString.value.toUpperCase().substring(8, 24)}");
          tagData.clear();

          await Future.delayed(const Duration(seconds: 3))
              .then((_) => Get.to(() => const WifiSettingScreen(), transition: Transition.fadeIn));
        }
      }
    });
  }

  void disableGetTag() async {
    await readChar!.setNotifyValue(false);
    _subscription!.cancel();
  }

  void write(String json) async {
    if (deviceState == BluetoothDeviceState.connected && writeChar != null) {
      writeChar!.write(json.codeUnits);
    }
  }

  void read() async {
    if (deviceState == BluetoothDeviceState.connected && readChar != null) {
      readChar!.read();
    }
  }

  void clear() {
    device!.device.clearGattCache();
  }
}
