import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BLEController extends GetxController {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  bool _isScanning = false;

  ScanResult? device;
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;
  StreamSubscription<BluetoothDeviceState>? deviceStateSubscription;

  List<BluetoothService> bleServices = [];
  List<int> tagData = [];

  BluetoothCharacteristic? readChar;
  BluetoothCharacteristic? writeChar;
  StreamSubscription<List<int>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    initBle();
  }

  @override
  void onClose() {
    super.onClose();
    _subscription!.cancel();
    disconnect();
  }

  void initBle() {
    flutterBlue.isScanning.listen((isScanning) {
      _isScanning = isScanning;
    });
  }

  void scan() async {
    if (!_isScanning) {
      flutterBlue.startScan(timeout: const Duration(seconds: 4));
      flutterBlue.scanResults.listen((results) {
        for (ScanResult r in results) {
          print(r.device.name);
          print(r.advertisementData.localName);
          if (r.device.name == "Petmily") {
            device = r;
            Get.snackbar('Information', '${r.device.name} found! rssi: ${r.rssi}');
            flutterBlue.stopScan();
            return;
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
          Get.snackbar('Information', "Connection timeout");
        },
      ).then((value) {
        if (returnValue == null) {
          returnValue = Future.value(true);
          deviceState = BluetoothDeviceState.connected;
          deviceStateSubscription = device!.device.state.listen((s) {
            deviceState = s;
          });
          Get.snackbar('Information', "Connection success");
        }
      });
      return returnValue ?? Future.value(false);
    } else {
      Get.snackbar('Information', "Already connected");
      return Future.value(false);
    }
  }

  void disconnect() {
    readChar!.setNotifyValue(false);
    device!.device.disconnect();
    deviceState = BluetoothDeviceState.disconnected;
    Get.snackbar('Information', "Disconnected");
  }

  void findServices() async {
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
    _subscription = readChar!.value.listen((event) {
      if (event.isNotEmpty) {
        tagData.add(event[0]);

        if (tagData.length == 13) {
          String tagStr = "";

          for (int tagInt in tagData) {
            tagStr += tagInt.toRadixString(16).padLeft(2, '0');
          }
          print("tagStr: ${tagStr.toUpperCase().substring(8, 24)}");
          tagData.clear();
        }
      }
    });
  }

  void disableGetTag() async {
    await readChar!.setNotifyValue(false);
    _subscription!.cancel();
  }

  void write() async {
    if (deviceState == BluetoothDeviceState.connected && writeChar != null) {
      writeChar!.write('{"ssid": "jins4218", "pw": "2"}'.codeUnits);
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

  // void connect(ScanResult r) async {
  //   r.device.connect(autoConnect: false).then((data) async {
  //     bleServices.clear();
  //     List<BluetoothService> bleService = await r.device.discoverServices();
  //     for (BluetoothService service in bleService) {
  //       for (BluetoothCharacteristic c in service.characteristics) {
  //         if (c.properties.write) {
  //           print('\tcharacteristic UUID: ${c.uuid.toString()}');
  //           print('\t\twrite: ${c.properties.write}');
  //           print('\t\tread: ${c.properties.read}');
  //           print('\t\tnotify: ${c.properties.notify}');
  //           print('\t\tisNotifying: ${c.isNotifying}');
  //           print('\t\twriteWithoutResponse: ${c.properties.writeWithoutResponse}');
  //           print('\t\tindicate: ${c.properties.indicate}');
  //           c.write('{"ssid": "jins4218", "pw": "2"}'.codeUnits);
  //         }
  //       }
  //     }
  //   });
  // }
}
