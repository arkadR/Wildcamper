import 'dart:convert';

import 'package:WildcamperMobile/Data/DataAccess/DTO/RatingDto.dart';
import 'package:WildcamperMobile/Infrastructure/ApiClient.dart';
import 'package:get_it/get_it.dart';

class RatingsDataAccess {
  final ApiClient _apiClient = GetIt.instance<ApiClient>();

  Future<int> addReview(RatingDto dto) async {
    var body = jsonDecode(jsonEncode(dto));
    var response = await _apiClient.post("odata/ratings", body);
    return response.data['RatingId'];
  }
}
