import 'dart:convert';

class ImageDto {
  int photoId;
  int placeId;
  int creatorId;
  String bytes;
  ImageDto({
    this.photoId,
    this.placeId,
    this.creatorId,
    this.bytes,
  });

  ImageDto copyWith({
    int photoId,
    int placeId,
    int creatorId,
    String bytes,
  }) {
    return ImageDto(
      photoId: photoId ?? this.photoId,
      placeId: placeId ?? this.placeId,
      creatorId: creatorId ?? this.creatorId,
      bytes: bytes ?? this.bytes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photoId': photoId,
      'placeId': placeId,
      'creatorId': creatorId,
      'bytes': bytes,
    };
  }

  factory ImageDto.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ImageDto(
      photoId: map['ImageId'],
      placeId: map['PlaceId'],
      creatorId: map['CreatorId'],
      bytes: map['Bytes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageDto.fromJson(String source) =>
      ImageDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ImageDto(photoId: $photoId, placeId: $placeId, creatorId: $creatorId, bytes: $bytes)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ImageDto &&
        o.photoId == photoId &&
        o.placeId == placeId &&
        o.creatorId == creatorId &&
        o.bytes == bytes;
  }

  @override
  int get hashCode {
    return photoId.hashCode ^
        placeId.hashCode ^
        creatorId.hashCode ^
        bytes.hashCode;
  }
}
