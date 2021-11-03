import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreenPage>{
  String? email, password;
  final _key = new GlobalKey();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Bazaar"),),
      body: Container(
        child: Center(
          child: Text("Login Screen Page"),
        ),
      ),
    );
  }
}
