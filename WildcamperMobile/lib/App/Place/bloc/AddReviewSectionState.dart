import 'package:equatable/equatable.dart';

class AddReviewSectionState extends Equatable {
  final String comment;
  final double rating;
  AddReviewSectionState({
    this.comment,
    this.rating,
  });

  bool get isValid => comment.length > 0 && rating > 0 && rating < 6;

  factory AddReviewSectionState.initial() =>
      AddReviewSectionState(comment: "", rating: 0);

  AddReviewSectionState copyWith({
    String comment,
    double rating,
  }) {
    return AddReviewSectionState(
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
    );
  }

  @override
  List<Object> get props => [comment, rating];
}
