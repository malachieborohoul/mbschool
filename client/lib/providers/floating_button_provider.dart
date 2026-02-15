import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class FloatingButtonProvider extends ChangeNotifier {


  bool _isClicked = false;
  bool get isClicked => _isClicked;

  void setIsClicked(bool isClick) {
    _isClicked = isClick;
    notifyListeners();
  }
}
