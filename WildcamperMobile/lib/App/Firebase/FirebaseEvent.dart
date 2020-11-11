import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoggedIn extends FirebaseEvent {
  final User user;

  LoggedIn({this.user});

  @override
  List<Object> get props => [user];
}

class LoggedOut extends FirebaseEvent {}

class FirebaseInitialized extends FirebaseEvent {}
