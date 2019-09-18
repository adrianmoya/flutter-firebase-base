import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Usuario'),
                style: TextStyle(fontSize: 22),
                validator: validateEmail,
                onSaved: (value) => _email = value,
              ),
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
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: validateAndSave,
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

  void validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Form is valid with values: $_email and $_password");
    }
  }

  String validateEmail(String email) {
    return email.isEmpty ? "El email no puede estar vacío" : null;
  }

  String validatePassword(String password) {
    return password.isEmpty ? "La contraseña no puede estar vacía" : null;
  }
}
