import 'package:flutter/foundation.dart';

class BaseViewModel extends ChangeNotifier{

  bool _busy = false;

  get busy => _busy;

  setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

}