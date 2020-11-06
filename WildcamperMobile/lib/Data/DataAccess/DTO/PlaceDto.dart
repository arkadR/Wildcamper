import 'dart:convert';

class PlaceDto {
  int placeId;
  int creatorId;
  String name;
  String description;
  double latitude;
  double longitude;
  PlaceDto({
    this.placeId,
    this.creatorId,
    this.name,
    this.description,
    this.latitude,
    this.longitude,
  });

  PlaceDto copyWith({
    int placeId,
    int creatorId,
    String name,
    String description,
    double latitude,
    double longitude,
  }) {
    return PlaceDto(
      placeId: placeId ?? this.placeId,
      creatorId: creatorId ?? this.creatorId,
      name: name ?? this.name,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'placeId': placeId,
      'creatorId': creatorId,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory PlaceDto.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PlaceDto(
      placeId: map['PlaceId'],
      creatorId: map['CreatorId'],
      name: map['Name'],
      description: map['Description'],
      latitude: map['Latitude'],
      longitude: map['Longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceDto.fromJson(String source) =>
      PlaceDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaceDto(placeId: $placeId, creatorId: $creatorId, name: $name, description: $description, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PlaceDto &&
        o.placeId == placeId &&
        o.creatorId == creatorId &&
        o.name == name &&
        o.description == description &&
        o.latitude == latitude &&
        o.longitude == longitude;
  }

  @override
  int get hashCode {
    return placeId.hashCode ^
        creatorId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
