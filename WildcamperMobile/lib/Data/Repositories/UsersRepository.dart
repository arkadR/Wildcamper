import 'package:WildcamperMobile/Data/DataAccess/DTO/UserDto.dart';
import 'package:WildcamperMobile/Data/DataAccess/UsersDataAccess.dart';
import 'package:WildcamperMobile/Domain/repositories/IUsersRepository.dart';
import 'package:get_it/get_it.dart';

class UsersRepository extends IUsersRepository {
  final UsersDataAccess _usersDataAccess = GetIt.instance<UsersDataAccess>();
  @override
  Future addUser(String guid, String email, String displayName) async {
    await _usersDataAccess
        .addUser(UserDto(userId: guid, email: email, displayName: displayName));
  }
}
