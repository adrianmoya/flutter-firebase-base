import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> register(String email, String password) async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    return User(user);
  }
}

class User {
  String name;

  User(FirebaseUser fbuser) {
    this.name = fbuser.displayName;
  }
}
