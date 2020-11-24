import 'dart:convert';

class PlaceDto {
  int placeId;
  String creatorId;
  String name;
  String description;
  double latitude;
  double longitude;
  String thumbnail;
  int placeTypeId;
  PlaceDto({
    this.placeId,
    this.creatorId,
    this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.thumbnail,
    this.placeTypeId,
  });

  PlaceDto copyWith({
    int placeId,
    String creatorId,
    String name,
    String description,
    double latitude,
    double longitude,
    String thumbnail,
    int placeTypeId,
  }) {
    return PlaceDto(
      placeId: placeId ?? this.placeId,
      creatorId: creatorId ?? this.creatorId,
      name: name ?? this.name,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      thumbnail: thumbnail ?? this.thumbnail,
      placeTypeId: placeTypeId ?? this.placeTypeId,
    );
  }

  Map<String, dynamic> toMap() {
    var obj = {
      'PlaceId': placeId,
      'CreatorId': creatorId,
      'Name': name,
      'Description': description,
      'Latitude': latitude,
      'Longitude': longitude,
      'Thumbnail': thumbnail,
      'PlaceTypeId': placeTypeId,
    };
    if (placeId == null) obj.remove('PlaceId');
    return obj;
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
      thumbnail: map['Thumbnail'],
      placeTypeId: map['PlaceTypeId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceDto.fromJson(String source) =>
      PlaceDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaceDto(placeId: $placeId, creatorId: $creatorId, name: $name, description: $description, latitude: $latitude, longitude: $longitude, thumbnail: $thumbnail, placeTypeId: $placeTypeId)';
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
        o.longitude == longitude &&
        o.thumbnail == thumbnail &&
        o.placeTypeId == placeTypeId;
  }

  @override
  int get hashCode {
    return placeId.hashCode ^
        creatorId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        thumbnail.hashCode ^
        placeTypeId.hashCode;
  }
}
