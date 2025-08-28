import 'package:flutter/material.dart';

class TabJobTypeProvider extends ChangeNotifier {
  int? _currentIndex;
  int? get currentIndex => _currentIndex;

  final List<String> jobTypes = [
    "Full-Time",
    "Part-Time",
    "Remote",
    "Internship",
  ];

  void changeTab(int index) {
    if (_currentIndex == index) {
      _currentIndex = null;
    } else {
      _currentIndex = index;
    }
    notifyListeners();
  }
}
