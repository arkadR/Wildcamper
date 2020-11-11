import 'dart:convert';

import 'package:WildcamperMobile/Data/DataAccess/DTO/RatingDto.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class RatingsDataAccess {
  final Dio _dio = GetIt.instance<Dio>();
  final String _basePath = 'https://192.168.0.102:44310/';

  Future<int> addReview(RatingDto dto) async {
    var body = jsonDecode(jsonEncode(dto));
    var response = await _dio.post("${_basePath}odata/ratings", data: body);
    return response.data['RatingId'];
  }
}
