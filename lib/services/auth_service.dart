import 'package:flutter_firebase_base/model/User.dart';

abstract class AuthService {
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<User> signInWithEmailAndPassword(String email, String password);
  Stream<User> get onAuthStateChanged;
  Future<void> signOut();
}

class AuthException implements Exception {
  String cause;
  AuthException(this.cause);
}