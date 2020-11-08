import 'dart:convert';
import 'dart:io';

import 'package:WildcamperMobile/Data/DataAccess/DTO/ImageDto.dart';
import 'package:WildcamperMobile/Data/DataAccess/DTO/PlaceDto.dart';
import 'package:WildcamperMobile/Data/DataAccess/ImagesDataAccess.dart';
import 'package:WildcamperMobile/Data/DataAccess/PlacesDataAccess.dart';
import 'package:WildcamperMobile/Domain/model/place.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as img;

class PlacesRepository extends IPlacesRepository {
  final PlacesDataAccess _placesDataAccess = PlacesDataAccess();
  final ImagesDataAccess _imagesDataAccess = GetIt.instance<ImagesDataAccess>();
  final userId = 3; //TODO
  final _targetWidth = 100;

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
  Future<Place> getPlaceById(int id, {bool force = false}) async {
    var searchResult = _fullyLoadedPlaces
        .singleWhere((place) => place.placeId == id, orElse: () => null);
    if (searchResult != null && force == false) return searchResult;

    var res = await _placesDataAccess.getPlaceById(id);
    var placeDto = res.item1;
    var imageDtos = res.item2;
    var model = Place.fromDto(placeDto, imageDtos: imageDtos);
    _fullyLoadedPlaces.add(model);
    _partLoadedPlaces.removeWhere((place) => place.placeId == id);
    _partLoadedPlaces.add(model);
    return model;
  }

  Future<void> _ensurePlacesLoaded() async {
    if (_partLoadedPlaces != null) return;

    var dtos = await _placesDataAccess.getAllPlaces();
    var models = dtos.map((dto) => Place.fromDto(dto)).toList();
    _partLoadedPlaces = models;
  }

  Future<void> _loadMyPlaces() async {
    var result = await _placesDataAccess.getUserPlaces(userId);
    var places = result
        .map((tuple) => Place.fromDto(tuple.item1, imageDtos: tuple.item2));
    _fullyLoadedPlaces.removeWhere((place) => place.creatorId == userId);
    _fullyLoadedPlaces.addAll(places);
  }

  @override
  Future addPlace(String name, String description, LatLng location,
      Iterable<String> photoPaths) async {
    var placeDto = PlaceDto(
        creatorId: userId,
        description: description,
        latitude: location.latitude,
        longitude: location.longitude,
        name: name);

    var placeId = await _placesDataAccess.addPlace(placeDto);

    var imageDtos = List<ImageDto>();
    for (var path in photoPaths) {
      ImageProperties properties =
          await FlutterNativeImage.getImageProperties(path);
      var file = await FlutterNativeImage.compressImage(path,
          quality: 90,
          targetWidth: _targetWidth,
          targetHeight:
              (properties.height * _targetWidth / properties.width).round());
      var bytes = await file.readAsBytes();
      var content = base64Encode(bytes);
      var dto = ImageDto(bytes: content, creatorId: userId, placeId: placeId);
      imageDtos.add(dto);
    }

    for (var image in imageDtos) {
      await _imagesDataAccess.addImage(image);
    }
    await getPlaceById(placeId, force: true);
  }
}
