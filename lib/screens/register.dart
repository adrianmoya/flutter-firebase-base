import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                onPressed: registerUser,
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

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future registerUser() async {
    if (validateAndSave()) {
      AuthResult authResult;
      try {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
      } on PlatformException catch (e) {
        if (e.code == 'ERROR_WEAK_PASSWORD') {
          print ('Password débil');
        }
        print(e.toString());
      }
      if (authResult != null) {
        print('Se ha creado el usuario exitosamente ${authResult.user}');
      } else {
        print('AuthResult $authResult');
      }
    }
  }

  String validateEmail(String email) {
    return email.isEmpty ? "El email no puede estar vacío" : null;
  }

  String validatePassword(String password) {
    return password.isEmpty ? "La contraseña no puede estar vacía" : null;
  }
}
