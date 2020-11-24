import 'package:WildcamperMobile/Domain/repositories/IRatingsRepository.dart';
import 'package:WildcamperMobile/Infrastructure/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'AddReviewSectionEvent.dart';
import 'AddReviewSectionState.dart';

class AddReviewSectionBloc
    extends Bloc<AddReviewSectionEvent, AddReviewSectionState> {
  final int placeId;

  final IRatingsRepository _ratingsRepository =
      GetIt.instance<IRatingsRepository>();
  final UserProvider _userProvider = GetIt.instance<UserProvider>();
  String get userId => _userProvider.getCurrentUser().uid;

  AddReviewSectionBloc({@required this.placeId})
      : super(AddReviewSectionState.initial());

  @override
  Stream<AddReviewSectionState> mapEventToState(
      AddReviewSectionEvent event) async* {
    if (event is CommentChanged) {
      yield state.copyWith(comment: event.comment);
    }
    if (event is RatingChanged) {
      if (event.rating < 1 && event.rating > 5)
        throw Exception("Illegal value of rating");
      yield state.copyWith(rating: event.rating);
    }
    if (event is ReviewSubmitted) {
      if (state.isValid == false) {
        throw Exception("Illegal state of AddReviewSectionState");
      }
      var ratingId = await _ratingsRepository.addRating(
          userId, placeId, state.comment, state.rating.toInt());
    }
  }
}
