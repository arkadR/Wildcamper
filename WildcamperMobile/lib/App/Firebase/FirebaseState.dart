import 'package:firebase_auth/firebase_auth.dart';

class FirebaseState {
  final FirebaseStatus status;
  final int userId;
  final User user;
  final UserCredential userCredential;
  FirebaseState({
    this.status,
    this.userId,
    this.user,
    this.userCredential,
  });

  factory FirebaseState.initial() {
    return FirebaseState(
        status: FirebaseStatus.uninitialized,
        userId: null,
        user: null,
        userCredential: null);
  }

  FirebaseState copyWith({
    FirebaseStatus status,
    int userId,
    User user,
    UserCredential userCredential,
  }) {
    return FirebaseState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      user: user ?? this.user,
      userCredential: userCredential ?? this.userCredential,
    );
  }

  @override
  String toString() {
    return 'FirebaseState(authenticationStatus: $status, userId: $userId, user: $user, userCredential: $userCredential)';
  }
}

enum FirebaseStatus { uninitialized, unauthenticated, authenticated, error }
