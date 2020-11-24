import 'package:firebase_auth/firebase_auth.dart';

class UserProvider {
  User getCurrentUser() {
    var auth = FirebaseAuth.instance;
    return auth.currentUser;
  }
}
