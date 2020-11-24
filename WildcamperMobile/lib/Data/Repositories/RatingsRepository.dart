import 'package:WildcamperMobile/Data/DataAccess/DTO/RatingDto.dart';
import 'package:WildcamperMobile/Data/DataAccess/RatingsDataAccess.dart';
import 'package:WildcamperMobile/Domain/repositories/IRatingsRepository.dart';
import 'package:get_it/get_it.dart';

class RatingsRepository extends IRatingsRepository {
  final RatingsDataAccess _ratingsDataAccess =
      GetIt.instance<RatingsDataAccess>();

  @override
  Future<int> addRating(
      String userId, int placeId, String comment, int stars) async {
    var dto = RatingDto(
        creatorId: userId, placeId: placeId, comment: comment, stars: stars);
    var ratingId = await _ratingsDataAccess.addReview(dto);
    return ratingId;
  }
}
