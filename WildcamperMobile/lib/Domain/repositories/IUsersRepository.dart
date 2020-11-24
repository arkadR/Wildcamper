abstract class IUsersRepository {
  Future addUser(String guid, String email, String displayName);
}
