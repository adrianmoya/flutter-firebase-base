import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_base/model/User.dart';

class AuthForm extends StatefulWidget {
  AuthForm({@required this.submitLabel, @required this.handler});

  final String submitLabel;
  final Future<User> Function(String email, String password) handler;

  @override
  State<StatefulWidget> createState() {
    return _AuthFormState();
  }
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorEmail = '';
  String _errorPassword = '';
  Future<User> _future;

  void clearErrors() {
    setState(() {
      _errorEmail = '';
      _errorPassword = '';
    });
  }

  bool _validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String validateEmail(String email) {
    return email.isEmpty ? "El email no puede estar vacío" : null;
  }

  String validatePassword(String password) {
    return password.isEmpty ? "La contraseña no puede estar vacía" : null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        print('snapshot.connectionState: ${snapshot.connectionState}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Form(
              key: formKey,
              onChanged: clearErrors,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Usuario'),
                    style: TextStyle(fontSize: 22),
                    validator: validateEmail,
                    onSaved: (value) => _email = value,
                  ),
                  Text(_errorEmail),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                    style: TextStyle(fontSize: 22),
                    validator: validatePassword,
                    onSaved: (value) => _password = value,
                  ),
                  Text(
                    _errorPassword,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_validateAndSave()) {
                        setState(() {
                          _future = widget.handler(_email, _password);
                        });
                      }
                    },
                    child: Text(
                      widget.submitLabel,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            );
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.active:
            return CircularProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasError) return Text('error');
            return Text('Done');
        }
        return null;
      },
    );
  }
}
