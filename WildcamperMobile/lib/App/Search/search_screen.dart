import 'package:WildcamperMobile/App/MyPlaces/my_places_screen.dart';
import 'package:WildcamperMobile/Domain/model/place.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _placesRepository = GetIt.instance<IPlacesRepository>();
  final _searchController = TextEditingController();
  List<Place> _places = List<Place>();
  List<Place> _visiblePlaces = List<Place>();

  @override
  initState() {
    super.initState();
    _placesRepository.getAllPlaces().then((places) {
      _places = places;
      setState(() => _visiblePlaces.addAll(places));
    });
  }

  void _onSearchChanged(String value) {
    var filtered = _places.where(
        (place) => place.name.toLowerCase().contains(value.toLowerCase()));
    setState(() {
      _visiblePlaces.clear();
      _visiblePlaces.addAll(filtered);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)))),
            controller: _searchController,
            onChanged: _onSearchChanged),
      ),
      Expanded(
          child: ListView.builder(
              itemCount: _visiblePlaces.length,
              itemBuilder: (context, index) =>
                  PlaceCard(place: _visiblePlaces[index])))
    ]);
  }
}
