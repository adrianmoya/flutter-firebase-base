import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';

class LoginModel extends ChangeNotifier {
  LoginModel(AuthService this._authService);

  final AuthService _authService;
  bool _busy;
  String _email;
  String _password;
  String _lastError;

  get busy => this._busy;

  void loginUser() async {
    _busy = true;
    notifyListeners();
    await _authService.signInWithEmailAndPassword(_email, _password).catchError((e) {
      _lastError = e.cause;
    });
    _busy = false;
    notifyListeners();
  }
}
