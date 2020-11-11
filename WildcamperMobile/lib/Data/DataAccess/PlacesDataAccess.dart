import 'dart:convert';

import 'package:WildcamperMobile/Data/DataAccess/DTO/PlaceDto.dart';
import 'package:WildcamperMobile/Data/DataAccess/DTO/RatingDto.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';

import 'DTO/ImageDto.dart';

class PlacesDataAccess {
  final Dio _dio = GetIt.instance<Dio>();
  final String _basePath = 'https://192.168.0.102:44310/';

  Future<List<PlaceDto>> getAllPlaces() async {
    var response = await _dio.get("${_basePath}odata/places");
    var places = (response.data['value'] as List)
        .map((obj) => PlaceDto.fromMap(obj))
        .toList();
    return places;
  }

  Future<Tuple3<PlaceDto, List<ImageDto>, List<RatingDto>>> getPlaceById(
      int id) async {
    var response =
        await _dio.get("${_basePath}odata/places($id)?\$expand=Images,Ratings");
    var place = PlaceDto.fromMap(response.data);
    var images = (response.data['Images'] as List)
        .map((obj) => ImageDto.fromMap(obj))
        .toList();
    var ratings = (response.data['Ratings'] as List)
        .map((obj) => RatingDto.fromMap(obj))
        .toList();
    return Tuple3(place, images, ratings);
  }

  Future<List<Tuple2<PlaceDto, List<ImageDto>>>> getUserPlaces(
      int userId) async {
    var response = await _dio.get(
        "${_basePath}odata/places?\$expand=Images&\$filter=creatorId eq $userId");
    var places = (response.data['value'] as List).map((obj) {
      var placeDto = PlaceDto.fromMap(obj);
      var imageDtos =
          (obj['images'] as List).map((obj) => ImageDto.fromMap(obj)).toList();
      return Tuple2(placeDto, imageDtos);
    });
    return places.toList();
  }

  Future<int> addPlace(PlaceDto dto) async {
    var body = jsonDecode(jsonEncode(dto));
    var response = await _dio.post("${_basePath}odata/places", data: body);
    return response.data['PlaceId'];
  }
}
