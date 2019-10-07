import 'package:firebase_auth/firebase_auth.dart' as fbauth;
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';

class FirebaseAuthService implements AuthService {
  fbauth.FirebaseAuth _auth;

  FirebaseAuthService({@required fbauth.FirebaseAuth firebaseauth}) {
    this._auth = firebaseauth;
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final fbauth.AuthResult authResult =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapToUser(authResult.user);
    } catch (e) {
      if (e.code == 'ERROR_WEAK_PASSWORD') {
        throw AuthException('Password débil');
      } else if (e.code == 'ERROR_INVALID_EMAIL') {
        throw AuthException('Email inválido');
      } else if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        throw AuthException('Email en uso por otra cuenta');
      } else {
        throw AuthException('Error inesperado');
      }
    }
  }

  @override
  Stream<User> get onAuthStateChanged =>
      _auth.onAuthStateChanged.map(_mapToUser);

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final fbauth.AuthResult authResult = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return _mapToUser(authResult.user);
    } catch (e) {
      if (e.code == ('ERROR_WRONG_PASSWORD') || e.code == ('ERROR_USER_NOT_FOUND')) {
        throw AuthException('Credenciales inválidas');
      } else if (e.code == 'ERROR_INVALID_EMAIL') {
        throw AuthException('Email inválido');
      } else if (e.code == 'ERROR_USER_DISABLED') {
        throw AuthException('Usuario deshabilitado');
      } else {
        throw AuthException('Error inesperado');
      }
    }
  }

  User _mapToUser(fbauth.FirebaseUser fbUser) {
    return User(
        uid: fbUser.uid,
        displayName: fbUser.displayName,
        email: fbUser.email,
        photoUrl: fbUser.photoUrl);
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }
}
