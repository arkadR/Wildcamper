import 'dart:async';

import 'package:WildcamperMobile/App/Map/MapScreenEvent.dart';
import 'package:WildcamperMobile/App/Map/MapScreenState.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreenBloc extends Bloc<MapScreenEvent, MapScreenState> {
  final IPlacesRepository _placesRepository =
      GetIt.instance<IPlacesRepository>();

  final Location _location = Location();
  Completer<GoogleMapController> _controller = Completer();
  bool _awaitingCameraChange = true;

  MapScreenBloc() : super(MapScreenState.initial(15)) {
    _location.onLocationChanged.first.then((locationData) => add(LocationLoaded(
        location: LatLng(locationData.latitude, locationData.longitude))));

    _placesRepository
        .getAllPlaces()
        .then((places) => add(PlacesLoaded(places: places)));
  }

  @override
  Stream<MapScreenState> mapEventToState(MapScreenEvent event) async* {
    if (event is MapLoaded) {
      _controller.complete(event.controller);
      _positionCamera();
    }
    if (event is LocationLoaded) {
      await _positionCamera(location: event.location);
      yield state.copyWith(currentLocation: event.location);
    }
    if (event is CameraMoved) {
      _awaitingCameraChange = false;
    }
    if (event is PlacesLoaded) {
      var markers = event.places
          .map((place) => Marker(
              markerId: MarkerId(place.placeId.toString()),
              position: place.location))
          .toList();

      yield state.copyWith(markers: markers);
    }
  }

  Future _positionCamera({LatLng location}) async {
    if (location == null) location = state.currentLocation;
    if (location == null) return;
    if (_controller.isCompleted == false) return;
    if (_awaitingCameraChange == false) return;
    var controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(location));
    _awaitingCameraChange = false;
  }
}
