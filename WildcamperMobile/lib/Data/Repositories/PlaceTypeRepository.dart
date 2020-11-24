import 'dart:async';

import 'package:WildcamperMobile/Data/DataAccess/DTO/PlaceTypeDto.dart';
import 'package:WildcamperMobile/Data/DataAccess/PlaceTypeDataAccess.dart';
import 'package:WildcamperMobile/Domain/repositories/IPlaceTypeRepository.dart';
import 'package:get_it/get_it.dart';

class PlaceTypeRepository extends IPlaceTypeRepository {
  final PlaceTypeDataAccess _dataAccess = GetIt.instance<PlaceTypeDataAccess>();
  Completer<List<PlaceTypeDto>> _placeTypes = new Completer();

  PlaceTypeRepository() {
    _dataAccess.getPlaceTypes().then((places) => _placeTypes.complete(places));
  }

  @override
  Future<List<PlaceTypeDto>> getPlaceTypes() async {
    return await _placeTypes.future;
  }
}
