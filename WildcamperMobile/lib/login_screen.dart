import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(children: [
      TextFormField(decoration: const InputDecoration(hintText: 'Email')),
      TextFormField(decoration: const InputDecoration(hintText: 'Password'))
    ]));
  }
}
