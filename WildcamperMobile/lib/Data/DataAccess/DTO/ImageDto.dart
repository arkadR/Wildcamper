import 'dart:convert';

class ImageDto {
  int imageId;
  int placeId;
  int creatorId;
  String bytes;
  ImageDto({
    this.imageId,
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
      imageId: photoId ?? this.imageId,
      placeId: placeId ?? this.placeId,
      creatorId: creatorId ?? this.creatorId,
      bytes: bytes ?? this.bytes,
    );
  }

  Map<String, dynamic> toMap() {
    var obj = {
      'ImageId': imageId,
      'PlaceId': placeId,
      'CreatorId': creatorId,
      'Bytes': bytes,
    };
    if (imageId == null) obj.remove('ImageId');
    return obj;
  }

  factory ImageDto.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ImageDto(
      imageId: map['ImageId'],
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
    return 'ImageDto(photoId: $imageId, placeId: $placeId, creatorId: $creatorId, bytes: $bytes)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ImageDto &&
        o.imageId == imageId &&
        o.placeId == placeId &&
        o.creatorId == creatorId &&
        o.bytes == bytes;
  }

  @override
  int get hashCode {
    return imageId.hashCode ^
        placeId.hashCode ^
        creatorId.hashCode ^
        bytes.hashCode;
  }
}
