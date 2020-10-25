import 'package:WildcamperMobile/Domain/model/place.dart';

abstract class IPlacesRepository {
  Future<List<Place>> getAllPlaces();
  Future<List<Place>> getMyPlaces();
  Future<Place> getPlaceById(int id);
}
