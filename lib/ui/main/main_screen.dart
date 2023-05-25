import 'package:flutter/material.dart';
import 'package:petmily/ui/main/page/calendar_page.dart';
import 'package:petmily/ui/main/page/feeding_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const FeedingPage();
      case 1:
        return const CalendarPage();
      case 2:
        return const FeedingPage();
      default:
        return const FeedingPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.white,
        margin: const EdgeInsets.all(8.0),
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("홈"),
            selectedColor: Colors.purple.withOpacity(0.7),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.history),
            title: const Text("기록"),
            selectedColor: const Color(0xFF5C6BC0),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text("설정"),
            selectedColor: Colors.orange.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
