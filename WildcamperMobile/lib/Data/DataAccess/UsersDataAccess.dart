import 'dart:convert';
import 'dart:io';

import 'package:WildcamperMobile/Infrastructure/ApiClient.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'DTO/UserDto.dart';

class UsersDataAccess {
  final ApiClient _apiClient = GetIt.instance<ApiClient>();

  Future addUser(UserDto user) async {
    var body = jsonDecode(jsonEncode(user));
    try {
      await _apiClient.post("odata/users", body);
    } on DioError catch (e) {
      if (e.response.statusCode != HttpStatus.conflict) rethrow;
    }
  }

  Future<List<UserDto>> getUsers() async {
    var response = await _apiClient.get("odata/users");
    var users = (response.data["value"] as List)
        .map((obj) => UserDto.fromMap(obj))
        .toList();
    return users;
  }
}
