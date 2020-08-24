import 'package:flutter/cupertino.dart';

class ShoesListProvider with ChangeNotifier {
  bool _isFilterOpen = false;

  bool get isDark => !_isFilterOpen;
  bool get isFilterOpen => _isFilterOpen;

  set isFilterOpen(bool value) {
    _isFilterOpen = value;
    notifyListeners();
  }
}
