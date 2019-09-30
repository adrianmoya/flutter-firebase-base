import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';

class FirebaseAuthService implements AuthService {
  FirebaseAuth _auth;

  FirebaseAuthService({@required FirebaseAuth firebaseauth}) {
    this._auth = firebaseauth;
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _mapToUser(authResult.user);
  }

  @override
  Stream<User> get onAuthStateChanged =>
      _auth.onAuthStateChanged.map(_mapToUser);

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return _mapToUser(authResult.user);
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
