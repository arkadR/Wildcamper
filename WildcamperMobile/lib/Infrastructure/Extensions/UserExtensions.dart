import 'package:firebase_auth/firebase_auth.dart';

extension UserExtensions on User {
  String getDisplayName() {
    if (this.displayName?.isEmpty ?? true) return this.email;
    return this.displayName;
  }
}
