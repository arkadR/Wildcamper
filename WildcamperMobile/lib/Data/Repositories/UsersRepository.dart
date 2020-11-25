import 'dart:async';

import 'package:WildcamperMobile/Data/DataAccess/DTO/UserDto.dart';
import 'package:WildcamperMobile/Data/DataAccess/UsersDataAccess.dart';
import 'package:WildcamperMobile/Domain/model/user.dart';
import 'package:WildcamperMobile/Domain/repositories/IUsersRepository.dart';
import 'package:get_it/get_it.dart';

class UsersRepository extends IUsersRepository {
  final UsersDataAccess _usersDataAccess = GetIt.instance<UsersDataAccess>();
  Completer<List<User>> _users = Completer();
  @override
  Future addUser(String guid, String email, String displayName) async {
    await _usersDataAccess
        .addUser(UserDto(userId: guid, email: email, displayName: displayName));
  }

  @override
  Future<List<User>> getUsers() async {
    if (_users.isCompleted == false) {
      var userDtos = await _usersDataAccess.getUsers();
      var users = userDtos
          .map((dto) => User(
              displayName: dto.displayName,
              email: dto.email,
              userId: dto.userId))
          .toList();
      _users.complete(users);
    }
    return await _users.future;
  }
}
