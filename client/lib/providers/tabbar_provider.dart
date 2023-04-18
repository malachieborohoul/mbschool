
import 'package:flutter/material.dart';

class TabBarProvider extends ChangeNotifier {
 

  TabController? _controller;


  TabController? get controller => _controller;

 

   void setTabController(TabController? controller) {
    _controller = controller;
    notifyListeners();
  }


  
}
