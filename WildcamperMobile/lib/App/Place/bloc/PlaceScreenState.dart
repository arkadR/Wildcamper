part of 'PlaceScreenBloc.dart';

class PlaceScreenState extends Equatable {
  final Place place;
  final double distance;
  PlaceScreenState({
    this.place,
    this.distance,
  });

  String get street => place.placemark.street;
  String get city =>
      "${place.placemark.isoCountryCode} ${place.placemark.postalCode}, ${place.placemark.locality}";
  String get region =>
      "${place.placemark.subAdministrativeArea.sentenceCase}, ${place.placemark.administrativeArea.sentenceCase}";
  String get distanceText {
    if (distance == null) return "";
    if (distance < 1000) return "${(distance ~/ 10) * 10} m";
    if (distance < 10000) return "${(distance / 1000).toStringAsFixed(1)} km";
    return "${distance ~/ 1000} km";
  }

  static PlaceScreenState initial() {
    return PlaceScreenState(place: null, distance: null);
  }

  PlaceScreenState copyWith({
    Place place,
    double distance,
  }) {
    return PlaceScreenState(
      place: place ?? this.place,
      distance: distance ?? this.distance,
    );
  }

  @override
  List<Object> get props => [place, distance];
}
