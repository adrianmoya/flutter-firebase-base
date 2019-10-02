import 'package:flutter/widgets.dart';

@immutable
class User {
  const User({
    @required this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
  });

  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;

  @override
  String toString() {
    return '$uid - $email';
  }
}
