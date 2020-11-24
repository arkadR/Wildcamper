import 'package:WildcamperMobile/App/Place/PlaceScreen.dart';
import 'package:WildcamperMobile/Domain/model/Place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  final Function onRemoveTapped;
  PlaceCard({this.place, this.onRemoveTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Row(
                  children: [
                    Text(
                      place.name,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onRemoveTapped != null
                        ? Expanded(
                            child: Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                    onTap: onRemoveTapped,
                                    child: Icon(Icons.delete_forever))))
                        : SizedBox()
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      place.description,
                    ),
                  )),
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          constraints: BoxConstraints(maxHeight: 100),
                          width: 150,
                          child: Image.memory(
                            place.thumbnail,
                            fit: BoxFit.fitWidth,
                          ))),
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "${place.ratings?.length ?? 0} people have reviewed this place",
                      textScaleFactor: 0.7,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 150,
                          child: RatingBarIndicator(
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            direction: Axis.horizontal,
                            rating: place.averageRating,
                            itemCount: 5,
                            itemSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]))),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlaceScreen(placeId: place.placeId)));
      },
    );
  }
}
