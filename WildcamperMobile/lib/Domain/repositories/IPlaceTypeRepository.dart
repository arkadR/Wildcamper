import 'package:WildcamperMobile/Data/DataAccess/DTO/PlaceTypeDto.dart';

abstract class IPlaceTypeRepository {
  Future<List<PlaceTypeDto>> getPlaceTypes();
}
