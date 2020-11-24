import 'dart:convert';

import 'package:WildcamperMobile/Data/DataAccess/DTO/ImageDto.dart';
import 'package:WildcamperMobile/Data/DataAccess/DTO/PlaceDto.dart';
import 'package:WildcamperMobile/Data/DataAccess/ImagesDataAccess.dart';
import 'package:WildcamperMobile/Data/DataAccess/PlacesDataAccess.dart';
import 'package:WildcamperMobile/Domain/model/Place.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:WildcamperMobile/Infrastructure/UserProvider.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesRepository extends IPlacesRepository {
  final PlacesDataAccess _placesDataAccess = PlacesDataAccess();
  final ImagesDataAccess _imagesDataAccess = GetIt.instance<ImagesDataAccess>();
  final UserProvider _userProvider = GetIt.instance<UserProvider>();
  String get userId => _userProvider.getCurrentUser().uid;
  final _targetWidth = 100;
  final _thumbnailWidth = 50;

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
    // var myPlacesIds = _partLoadedPlaces
    //     .where((place) => place.creatorId == userId)
    //     .map((place) => place.placeId);
    // if (myPlacesIds.any((id) =>
    //     _fullyLoadedPlaces.where((place) => place.placeId == id).isEmpty)) {
    //   await _loadMyPlaces();
    // }
    return _partLoadedPlaces
        .where((place) => place.creatorId == userId)
        .toList();
  }

  @override
  Future<Place> getPlaceById(int id, {bool force = false}) async {
    var searchResult = _fullyLoadedPlaces
        .singleWhere((place) => place.placeId == id, orElse: () => null);
    if (searchResult != null && force == false) return searchResult;

    var res = await _placesDataAccess.getPlaceById(id);
    var placeDto = res.item1;
    var imageDtos = res.item2;
    var ratingDtos = res.item3;

    var placemark = await getPlaceMark(placeDto.latitude, placeDto.longitude);

    var model = Place.fromDto(placeDto,
        imageDtos: imageDtos, ratingDtos: ratingDtos, placemark: placemark);

    _fullyLoadedPlaces.add(model);
    _partLoadedPlaces.removeWhere((place) => place.placeId == id);
    _partLoadedPlaces.add(model);
    return model;
  }

  Future<void> _ensurePlacesLoaded({bool force = false}) async {
    if (force == false && _partLoadedPlaces != null) return;
    var dtos = await _placesDataAccess.getAllPlaces();
    var models = dtos.map((dto) => Place.fromDto(dto)).toList();
    _partLoadedPlaces = models;
  }

  // Future<void> _loadMyPlaces() async {
  //   var result = await _placesDataAccess.getUserPlaces(userId);
  //   var places = result.map((tuple) async {
  //     var placemark =
  //         await getPlaceMark(tuple.item1.latitude, tuple.item1.longitude);
  //     return Place.fromDto(tuple.item1,
  //         imageDtos: tuple.item2,
  //         ratingDtos: tuple.item3,
  //         placemark: placemark);
  //   });
  //   var models = await Future.wait(places);
  //   _fullyLoadedPlaces.removeWhere((place) => place.creatorId == userId);
  //   _fullyLoadedPlaces.addAll(models);
  // }

  @override
  Future addPlace(String name, String description, LatLng location,
      Iterable<String> photoPaths, int placeTypeId) async {
    var content = await base64Image(photoPaths.first, 90, _thumbnailWidth);

    var placeDto = PlaceDto(
        creatorId: userId,
        description: description,
        latitude: location.latitude,
        longitude: location.longitude,
        name: name,
        thumbnail: content,
        placeTypeId: placeTypeId);

    var placeId = await _placesDataAccess.addPlace(placeDto);

    var imageDtos = List<ImageDto>();
    for (var path in photoPaths) {
      var content = await base64Image(path, 90, _targetWidth);
      var dto = ImageDto(bytes: content, creatorId: userId, placeId: placeId);
      imageDtos.add(dto);
    }

    for (var image in imageDtos) {
      await _imagesDataAccess.addImage(image);
    }
    await getPlaceById(placeId, force: true);
  }

  @override
  Future removePlace(Place place) async {
    await _placesDataAccess.removePlace(place.placeId);
    await _ensurePlacesLoaded(force: true);
  }

  Future<Placemark> getPlaceMark(double latitude, double longitude) async {
    try {
      var placemarks = await placemarkFromCoordinates(latitude, longitude);
      return placemarks.first;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<String> base64Image(String path, int quality, int width) async {
    var properties = await FlutterNativeImage.getImageProperties(path);
    var file = await FlutterNativeImage.compressImage(path,
        quality: quality,
        targetWidth: width,
        targetHeight: (properties.height * width / properties.width).round());
    var bytes = await file.readAsBytes();
    var content = base64Encode(bytes);
    return content;
  }
}
