import 'package:flutter/material.dart';

class TabJobDetailProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final List<String> detailTabs = ['Overview', 'About Company', 'Reviews'];

  void changeTab(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void resetTab() {
    _currentIndex = 0;
    notifyListeners();
  }
}
