import 'package:WildcamperMobile/Data/DataAccess/ImagesDataAccess.dart';
import 'package:WildcamperMobile/Data/DataAccess/PlacesDataAccess.dart';
import 'package:WildcamperMobile/Domain/model/place.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:get_it/get_it.dart';

class PlacesRepository extends IPlacesRepository {
  final PlacesDataAccess _placesDataAccess = PlacesDataAccess();
  final ImagesDataAccess _imagesDataAccess = GetIt.instance<ImagesDataAccess>();

  List<Place> _partLoadedPlaces = null;
  List<Place> _fullyLoadedPlaces = List();

  @override
  Future<List<Place>> getAllPlaces() async {
    await _ensurePlacesLoaded();
    return _partLoadedPlaces;
  }

  @override
  Future<List<Place>> getMyPlaces() async {
    _ensurePlacesLoaded();
    int userId = 1; //TODO
    var myPlacesIds = _partLoadedPlaces
        .where((place) => place.creatorId == userId)
        .map((place) => place.placeId);
    if (myPlacesIds.any((id) =>
        _fullyLoadedPlaces.where((place) => place.placeId == id).isEmpty)) {
      await _loadMyPlaces();
    }
    return _fullyLoadedPlaces
        .where((place) => myPlacesIds.contains(place.placeId));
  }

  @override
  Future<Place> getPlaceById(int id) async {
    var searchResult = _fullyLoadedPlaces
        .singleWhere((place) => place.placeId == id, orElse: () => null);
    if (searchResult != null) return searchResult;

    var res = await _placesDataAccess.getPlaceById(id);
    var placeDto = res.item1;
    var imageDtos = res.item2;
    var model = Place.fromDto(placeDto, imageDtos: imageDtos);
    _fullyLoadedPlaces.add(model);
    return model;
  }

  Future<void> _ensurePlacesLoaded() async {
    if (_partLoadedPlaces != null) return;

    var dtos = await _placesDataAccess.getAllPlaces();
    var models = dtos.map((dto) => Place.fromDto(dto)).toList();
    _partLoadedPlaces = models;
  }

  Future<void> _loadMyPlaces() async {
    var userId = 1; //TODO
    var result = await _placesDataAccess.getUserPlaces(userId);
    var places = result
        .map((tuple) => Place.fromDto(tuple.item1, imageDtos: tuple.item2));
    _fullyLoadedPlaces.removeWhere((place) => place.creatorId == userId);
    _fullyLoadedPlaces.addAll(places);
  }
}
