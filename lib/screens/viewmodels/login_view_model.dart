import 'package:flutter_firebase_base/screens/viewmodels/base_view_model.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(this._authService){
    print('Created login view model');
  }

  final AuthService _authService;
  String email = '';
  String password = '';
  String lastError;

  String errorEmail = '';
  String errorPassword = '';

  void loginUser() async {
    setBusy(true);
    print('Loging user $email with pass $password');
    await _authService
        .signInWithEmailAndPassword(email, password)
        .catchError((e) {
      lastError = e.cause;
    });
    setBusy(false);
  }

  void clearForm() {
    print('Clearing form');
    email = '';
    password = '';
    lastError = '';
    notifyListeners();
  }

  void clearErrors() {
    print('Clearing errors');
    errorEmail = '';
    errorPassword = '';
    lastError = '';
  }

  String validateEmail(String email) {
    return email.isEmpty ? "El email no puede estar vacío" : null;
  }

  String validatePassword(String password) {
    return password.isEmpty ? "La contraseña no puede estar vacía" : null;
  }
}
