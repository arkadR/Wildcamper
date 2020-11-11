import 'package:equatable/equatable.dart';

abstract class AddReviewSectionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CommentChanged extends AddReviewSectionEvent {
  final String comment;

  CommentChanged({this.comment});

  @override
  List<Object> get props => [comment];
}

class RatingChanged extends AddReviewSectionEvent {
  final double rating;

  RatingChanged({this.rating});

  @override
  List<Object> get props => [rating];
}

class ReviewSubmitted extends AddReviewSectionEvent {}
