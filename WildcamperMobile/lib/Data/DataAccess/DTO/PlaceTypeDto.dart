import 'dart:convert';

class PlaceTypeDto {
  int placeTypeId;
  String name;
  PlaceTypeDto({
    this.placeTypeId,
    this.name,
  });

  PlaceTypeDto copyWith({
    int placeTypeId,
    String name,
  }) {
    return PlaceTypeDto(
      placeTypeId: placeTypeId ?? this.placeTypeId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'PlaceTypeId': placeTypeId,
      'Name': name,
    };
  }

  factory PlaceTypeDto.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PlaceTypeDto(
      placeTypeId: map['PlaceTypeId'],
      name: map['Name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceTypeDto.fromJson(String source) =>
      PlaceTypeDto.fromMap(json.decode(source));

  @override
  String toString() => 'PlaceTypeDto(placeTypeId: $placeTypeId, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PlaceTypeDto && o.placeTypeId == placeTypeId && o.name == name;
  }

  @override
  int get hashCode => placeTypeId.hashCode ^ name.hashCode;
}
