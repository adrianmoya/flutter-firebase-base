import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';
import 'package:flutter_firebase_base/services/firebase_auth_service.dart';
import 'package:flutter_firebase_base/state/auth_state.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildCloneableWidget> independentServices = [
  Provider<FirebaseAuth>.value(value: FirebaseAuth.instance),
  Provider<AuthState>.value(value: AuthState())
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<FirebaseAuth, AuthService>(
      builder: (context, fbauth, authService) =>
          FirebaseAuthService(firebaseauth: fbauth)),
];

List<SingleChildCloneableWidget> uiConsumableProviders = [];
