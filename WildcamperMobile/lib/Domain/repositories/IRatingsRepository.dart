abstract class IRatingsRepository {
  Future<int> addRating(int userId, int placeId, String comment, int stars);
}
