import 'package:flutter/material.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';
import 'package:flutter_firebase_base/shared/auth_form.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: new _RegisterBody(),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = Provider.of(context);

    Future<User> _registerUser(String email, String password) async {
      return _auth
          .createUserWithEmailAndPassword(email, password)
          .catchError((e) {
        final snackBar = SnackBar(content: Text(e.cause));
        Scaffold.of(context).showSnackBar(snackBar);
      });
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            AuthForm(submitLabel: 'Registrarme', handler: _registerUser),
            FlatButton(
              child: Text('Acceder', style: TextStyle(fontSize: 22)),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
