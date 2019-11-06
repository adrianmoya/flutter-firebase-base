import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_base/screens/viewmodels/base_view_model.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';

class AuthViewModel extends BaseViewModel {
  AuthViewModel(this._authService);

  final AuthService _authService;

  LoginViewMode mode = LoginViewMode.LOGIN;

  String email = '';
  String password = '';
  String errorEmail = '';
  String errorPassword = '';

  void clearForm() {
    print('Clearing form');
    email = '';
    password = '';
    notifyListeners();
  }

  void clearErrors() {
    print('Clearing errors');
    errorEmail = '';
    errorPassword = '';
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

  void executeAction(BuildContext context) {
    switch (mode) {
      case LoginViewMode.LOGIN:
        _loginUser(context);
        break;
      case LoginViewMode.REGISTER:
        _register(context);
        break;
    }
  }

  void _loginUser(BuildContext context) async {
    setBusy(true);
    await _authService
        .signInWithEmailAndPassword(email, password)
        .catchError((e) {
      print('Error logeando usuario: $e');
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.cause)));
      setBusy(false);
    });
  }

  void _register(BuildContext context) async {
    setBusy(true);
    await _authService
        .createUserWithEmailAndPassword(email, password)
        .catchError((e) {
      print('Error creando usuario: $e');
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.cause)));
    });
    setBusy(false);
  }
}

enum LoginViewMode { LOGIN, REGISTER }
