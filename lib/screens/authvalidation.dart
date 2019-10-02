import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/screens/home.dart';
import 'package:flutter_firebase_base/screens/login.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of(context);
    return StreamBuilder(
      stream: authService.onAuthStateChanged,
      initialData: null,
      builder: (context, snapshot) {
        User currentUser = snapshot.data;
        print('currentUser: $currentUser');
        if (currentUser == null) {
          return LoginScreen();
        }
        return HomeScreen();
      },
    );
  }
}
