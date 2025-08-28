import 'package:flutter/material.dart';

class TabLastJobProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final List<String> categories = [
    "Full-Time",
    "Part-Time",
    "Remote",
    "Internship",
  ];

  void changeTab(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
