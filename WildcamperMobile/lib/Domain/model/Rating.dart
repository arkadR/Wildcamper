import 'package:WildcamperMobile/Data/DataAccess/DTO/RatingDto.dart';

class Rating {
  int ratingId;
  String creatorId;
  int placeId;
  String comment;
  int stars;

  Rating({
    this.ratingId,
    this.creatorId,
    this.placeId,
    this.comment,
    this.stars,
  });

  factory Rating.fromDto(RatingDto rtg) => Rating(
      ratingId: rtg.ratingId,
      creatorId: rtg.creatorId,
      comment: rtg.comment,
      placeId: rtg.placeId,
      stars: rtg.stars);
}
