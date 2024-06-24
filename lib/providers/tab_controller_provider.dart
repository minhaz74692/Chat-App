import 'package:flutter/material.dart';

class TabControllerProvider extends ChangeNotifier {
 

  //States for Persistant Bottom Navigation Bar
  int _navbarActiveIndex = 0;
  int get navbarActiveIndex => _navbarActiveIndex;
  setNavIndex(int index) {
    _navbarActiveIndex = index;
    debugPrint('index: $index');
    notifyListeners();
  }

  bool _hideNavBar = false;
  bool get hideNavBar => _hideNavBar;
  setHideNavBar(bool status) {
    _hideNavBar = status;
    notifyListeners();
  }

  

  
}
