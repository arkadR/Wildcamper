import 'package:WildcamperMobile/Domain/model/Place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class IPlacesRepository {
  Future<List<Place>> getAllPlaces();
  Future<List<Place>> getMyPlaces();
  Future<Place> getPlaceById(int id);

  Future addPlace(String name, String description, LatLng location,
      Iterable<String> photoPaths, int placeTypeId);

  Future removePlace(Place place);
}
