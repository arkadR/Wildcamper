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
                    body: SingleChildScrollView(
                      child: Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: Column(children: [
                            Image.asset(
                              'assets/logo.png',
                              height: 300,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                ),
                                onChanged: (value) => bloc(context)
                                    .add(EmailChanged(email: value))),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                decoration:
                                    const InputDecoration(hintText: 'Password'),
                                onChanged: (value) => bloc(context)
                                    .add(PasswordChanged(password: value))),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                                onPressed: () =>
                                    bloc(context).add(LoginButtonClicked()),
                                text: 'Log in'),
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                                onPressed: () =>
                                    bloc(context).add(RegisterButtonClicked()),
                                text: 'Create Account'),
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                                text: "Sign in with Google",
                                image: Image(
                                    image: AssetImage("assets/google_logo.png"),
                                    height: 35.0),
                                onPressed: () => bloc(context)
                                    .add(LoginWithGoogleClicked())),
                            Text(state.errorText)
                          ]),
                        ),
                      ),
                    )))));
  }

  void _onStateChange(BuildContext context, LoginScreenState state) {
    if (state.user != null) {
      BlocProvider.of<FirebaseBloc>(context).add(LoggedIn(user: state.user));
    }
  }
}

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Image image;

  const CustomButton(
      {Key key, @required this.onPressed, @required this.text, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 300,
      child: OutlineButton(
        splashColor: Colors.grey,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (image != null) image,
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
