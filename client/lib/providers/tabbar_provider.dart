import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/user.dart';

class TabBarProvider extends ChangeNotifier {
 

  TabController? _controller;


  TabController? get controller => _controller;

 

   void setTabController(TabController? controller) {
    _controller = controller;
    notifyListeners();
  }


  
}
