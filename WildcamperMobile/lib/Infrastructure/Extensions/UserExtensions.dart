import 'package:firebase_auth/firebase_auth.dart';

extension UserExtensions on User {
  String getDisplayName() {
    if (this.displayName?.isEmpty ?? false) return this.email;
    return this.displayName;
  }
}
