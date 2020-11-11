import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'FirebaseEvent.dart';
import 'FirebaseState.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  final Completer<FirebaseAuth> _auth = Completer();

  FirebaseBloc() : super(FirebaseState.initial()) {
    Firebase.initializeApp().then((value) => add(FirebaseInitialized()));
  }

  @override
  Stream<FirebaseState> mapEventToState(FirebaseEvent event) async* {
    if (event is LoggedIn) {
      yield state.copyWith(
          status: FirebaseStatus.authenticated, user: event.user);
    }
    if (event is LoggedOut) {
      var auth = await _auth.future;
      await auth.signOut();
      yield state.copyWith(status: FirebaseStatus.unauthenticated);
    }
    if (event is FirebaseInitialized) {
      var auth = FirebaseAuth.instance;
      _auth.complete(auth);
      var user = auth.currentUser;
      if (user != null) add(LoggedIn(user: user));
      yield state.copyWith(status: FirebaseStatus.unauthenticated);
    }
  }
}
