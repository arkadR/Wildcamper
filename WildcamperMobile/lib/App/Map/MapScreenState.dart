import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenState extends Equatable {
  final List<Marker> markers;
  final LatLng currentLocation;
  final double currentZoom;
  MapScreenState({
    this.markers,
    this.currentLocation,
    this.currentZoom,
  });

  MapScreenState copyWith({
    List<Marker> markers,
    LatLng currentLocation,
    LatLngBounds currentBounds,
    double currentZoom,
  }) {
    return MapScreenState(
      markers: markers ?? this.markers,
      currentLocation: currentLocation ?? this.currentLocation,
      currentZoom: currentZoom ?? this.currentZoom,
    );
  }

  factory MapScreenState.initial(double zoom) {
    return MapScreenState(
        markers: List(), currentLocation: null, currentZoom: zoom);
  }

  @override
  List<Object> get props => [markers, currentLocation, currentZoom];
}
