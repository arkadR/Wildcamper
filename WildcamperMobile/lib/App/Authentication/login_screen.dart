import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function(UserCredential) onLoggedIn;
  LoginScreen({Key key, this.onLoggedIn}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorText = '';
  UserCredential _userCredential;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Log in'),
        ),
        body: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Email')),
              TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: 'Password')),
              ElevatedButton(onPressed: register, child: Text('Register')),
              ElevatedButton(onPressed: login, child: Text('Log in')),
              Text(_errorText)
            ])));
  }

  Future<void> register() async {
    if (_formKey.currentState.validate()) {
      var email = _emailController.text;
      var password = _passwordController.text;
      try {
        _userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() => _errorText = 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          setState(
              () => _errorText = 'The account already exists for that email.');
        } else {
          setState(() => _errorText = e.message);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> login() async {
    if (_formKey.currentState.validate()) {
      var email = _emailController.text;
      var password = _passwordController.text;
      try {
        _userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        widget.onLoggedIn(_userCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() => _errorText = 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          setState(() => _errorText = 'Wrong password provided for that user.');
        } else {
          setState(() => _errorText = e.message);
        }
      }
    }
  }
}
