import 'dart:async';

import 'package:WildcamperMobile/App/Map/MapScreenEvent.dart';
import 'package:WildcamperMobile/App/Map/MapScreenState.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Completer<BitmapDescriptor> _wildIconBitmap =
      Completer(); // BitmapDescriptor.defaultMarker;
  Completer<BitmapDescriptor> _campsiteIconBitmap =
      Completer(); //BitmapDescriptor.defaultMarker;

  MapScreenBloc() : super(MapScreenState.initial(15)) {
    _location.onLocationChanged.first.then((locationData) => add(LocationLoaded(
        location: LatLng(locationData.latitude, locationData.longitude))));

    _placesRepository
        .getAllPlaces()
        .then((places) => add(PlacesLoaded(places: places)));

    rootBundle.load('assets/place_marker.png').then((byteData) =>
        _wildIconBitmap.complete(
            BitmapDescriptor.fromBytes(byteData.buffer.asUint8List())));

    rootBundle.load('assets/campsite_marker.png').then((byteData) =>
        _campsiteIconBitmap.complete(
            BitmapDescriptor.fromBytes(byteData.buffer.asUint8List())));
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
      var campsiteIcon = await _campsiteIconBitmap.future;
      var wildcampingIcon = await _wildIconBitmap.future;
      var markers = event.places
          .map((place) => Marker(
              markerId: MarkerId(place.placeId.toString()),
              position: place.location,
              icon: place.placeTypeId == 1 ? campsiteIcon : wildcampingIcon,
              onTap: () => add(MarkerTapped(place))))
          .toList();

      yield state.copyWith(markers: markers);
    }
    if (event is MarkerTapped) {
      yield state.copyWith(tappedPlace: event.place);
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
