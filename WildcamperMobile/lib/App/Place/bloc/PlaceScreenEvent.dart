part of 'PlaceScreenBloc.dart';

abstract class PlaceScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaceLoaded extends PlaceScreenEvent {
  final Place place;

  PlaceLoaded(this.place);

  @override
  List<Object> get props => [place];
}

class DistanceCalculated extends PlaceScreenEvent {
  final double distance;

  DistanceCalculated(this.distance);

  @override
  List<Object> get props => [distance];
}
