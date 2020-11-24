import 'package:WildcamperMobile/App/Place/bloc/AddReviewSectionEvent.dart';
import 'package:WildcamperMobile/Domain/model/Place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'bloc/AddReviewSectionBloc.dart';
import 'bloc/AddReviewSectionState.dart';

class AddReviewSection extends StatelessWidget {
  final Place place;

  const AddReviewSection({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddReviewSectionBloc bloc(BuildContext ctx) =>
        BlocProvider.of<AddReviewSectionBloc>(ctx);

    return SliverToBoxAdapter(
        child: BlocProvider<AddReviewSectionBloc>(
      create: (context) => AddReviewSectionBloc(placeId: place.placeId),
      child: BlocBuilder<AddReviewSectionBloc, AddReviewSectionState>(
        builder: (context, state) {
          return Padding(
              padding: EdgeInsets.all(16),
              child: Card(
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Rate this place',
                                textScaleFactor: 1.5,
                              )),
                          SizedBox(height: 10),
                          RatingBar.builder(
                            minRating: 1,
                            direction: Axis.horizontal,
                            //  allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              bloc(context).add(RatingChanged(rating: rating));
                            },
                          ),
                          TextField(
                              decoration: InputDecoration(
                                  hintText: 'Add a comment',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1))),
                              minLines: 1,
                              maxLines: 5,
                              maxLengthEnforced: true,
                              onChanged: (description) => bloc(context)
                                  .add(CommentChanged(comment: description))),
                          RaisedButton(
                              onPressed: state.isValid
                                  ? () => bloc(context).add(ReviewSubmitted())
                                  : null,
                              child: Text("Submit"))
                        ],
                      ))));
        },
      ),
    ));
  }
}
