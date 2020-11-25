abstract class IRatingsRepository {
  Future<int> addRating(String userId, int placeId, String comment, int stars);
  Future removeRating(int ratingId);
}
