import 'dart:convert';

import 'package:collection/collection.dart';

class User {
  int userId;
  String firstName;
  String lastName;
  String email;
  String nickname;
  List<int> createdPlacesIds;
  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.nickname,
    this.createdPlacesIds,
  });

  User copyWith({
    int userId,
    String firstName,
    String lastName,
    String email,
    String nickname,
    List<int> createdPlacesIds,
  }) {
    return User(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      createdPlacesIds: createdPlacesIds ?? this.createdPlacesIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'nickname': nickname,
      'createdPlacesIds': createdPlacesIds,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      userId: map['userId'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      nickname: map['nickname'],
      createdPlacesIds: List<int>.from(map['createdPlacesIds']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, nickname: $nickname, createdPlacesIds: $createdPlacesIds)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return o is User &&
        o.userId == userId &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.email == email &&
        o.nickname == nickname &&
        listEquals(o.createdPlacesIds, createdPlacesIds);
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        nickname.hashCode ^
        createdPlacesIds.hashCode;
  }
}
