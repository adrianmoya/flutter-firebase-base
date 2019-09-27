import 'package:flutter/material.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorEmail = '';
  String _errorPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Form(
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
                onPressed: _registerUser,
                child: Text(
                  'Crear',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              FlatButton(
                child: Text('Acceder', style: TextStyle(fontSize: 22)),
                onPressed: () => Navigator.pop(context),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void _registerUser() async {
    final AuthService auth = Provider.of(context);

    if (_validateAndSave()) {
      try {
        User user =
            await auth.createUserWithEmailAndPassword(_email, _password);
        print('Successfuly logged as $user');
      } catch (e) {
        setState(() {
          if (e.code == 'ERROR_WEAK_PASSWORD') {
            _errorPassword = 'Password débil';
          } else if (e.code == 'ERROR_INVALID_EMAIL') {
            _errorEmail = 'Email inválido';
          } else if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
            _errorEmail = 'Email en uso por otra cuenta';
          }
        });
      }
    }
  }

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
}
