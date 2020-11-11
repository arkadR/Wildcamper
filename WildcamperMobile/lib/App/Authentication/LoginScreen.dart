import 'package:WildcamperMobile/App/Authentication/LoginScreenBloc.dart';
import 'package:WildcamperMobile/App/Authentication/LoginScreenState.dart';
import 'package:WildcamperMobile/App/Firebase/FirebaseEvent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Firebase/FirebaseBloc.dart';
import 'LoginScreenEvent.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginScreenBloc bloc(BuildContext ctx) =>
        BlocProvider.of<LoginScreenBloc>(ctx);

    return BlocProvider<LoginScreenBloc>(
        create: (context) => LoginScreenBloc(),
        child: BlocListener<LoginScreenBloc, LoginScreenState>(
            listener: _onStateChange,
            child: BlocBuilder<LoginScreenBloc, LoginScreenState>(
                builder: (context, state) => Scaffold(
                    appBar: AppBar(
                      title: const Text('Log in'),
                    ),
                    body: Column(children: [
                      TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          onChanged: (value) =>
                              bloc(context).add(EmailChanged(email: value))),
                      TextFormField(
                          decoration:
                              const InputDecoration(hintText: 'Password'),
                          onChanged: (value) => bloc(context)
                              .add(PasswordChanged(password: value))),
                      ElevatedButton(
                          onPressed: () =>
                              bloc(context).add(RegisterButtonClicked()),
                          child: Text('Register')),
                      ElevatedButton(
                          onPressed: () =>
                              bloc(context).add(LoginButtonClicked()),
                          child: Text('Log in')),
                      Text(state.errorText)
                    ])))));
  }

  void _onStateChange(BuildContext context, LoginScreenState state) {
    if (state.user != null) {
      BlocProvider.of<FirebaseBloc>(context).add(LoggedIn(user: state.user));
    }
  }
}
