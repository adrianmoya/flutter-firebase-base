import 'package:flutter/material.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';
import 'package:flutter_firebase_base/shared/auth_form.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<User> _future;
  String _lastError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Acceso'),
          automaticallyImplyLeading: false,
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

            final _loginForm = _LoginForm(
                AuthForm(submitLabel: 'Acceder', handler: _loginUser));

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  _loginForm,
                  CircularProgressIndicator(),
                ],
              );
            }
            return _loginForm;
          },
        )));
  }

  void _loginUser(BuildContext context, String email, String password) async {
    final AuthService _auth = Provider.of(context);
    setState(() {
      _future =
          _auth.signInWithEmailAndPassword(email, password).catchError((e) {
        _lastError = e.cause;
      });
    });
  }
}

class _LoginForm extends StatelessWidget {
  _LoginForm(this._form);

  final AuthForm _form;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _form,
          FlatButton(
            child: Text('Registro', style: TextStyle(fontSize: 22)),
            onPressed: () => Navigator.pushNamed(context, '/register'),
          ),
        ],
      ),
    );
  }
}
