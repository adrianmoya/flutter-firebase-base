import 'package:flutter_firebase_base/screens/viewmodels/base_view_model.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(this._authService);

  final AuthService _authService;

  LoginViewMode mode = LoginViewMode.LOGIN;

  String email = '';
  String password = '';
  String lastError;

  String errorEmail = '';
  String errorPassword = '';

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

  get buttonLabel {
    switch (mode) {
      case LoginViewMode.LOGIN:
        return "Entrar";
      case LoginViewMode.REGISTER:
        return "Crear";
    }
  }

  get title {
    switch (mode) {
      case LoginViewMode.LOGIN:
        return "Acceder";
      case LoginViewMode.REGISTER:
        return "Registro";
    }
  }

  get linkLabel {
    switch (mode) {
      case LoginViewMode.LOGIN:
        return "Registro";
      case LoginViewMode.REGISTER:
        return "Acceso";
    }
  }

  void changeMode() {
    mode == LoginViewMode.LOGIN
        ? mode = LoginViewMode.REGISTER
        : mode = LoginViewMode.LOGIN;
    notifyListeners();
  }

  void executeAction() {
    switch (mode) {
      case LoginViewMode.LOGIN:
        _loginUser();
        break;
      case LoginViewMode.REGISTER:
        _register();
        break;
    }
  }

  void _loginUser() async {
    setBusy(true);
    print('Loging user $email with pass $password');
    await _authService
        .signInWithEmailAndPassword(email, password)
        .catchError((e) {
      lastError = e.cause;
    });
    setBusy(false);
  }

  void _register() async {
    setBusy(true);
    print('Registering user $email with pass $password');
    await _authService
        .createUserWithEmailAndPassword(email, password)
        .catchError((e) {
      lastError = e.cause;
    });
    setBusy(false);
  }
}

enum LoginViewMode { LOGIN, REGISTER }
