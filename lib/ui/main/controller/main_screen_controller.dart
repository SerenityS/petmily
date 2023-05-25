import 'package:get/get.dart';

class MainScreenController extends GetxController {
  final Rx<int> _currentIndex = 0.obs;
  get currentIndex => _currentIndex;

  void changeIndex(int index) {
    currentIndex(index);
  }
}
