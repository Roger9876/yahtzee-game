import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:math';


class Dice extends ChangeNotifier {
  final List<int?> _values;
  final List<bool> _held;
  int rollCounter = 0;

  Dice(int numDice)
      : _values = List<int?>.filled(numDice, null),
        _held = List<bool>.filled(numDice, false);

  List<int> get values => List<int>.unmodifiable(_values.whereNotNull());

  int? operator [](int index) => _values[index];

  bool isHeld(int index) => _held[index];

  void clear() {
    for (var i = 0; i < _values.length; i++) {
      _values[i] = null;
      _held[i] = false;
      rollCounter = 0;
      notifyListeners();
    }
  }

  void roll() {
    for (var i = 0; i < _values.length; i++) {
      if (!_held[i]) {
        _values[i] = Random().nextInt(6) + 1;
      }
    }
    rollCounter++;
    notifyListeners();
  }

  void toggleHold(int index) {
    _held[index] = !_held[index];
    notifyListeners();
  }
}
