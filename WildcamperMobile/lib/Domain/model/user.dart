import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class User {
  String userId;
  String displayName;
  String email;
  List<int> createdPlacesIds;
  User({
    this.userId,
    this.displayName,
    this.email,
    this.createdPlacesIds,
  });

  String get displayedName {
    if (displayName != null) return displayName;
    if (email != null) return email;
    return userId;
  }

  User copyWith({
    String userId,
    String displayName,
    String email,
    List<int> createdPlacesIds,
  }) {
    return User(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      createdPlacesIds: createdPlacesIds ?? this.createdPlacesIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'createdPlacesIds': createdPlacesIds,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      userId: map['userId'],
      displayName: map['displayName'],
      email: map['email'],
      createdPlacesIds: List<int>.from(map['createdPlacesIds']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(userId: $userId, displayName: $displayName, email: $email, createdPlacesIds: $createdPlacesIds)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.userId == userId &&
        o.displayName == displayName &&
        o.email == email &&
        listEquals(o.createdPlacesIds, createdPlacesIds);
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        displayName.hashCode ^
        email.hashCode ^
        createdPlacesIds.hashCode;
  }
}
