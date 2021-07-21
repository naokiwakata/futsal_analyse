import 'package:flutter/material.dart';
import 'package:test_build/repository/auth_repository.dart';

class DummyTopModel extends ChangeNotifier {
  int currentIndex = 0;
  final authRepository = AuthRepository.instance;

  void onTabTapped(int index) async {
    currentIndex = index;

    notifyListeners();
  }
}
