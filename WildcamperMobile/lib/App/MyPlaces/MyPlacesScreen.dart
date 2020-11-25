import 'package:WildcamperMobile/App/PlaceCard/PlaceCard.dart';
import 'package:WildcamperMobile/App/Places/EditPlace/EditPlaceScreen.dart';
import 'package:WildcamperMobile/Domain/model/Place.dart';
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
    _loadPlaces();
  }

  void _loadPlaces() {
    _placesRepository
        .getMyPlaces()
        .then((places) => setState(() => _places = places));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.builder(
              itemCount: _places.length,
              itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: PlaceCard(
                    place: _places[index],
                    onRemoveTapped: () => showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                              title: Text(
                                  "Are you sure you want to  remove this place?"),
                              content: Text(
                                  "This action is irreversible. The place along tih it's reviews will be removed forever."),
                              actions: [
                                FlatButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext),
                                    child: Text("Cancel")),
                                FlatButton(
                                    onPressed: () async {
                                      Navigator.pop(dialogContext);
                                      await _placesRepository
                                          .removePlace(_places[index]);
                                      _loadPlaces();
                                    },
                                    child: Text("Yes"))
                              ],
                            ),
                        barrierDismissible: false),
                    onEditTapped: () async {
                      var place = await _placesRepository
                          .getPlaceById(_places[index].placeId);
                      return Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditPlaceScreen(place: place)))
                          .then((value) => _loadPlaces());
                    },
                  )))),
    );
  }
}
