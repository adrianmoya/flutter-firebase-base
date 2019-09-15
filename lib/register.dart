import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(decoration: InputDecoration(labelText: 'Usuario'),),
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            RaisedButton(onPressed: createUser, child: Text('Acceder'),)
          ],
          mainAxisAlignment: MainAxisAlignment.center,

        ),
      ),
    );
  }

  void createUser() {

  }
}
