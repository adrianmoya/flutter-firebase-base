import 'package:flutter/material.dart';
import 'package:flutter_firebase_base/screens/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      builder: (context) => LoginViewModel(Provider.of(context, listen: false)),
      child: Consumer<LoginViewModel>(
        builder: (context, model, widget) => Scaffold(
            appBar: AppBar(
              title: Text(model.title),
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Usuario'),
                            style: TextStyle(fontSize: 22),
                            validator: model.validateEmail,
                            initialValue: model.email,
                            onSaved: (value) => model.email = value,
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
                            onSaved: (value) => model.password = value,
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
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      model.executeAction();
                                    }
                                  },
                                  child: Text(
                                    model.buttonLabel,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      FlatButton(
                        child: Text(model.linkLabel, style: TextStyle(fontSize: 22)),
                        onPressed: () => model.changeMode(),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
