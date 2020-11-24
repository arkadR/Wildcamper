import 'package:WildcamperMobile/Domain/model/Place.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenState extends Equatable {
  final List<Marker> markers;
  final LatLng currentLocation;
  final double currentZoom;
  final Place tappedPlace;
  MapScreenState(
      {this.markers, this.currentLocation, this.currentZoom, this.tappedPlace});

  MapScreenState copyWith(
      {List<Marker> markers,
      LatLng currentLocation,
      LatLngBounds currentBounds,
      double currentZoom,
      Place tappedPlace}) {
    return MapScreenState(
        markers: markers ?? this.markers,
        currentLocation: currentLocation ?? this.currentLocation,
        currentZoom: currentZoom ?? this.currentZoom,
        tappedPlace: tappedPlace ?? this.tappedPlace);
  }

  factory MapScreenState.initial(double zoom) {
    return MapScreenState(
        markers: List(),
        currentLocation: null,
        currentZoom: zoom,
        tappedPlace: null);
  }

  @override
  List<Object> get props =>
      [markers, currentLocation, currentZoom, tappedPlace];
}
