import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiController extends GetxController {
  RxList accessPoints = [].obs;
  StreamSubscription<List<WiFiAccessPoint>>? subscription;
  bool shouldCheckCan = true;
  RxBool isConnecting = false.obs;
  RxBool isConnected = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await startScan();
  }

  Future<void> startScan() async {
    if (shouldCheckCan) {
      // check if can-startScan
      final can = await WiFiScan.instance.canStartScan();
      // if can-not, then show error
      if (can != CanStartScan.yes) {
        debugPrint("Cannot start scan (reason '${can.toString()}')");
        return;
      }
    }

    // call startScan API
    await WiFiScan.instance.startScan().then((_) => _startListeningToScanResults());
  }

  Future<bool> _canGetScannedResults() async {
    if (shouldCheckCan) {
      final can = await WiFiScan.instance.canGetScannedResults();

      if (can != CanGetScannedResults.yes) {
        debugPrint("Cannot get scanned results: $can");
        accessPoints = [].obs;
        return false;
      }
    }
    return true;
  }

  Future<void> _startListeningToScanResults() async {
    if (await _canGetScannedResults()) {
      subscription = WiFiScan.instance.onScannedResultsAvailable.listen((result) => accessPoints.value = result);

      for (WiFiAccessPoint ap in accessPoints) {
        if (ap.frequency > 5000) {
          accessPoints.remove(ap);
        }
      }
    }
  }
}
