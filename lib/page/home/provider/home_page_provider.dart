

import 'package:flutter/widgets.dart';

class HomePageProvider extends ChangeNotifier {

  int _index = 0;
  int get index => _index;

  void refresh() {
    notifyListeners();
  }

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

}