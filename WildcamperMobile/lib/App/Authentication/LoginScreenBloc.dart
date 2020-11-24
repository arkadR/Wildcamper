import 'package:WildcamperMobile/Domain/repositories/IUsersRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'LoginScreenEvent.dart';
import 'LoginScreenState.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenState.initial());

  final IUsersRepository _usersRepository = GetIt.instance<IUsersRepository>();

  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();

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
    if (event is LoginWithGoogleClicked) {
      try {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser.authentication;
        final credential = await FirebaseAuth.instance
            .signInWithCredential(GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ));
        var user = credential.user;
        await _usersRepository.addUser(user.uid, user.email, user.displayName);
        yield state.copyWith(user: user);
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
        var user = userCredential.user;
        await _usersRepository.addUser(user.uid, user.email, user.displayName);
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
