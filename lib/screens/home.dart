import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_base/model/User.dart';
import 'package:flutter_firebase_base/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  _HomeDrawer homeDrawer;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Text('Home Page'),
      drawer: _HomeDrawer(user: user),
    );
  }
}

class _HomeDrawer extends StatelessWidget {
  const _HomeDrawer({
    Key key,
    @required User user,
  })  : assert(user != null, 'User cannot be null'),
        _user = user,
        super(key: key);

  final User _user;

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: _user.email != null ? Text(_user.email) : Text(''),
            accountName:
                _user.displayName != null ? Text(_user.displayName) : Text(''),
            currentAccountPicture: CircleAvatar(
                child: _user.photoUrl != null
                    ? Image.network(_user.photoUrl)
                    : Text('X')),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
          ),
          Divider(),
          ListTile(
            title: Text('Salir'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.of(context).pop(); // Close drawer
              _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
