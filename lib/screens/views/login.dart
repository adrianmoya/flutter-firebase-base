import 'package:flutter/material.dart';
import 'package:flutter_firebase_base/screens/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      builder: (context) => LoginViewModel(Provider.of(context)),
      child: Consumer<LoginViewModel>(
        builder: (context, model, widget) => Scaffold(
            appBar: AppBar(
              title: Text('Acceso'),
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Usuario'),
                          style: TextStyle(fontSize: 22),
                          validator: model.validateEmail,
                          initialValue: model.email,
                        ),
                        Text(model.errorEmail),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Contraseña'),
                          obscureText: true,
                          style: TextStyle(fontSize: 22),
                          validator: model.validatePassword,
                          initialValue: model.password,
                        ),
                        Text(
                          model.errorPassword,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        model.busy
                            ? CircularProgressIndicator()
                            : RaisedButton(
                                onPressed: () {
                                    model.loginUser();
                                  },
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    FlatButton(
                      child: Text('Registro', style: TextStyle(fontSize: 22)),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/register'),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
