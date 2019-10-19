import 'package:flutter_firebase_base/model/User.dart';

class AuthState {
  User currentUser;

  @override
  String toString() {
    return 'User: $currentUser';
  }
}