import 'dart:convert';

class RatingDto {
  int ratingId;
  int placeId;
  int creatorId;
  String comment;
  int stars;
  RatingDto({
    this.ratingId,
    this.placeId,
    this.creatorId,
    this.comment,
    this.stars,
  });

  RatingDto copyWith({
    int ratingId,
    int placeId,
    int creatorId,
    String comment,
    int stars,
  }) {
    return RatingDto(
      ratingId: ratingId ?? this.ratingId,
      placeId: placeId ?? this.placeId,
      creatorId: creatorId ?? this.creatorId,
      comment: comment ?? this.comment,
      stars: stars ?? this.stars,
    );
  }

  Map<String, dynamic> toMap() {
    var obj = {
      'RatingId': ratingId,
      'PlaceId': placeId,
      'CreatorId': creatorId,
      'Comment': comment,
      'Stars': stars,
    };

    if (ratingId == null) obj.remove('RatingId');
    return obj;
  }

  factory RatingDto.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RatingDto(
      ratingId: map['RatingId'],
      placeId: map['PlaceId'],
      creatorId: map['CreatorId'],
      comment: map['Comment'],
      stars: map['Stars'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingDto.fromJson(String source) =>
      RatingDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReviewDto(ratingId: $ratingId, placeId: $placeId, creatorId: $creatorId, comment: $comment, stars: $stars)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RatingDto &&
        o.ratingId == ratingId &&
        o.placeId == placeId &&
        o.creatorId == creatorId &&
        o.comment == comment &&
        o.stars == stars;
  }

  @override
  int get hashCode {
    return ratingId.hashCode ^
        placeId.hashCode ^
        creatorId.hashCode ^
        comment.hashCode ^
        stars.hashCode;
  }
}
