import 'package:firebase_auth/firebase_auth.dart';

class LoginScreenState {
  static RegExp _emailRegex = RegExp(r"\S+@\S+\.\S+");
  final String email;
  final String password;
  final String errorText;
  final User user;
  LoginScreenState({
    this.email,
    this.password,
    this.errorText,
    this.user,
  });

  bool get isValid => _emailRegex.hasMatch(email) && password.length >= 8;

  factory LoginScreenState.initial() {
    return LoginScreenState(email: "", password: "", errorText: "", user: null);
  }

  LoginScreenState copyWith({
    String email,
    String password,
    String errorText,
    User user,
  }) {
    return LoginScreenState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorText: errorText ?? this.errorText,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'LoginScreenState(email: $email, password: $password, errorText: $errorText, user: $user)';
  }
}
