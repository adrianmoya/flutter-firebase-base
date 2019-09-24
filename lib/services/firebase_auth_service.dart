import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapToUser(authResult.user);
    } on PlatformException catch (pe) {
      if (pe.code == 'ERROR_WEAK_PASSWORD') {
        print('Password débil');
      }
      print(pe.toString());
    }
    return null;
  }

  @override
  Stream<User> get onAuthStateChanged => _auth.onAuthStateChanged.map(_mapToUser);

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return null;
  }

  User _mapToUser(FirebaseUser fbUser) {
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
