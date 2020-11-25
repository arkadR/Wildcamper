import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';

import 'package:WildcamperMobile/Data/DataAccess/DTO/PlaceDto.dart';
import 'package:WildcamperMobile/Data/DataAccess/DTO/RatingDto.dart';
import 'package:WildcamperMobile/Infrastructure/ApiClient.dart';

import 'DTO/ImageDto.dart';

class PlacesDataAccess {
  final ApiClient _apiClient = GetIt.instance<ApiClient>();

  Future<List<PlaceDto>> getAllPlaces() async {
    var response = await _apiClient.get("odata/places");
    var places = (response.data['value'] as List)
        .map((obj) => PlaceDto.fromMap(obj))
        .toList();
    return places;
  }

  Future<Tuple3<PlaceDto, List<ImageDto>, List<RatingDto>>> getPlaceById(
      int id) async {
    var response =
        await _apiClient.get("odata/places($id)?\$expand=Images,Ratings");
    var place = PlaceDto.fromMap(response.data);
    var images = (response.data['Images'] as List)
        .map((obj) => ImageDto.fromMap(obj))
        .toList();
    var ratings = (response.data['Ratings'] as List)
        .map((obj) => RatingDto.fromMap(obj))
        .toList();
    return Tuple3(place, images, ratings);
  }

  Future<List<Tuple3<PlaceDto, List<ImageDto>, List<RatingDto>>>> getUserPlaces(
      String userId) async {
    var response = await _apiClient.get(
        "odata/places?\$expand=Images,Ratings&\$filter=CreatorId eq '$userId'");
    var places = (response.data['value'] as List).map((obj) {
      var placeDto = PlaceDto.fromMap(obj);
      var imageDtos =
          (obj['Images'] as List).map((obj) => ImageDto.fromMap(obj)).toList();
      var ratingDtos = (obj['Ratings'] as List)
          .map((obj) => RatingDto.fromMap(obj))
          .toList();
      return Tuple3(placeDto, imageDtos, ratingDtos);
    });
    return places.toList();
  }

  Future<int> addPlace(PlaceDto dto) async {
    var body = jsonDecode(jsonEncode(dto));
    var response = await _apiClient.post("odata/places", body);
    return response.data['PlaceId'];
  }

  Future removePlace(int placeId) async {
    var response = await _apiClient.delete("odata/places($placeId)");
  }

  Future updatePlace(int placeId, String title, String description) async {
    var delta = jsonDecode(
        jsonEncode(PlaceDelta(name: title, description: description)));
    var response = await _apiClient.patch("odata/places($placeId)", delta);
  }
}

class PlaceDelta {
  String name;
  String description;
  PlaceDelta({
    this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Description': description,
    };
  }

  String toJson() => json.encode(toMap());
}
