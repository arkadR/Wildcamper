import 'dart:ui';

import 'package:WildcamperMobile/App/Place/PlaceScreen.dart';
import 'package:WildcamperMobile/Domain/model/Place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PlacePreview extends StatelessWidget {
  final Place place;

  const PlacePreview({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Container(
                width: 150,
                child: Image.memory(
                  place.thumbnail,
                  fit: BoxFit.fitWidth,
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBarIndicator(
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      direction: Axis.horizontal,
                      rating: place.averageRating,
                      itemCount: 5,
                      itemSize: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      place.name,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Center(
                        child: FlatButton(
                            textColor: Colors.green,
                            child: const Text('More details',
                                textScaleFactor: 1.1),
                            onPressed: () {
                              Navigator.pop(context);
                              return Navigator.of(context)
                                  .push(_createRoute(place.placeId));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Route _createRoute(int placeId) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PlaceScreen(placeId: placeId),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
