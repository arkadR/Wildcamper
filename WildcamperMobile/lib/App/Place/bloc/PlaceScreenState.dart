part of 'PlaceScreenBloc.dart';

class PlaceScreenState extends Equatable {
  final Place place;
  final double distance;
  final bool showAddRating;
  final List<User> users;
  PlaceScreenState({this.place, this.distance, this.showAddRating, this.users});

  String get street => place.placemark?.street;
  String get city => place.placemark?.city;
  String get region => place.placemark?.region;
  String get distanceText {
    if (distance == null) return "";
    if (distance < 1000) return "${(distance ~/ 10) * 10} m";
    if (distance < 10000) return "${(distance / 1000).toStringAsFixed(1)} km";
    return "${distance ~/ 1000} km";
  }

  static PlaceScreenState initial() {
    return PlaceScreenState(
        place: null, distance: null, showAddRating: false, users: null);
  }

  PlaceScreenState copyWith(
      {Place place, double distance, bool showAddRating, List<User> users}) {
    return PlaceScreenState(
        place: place ?? this.place,
        distance: distance ?? this.distance,
        showAddRating: showAddRating ?? this.showAddRating,
        users: users ?? this.users);
  }

  @override
  List<Object> get props => [place, distance, users];
}
