import 'package:WildcamperMobile/Domain/model/place.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapScreenEvent extends Equatable {
  const MapScreenEvent();

  @override
  List<Object> get props => [];
}

class MapLoaded extends MapScreenEvent {
  final GoogleMapController controller;

  MapLoaded({this.controller});

  @override
  List<Object> get props => [controller];
}

class LocationLoaded extends MapScreenEvent {
  final LatLng location;

  LocationLoaded({this.location});

  @override
  List<Object> get props => [location];
}

class PlacesLoaded extends MapScreenEvent {
  final List<Place> places;

  PlacesLoaded({this.places});

  @override
  List<Object> get props => [places];
}

class CameraMoved extends MapScreenEvent {
  final CameraPosition cameraPosition;

  CameraMoved({this.cameraPosition});

  @override
  List<Object> get props => [cameraPosition];
}
