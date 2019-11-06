import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/screens/home.dart';
import 'package:flutter_firebase_base/screens/views/auth_view.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of(context);
    return StreamBuilder(
      stream: _authService.onAuthStateChanged,
      initialData: null,
      builder: (context, snapshot) {
        User currentUser = snapshot.data;
        if (currentUser == null) {
          return AuthView();
        }
        return Provider<User>.value(
          value: currentUser,
          child: HomeScreen(),
        );
      },
    );
  }
}
