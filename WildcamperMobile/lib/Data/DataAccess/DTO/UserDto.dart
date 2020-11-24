import 'dart:convert';

class UserDto {
  String userId;
  String email;
  String displayName;
  UserDto({
    this.userId,
    this.email,
    this.displayName,
  });

  UserDto copyWith({
    String userId,
    String email,
    String displayName,
  }) {
    return UserDto(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'UserId': userId,
      'Email': email,
      'DisplayName': displayName,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserDto(
      userId: map['UserId'],
      email: map['Email'],
      displayName: map['DisplayName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserDto(userId: $userId, email: $email, displayName: $displayName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserDto &&
        o.userId == userId &&
        o.email == email &&
        o.displayName == displayName;
  }

  @override
  int get hashCode => userId.hashCode ^ email.hashCode ^ displayName.hashCode;
}
