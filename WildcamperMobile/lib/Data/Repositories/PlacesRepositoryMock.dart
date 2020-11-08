// import 'package:WildcamperMobile/Domain/model/place.dart';
// import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class PlacesRepositoryMock extends IPlacesRepository {
//   final List<Place> places = [
//     // Place(
//     //     placeId: 0,
//     //     creatorId: 123,
//     //     name: 'Place 1',
//     //     latitude: 37.43296265331129,
//     //     longitude: -122.08832357078792,
//     //     photoPathsDev: ['assets/image.png', 'assets/image.png']),
//     // Place(
//     //     placeId: 1,
//     //     creatorId: 123,
//     //     name: 'Place 2',
//     //     latitude: 37.43296265331129,
//     //     longitude: -123.08832357078792),
//     // Place(
//     //     placeId: 2,
//     //     creatorId: 123,
//     //     name: 'Place 3',
//     //     latitude: 37.43296265331129,
//     //     longitude: -124.08832357078792,
//     //     photoPathsDev: ['assets/image.png']),
//     // Place(
//     //     placeId: 3,
//     //     creatorId: 123,
//     //     name: 'Place 4',
//     //     latitude: 37.43296265331129,
//     //     longitude: -125.08832357078792),
//     // Place(
//     //     placeId: 4,
//     //     creatorId: 123,
//     //     name: 'Place 5',
//     //     latitude: 51,
//     //     longitude: 17)
//   ];

//   @override
//   Future<List<Place>> getAllPlaces() {
//     return Future(() => places);
//   }

//   @override
//   Future<List<Place>> getMyPlaces() {
//     return Future(() => [places[0]]);
//   }

//   @override
//   Future<Place> getPlaceById(int id) {
//     return Future(() => places.singleWhere((place) => place.placeId == id));
//   }
// }
