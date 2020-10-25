import 'package:WildcamperMobile/Domain/model/place.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesRepositoryMock extends IPlacesRepository {
  @override
  Future<List<Place>> getAllPlaces() {
    return Future(() => [
          Place(0, 123, 'Place 1',
              LatLng(37.43296265331129, -122.08832357078792)),
          Place(0, 123, 'Place 2',
              LatLng(37.43296265331129, -123.08832357078792)),
          Place(0, 123, 'Place 3',
              LatLng(37.43296265331129, -124.08832357078792)),
          Place(
              0, 123, 'Place 4', LatLng(37.43296265331129, -125.08832357078792))
        ]);
  }

  @override
  Future<List<Place>> getMyPlaces() {
    return Future(() => [
          Place(
              0, 123, 'Place 1', LatLng(37.43296265331129, -122.08832357078792))
        ]);
  }

  @override
  Future<Place> getPlaceById(int id) {
    // TODO: implement getPlaceById
    throw UnimplementedError();
  }
}
