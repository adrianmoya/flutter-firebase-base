import 'package:flutter/material.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';
import 'package:flutter_firebase_base/shared/auth_form.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Future<User> _future;
  String _lastError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
        ),
        body: SingleChildScrollView(
            child: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            print('snapshot.connectionState: ${snapshot.connectionState}');
            WidgetsBinding.instance.addPostFrameCallback((d) {
              if (_lastError != null) {
                final snackBar = SnackBar(content: Text(_lastError));
                _lastError = null;
                Scaffold.of(context).showSnackBar(snackBar);
              }
            });

            final _registerForm = _RegisterForm(
                AuthForm(submitLabel: 'Registrarme', handler: _registerUser));

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[_registerForm, CircularProgressIndicator()],
              );
            }
            return _registerForm;
          },
        )));
  }

  void _registerUser(
      BuildContext context, String email, String password) async {
    final AuthService _auth = Provider.of(context);
    setState(() {
      _future =
          _auth.createUserWithEmailAndPassword(email, password).catchError((e) {
        _lastError = e.cause;
      });
    });
  }
}

class _RegisterForm extends StatelessWidget {
  _RegisterForm(this._form);

  final AuthForm _form;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _form,
          FlatButton(
            child: Text('Acceder', style: TextStyle(fontSize: 22)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
