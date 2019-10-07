import 'package:flutter/material.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';
import 'package:flutter_firebase_base/shared/auth_form.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acceso'),
      ),
      body: new _LoginBody(),
    );
  }
}

class _LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _loginUser(String email, String password) async {
      final AuthService _auth = Provider.of(context);
      try {
        User user = await _auth.signInWithEmailAndPassword(email, password);
        print('Successfuly registered user $user');
      } on AuthException catch (e) {
        final snackBar = SnackBar(content: Text(e.cause));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            AuthForm(mode: AuthFormMode.login, handler: _loginUser),
            FlatButton(
              child: Text('Registro', style: TextStyle(fontSize: 22)),
              onPressed: () => Navigator.pushNamed(context, '/register'),
            )
          ],
        ),
      ),
    );
  }
}
