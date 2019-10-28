import 'package:flutter/material.dart';
import 'package:flutter_firebase_base/provider_setup.dart';
import 'package:flutter_firebase_base/screens/auth_validation.dart';
import 'package:provider/provider.dart';
import 'screens/views/login.dart';
import 'screens/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Firebase Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthValidation(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen()
        },
      ),
    );
  }
}
