import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class NumberEntryProvider extends ChangeNotifier {
  int? _count;

  int get count => _count!;

  void setCount(int num) {
    _count = num;
    notifyListeners();
  }
}
