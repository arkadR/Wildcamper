import 'package:WildcamperMobile/App/Place/place_screen.dart';
import 'package:WildcamperMobile/Domain/model/place.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyPlacesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPlacesScreenState();
}

class _MyPlacesScreenState extends State<MyPlacesScreen> {
  final _placesRepository = GetIt.instance<IPlacesRepository>();
  List<Place> _places = List<Place>();

  @override
  initState() {
    super.initState();
    _placesRepository
        .getMyPlaces()
        .then((places) => setState(() => _places = places));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _places.length,
        itemBuilder: (context, index) => PlaceCard(place: _places[index]));
  }
}

class PlaceCard extends StatelessWidget {
  final Place place;
  PlaceCard({this.place});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(
            leading: Icon(Icons.access_alarm),
            title: Text(place.name),
            subtitle: Text(place.placeId.toString()))
      ])),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlaceScreen(placeId: place.placeId)));
      },
    );
  }
}
