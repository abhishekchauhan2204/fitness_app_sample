import 'package:flutter/material.dart';

class WarmupState with ChangeNotifier {
  bool _isCompleted = false;

  bool get isCompleted => _isCompleted;

  void completeWarmup() {
    _isCompleted = true;
    notifyListeners();
  }

  void resetWarmup() {
    _isCompleted = false;
    notifyListeners();
  }
}


class WarmupStateHiit with ChangeNotifier {
  bool _isCompleted = false;

  bool get isCompleted => _isCompleted;

  void completeFatburner() {
    _isCompleted = true;
    notifyListeners();
  }

  void resetFatburner() {
    _isCompleted = false;
    notifyListeners();
  }
}
