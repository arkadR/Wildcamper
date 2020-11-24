import 'package:WildcamperMobile/Domain/model/Place.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:WildcamperMobile/Infrastructure/UserProvider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';

import 'package:WildcamperMobile/Infrastructure/Extensions/PlacemarkExtensions.dart';

part 'PlaceScreenState.dart';
part 'PlaceScreenEvent.dart';

class PlaceScreenBloc extends Bloc<PlaceScreenEvent, PlaceScreenState> {
  PlaceScreenBloc(int placeId) : super(PlaceScreenState.initial()) {
    _placesRepository
        .getPlaceById(placeId)
        .then((place) => add(PlaceLoaded(place)));
  }
  final UserProvider _userProvider = GetIt.instance<UserProvider>();
  String get userId => _userProvider.getCurrentUser().uid;

  final IPlacesRepository _placesRepository =
      GetIt.instance<IPlacesRepository>();

  @override
  Stream<PlaceScreenState> mapEventToState(PlaceScreenEvent event) async* {
    if (event is PlaceLoaded) {
      getDistanceFromCurrentLocation()
          .then((distance) => add(DistanceCalculated(distance)));
      var showAddRating = shouldShowAddRatingsSection(userId, event.place);
      yield state.copyWith(place: event.place, showAddRating: showAddRating);
    }
    if (event is DistanceCalculated) {
      yield state.copyWith(distance: event.distance);
    }
  }

  Future<double> getDistanceFromCurrentLocation() async {
    var location = await Location().getLocation();
    var distance = Geolocator.distanceBetween(state.place.location.latitude,
        state.place.location.longitude, location.latitude, location.longitude);
    return distance;
  }

  bool shouldShowAddRatingsSection(String userId, Place place) {
    if (place.creatorId == userId) return false;
    if (place.ratings.any((r) => r.creatorId == userId)) return false;
    return true;
  }
}
