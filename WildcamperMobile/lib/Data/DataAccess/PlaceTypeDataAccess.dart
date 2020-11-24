import 'package:WildcamperMobile/Infrastructure/ApiClient.dart';
import 'package:get_it/get_it.dart';

import 'DTO/PlaceTypeDto.dart';

class PlaceTypeDataAccess {
  final ApiClient _apiClient = GetIt.instance<ApiClient>();
  Future<List<PlaceTypeDto>> getPlaceTypes() async {
    var response = await _apiClient.get("odata/placeTypes");
    var placeTypes = (response.data["value"] as List)
        .map((obj) => PlaceTypeDto.fromMap(obj));
    return placeTypes.toList();
  }
}
