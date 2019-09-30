import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/screens/home.dart';
import 'package:flutter_firebase_base/screens/login.dart';
import 'package:provider/provider.dart';

class AuthValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of(context);
    if(currentUser == null) {
      return LoginScreen();
    }
    return HomeScreen();
  }
  
}