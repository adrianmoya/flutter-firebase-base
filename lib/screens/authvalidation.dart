import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/screens/home.dart';
import 'package:flutter_firebase_base/screens/views/login.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';
import 'package:flutter_firebase_base/state/auth_state.dart';
import 'package:provider/provider.dart';

class AuthValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of(context);
    AuthService authService = Provider.of(context);
    return StreamBuilder(
      stream: authService.onAuthStateChanged,
      initialData: null,
      builder: (context, snapshot) {
        User currentUser = snapshot.data;
        authState.currentUser = currentUser;
        print(authState.toString());
        if (currentUser == null) {
          return LoginScreen();
        }
        return HomeScreen();
      },
    );
  }
}
