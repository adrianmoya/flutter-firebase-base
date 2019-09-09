import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Usuario:',
              style: TextStyle(fontSize: 22),
            ),
            TextFormField(),
            SizedBox(height: 10,),
            Text('Contraseña:', style: TextStyle(fontSize: 22)),
            TextFormField(
              obscureText: true,
            ),
            RaisedButton(onPressed: () {}, child: Text('Acceder'),)
          ],
          mainAxisAlignment: MainAxisAlignment.center,

        ),
      ),
    );
  }
}
