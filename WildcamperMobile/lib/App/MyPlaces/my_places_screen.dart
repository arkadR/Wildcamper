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
        itemBuilder: (context, index) {
          final item = _places[index];
          return Card(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            ListTile(
                leading: Icon(Icons.access_alarm),
                title: Text(item.name),
                subtitle: Text(item.placeId.toString()))
          ]));
        });
  }
}
