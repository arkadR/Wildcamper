import 'package:WildcamperMobile/Domain/model/user.dart';

abstract class IUsersRepository {
  Future<List<User>> getUsers();
  Future addUser(String guid, String email, String displayName);
}
