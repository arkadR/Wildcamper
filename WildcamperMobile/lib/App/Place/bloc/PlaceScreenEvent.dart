part of 'PlaceScreenBloc.dart';

abstract class PlaceScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaceLoadRequested extends PlaceScreenEvent {}

class PlaceLoaded extends PlaceScreenEvent {
  final Place place;

  PlaceLoaded(this.place);

  @override
  List<Object> get props => [place];
}

class ReviewRemoved extends PlaceScreenEvent {
  final int reviewId;

  ReviewRemoved(this.reviewId);

  @override
  List<Object> get props => [reviewId];
}

class UsersLoaded extends PlaceScreenEvent {
  final List<User> users;

  UsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class DistanceCalculated extends PlaceScreenEvent {
  final double distance;

  DistanceCalculated(this.distance);

  @override
  List<Object> get props => [distance];
}
