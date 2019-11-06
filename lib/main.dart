import 'package:flutter/material.dart';
import 'package:flutter_firebase_base/provider_setup.dart';
import 'package:flutter_firebase_base/screens/auth_validation.dart';
import 'package:flutter_firebase_base/screens/views/auth_view.dart';
import 'package:provider/provider.dart';

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
          '/auth': (context) => AuthView(),
        },
      ),
    );
  }
}
