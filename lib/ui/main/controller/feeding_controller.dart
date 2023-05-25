import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedingPageController extends GetxController {
  Rx<double> panelHeightOpen = 0.0.obs;
  Rx<double> panelHeight = 95.0.obs;
  final double panelHeightClosed = 95.0;

  Rx<double> sliderValue = 0.0.obs;
  Rx<Color> feedColor = Colors.grey[100]!.obs;

  final BorderRadiusGeometry radius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
}
