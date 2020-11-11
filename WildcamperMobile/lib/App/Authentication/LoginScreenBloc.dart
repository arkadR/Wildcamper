import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoginScreenEvent.dart';
import 'LoginScreenState.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenState.initial());

  @override
  Stream<LoginScreenState> mapEventToState(LoginScreenEvent event) async* {
    if (event is EmailChanged) {
      yield state.copyWith(email: event.email);
    }
    if (event is PasswordChanged) {
      yield state.copyWith(password: event.password);
    }
    if (event is LoginButtonClicked) {
      if (state.isValid == false) throw new Exception("Bad login form state");
      try {
        var userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: state.email, password: state.password);
        yield state.copyWith(user: userCredential.user);
      } on FirebaseAuthException catch (e) {
        yield state.copyWith(errorText: _mapFirebaseErrorToMessage(e));
      }
    }

    if (event is RegisterButtonClicked) {
      if (state.isValid == false) throw new Exception("Bad login form state");
      try {
        var userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: state.email, password: state.password);
        yield state.copyWith(user: userCredential.user);
      } on FirebaseAuthException catch (e) {
        yield state.copyWith(errorText: _mapFirebaseErrorToMessage(e));
      }
    }
  }

  String _mapFirebaseErrorToMessage(FirebaseAuthException exc) {
    switch (exc.code) {
      case 'user-not-found':
        return 'No user found for that email.';
        break;
      case 'wrong-password':
        return 'Wrong password provided for that user.';
        break;
      case 'weak-password':
        return 'The provided password is too weak';
        break;
      case 'email-already-in-use':
        return 'The account already exists for that email';
    }
    return exc.message;
  }
}
