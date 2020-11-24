import 'package:equatable/equatable.dart';

abstract class LoginScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginScreenEvent {
  final String email;

  EmailChanged({this.email});

  List<Object> get props => [email];
}

class PasswordChanged extends LoginScreenEvent {
  final String password;

  PasswordChanged({this.password});

  List<Object> get props => [password];
}

class LoginButtonClicked extends LoginScreenEvent {}

class RegisterButtonClicked extends LoginScreenEvent {}

class LoginWithGoogleClicked extends LoginScreenEvent {}
