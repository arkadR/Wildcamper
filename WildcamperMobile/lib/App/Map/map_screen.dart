import 'dart:async';

import 'package:WildcamperMobile/App/AddPlace/add_place_screen.dart';
import 'package:WildcamperMobile/App/Map/map_marker.dart';
import 'package:WildcamperMobile/Domain/repositories/places_repository.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final _sharedPrefs = GetIt.instance<SharedPreferences>();
  final _placesRepository = GetIt.instance<IPlacesRepository>();
  Completer<GoogleMapController> _controller = Completer();
  Location _location = Location();

  List<Marker> _markers = List<Marker>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    _location.onLocationChanged.first.then((data) async {
      var controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(data.latitude, data.longitude), zoom: 15)));
    });
    var places = await _placesRepository.getAllPlaces();
    var markers = places.map((place) => Marker(
        markerId: MarkerId(place.placeId.toString()),
        position: place.location));
    setState(() {
      _markers.addAll(markers);
    });
  }

  @override
  Widget build(BuildContext context) {
    var latLng = _sharedPrefs.getString('map_bounds');
    var zoom = _sharedPrefs.getDouble('map_zoom');
    CameraPosition initialPosition = _kGooglePlex;
    if (latLng != null) {
      initialPosition =
          CameraPosition(target: LatLng.fromJson(latLng), zoom: zoom ?? 15);
    }
    return new GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        compassEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers.toSet(),
        onLongPress: (latLng) => showDialog(
            context: context,
            builder: (dialogContext) => AlertDialog(
                  title: Text("Do you want to add a marker at this place?"),
                  actions: [
                    FlatButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: Text("Cancel")),
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          Navigator.of(context)
                              .push(_createAddPlaceRoute(latLng));
                        },
                        child: Text("Yes"))
                  ],
                ),
            barrierDismissible: false));
  }

  //TODO: This does not work (async dispose)
  Future<bool> saveShit() async {
    super.deactivate();
    var controller = await _controller.future;
    var latLng = (await controller.getVisibleRegion());
    var zoom = await controller.getZoomLevel();

    await _sharedPrefs.setString('map_bounds', latLng.toJson());
    await _sharedPrefs.setDouble('map_zoom', zoom);

    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLongPress(LatLng location) {
    setState(() {
      var marker = Marker(
          markerId: MarkerId(UniqueKey().toString()), position: location);
      _markers.add(marker);
    });
  }

  Route _createAddPlaceRoute(LatLng location) {
    return MaterialPageRoute(
        builder: (context) => AddPlaceScreen(location: location));
  }
}
