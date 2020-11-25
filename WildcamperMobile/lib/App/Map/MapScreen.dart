import 'package:WildcamperMobile/App/AddPlace/AddPlaceScreen.dart';
import 'package:WildcamperMobile/App/Map/MapScreenBloc.dart';
import 'package:WildcamperMobile/App/Map/MapScreenEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'MapScreenState.dart';
import 'PlacePreview.dart';

class MapSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MapScreenBloc bloc(BuildContext ctx) => BlocProvider.of<MapScreenBloc>(ctx);

    return BlocProvider<MapScreenBloc>(
        create: (context) => MapScreenBloc(),
        child: BlocListener<MapScreenBloc, MapScreenState>(
            listenWhen: (previousState, state) =>
                previousState.tappedPlace != state.tappedPlace,
            listener: (context, state) {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (context) => PlacePreview(place: state.tappedPlace));
            },
            child: BlocBuilder<MapScreenBloc, MapScreenState>(
                builder: (context, state) {
              return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(0, 0), zoom: state.currentZoom),
                  onMapCreated: (controller) =>
                      bloc(context).add(MapLoaded(controller: controller)),
                  myLocationEnabled: true,
                  compassEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: state.markers.toSet(),
                  onCameraMove: (position) =>
                      bloc(context).add(CameraMoved(cameraPosition: position)),
                  onLongPress: (latLng) => showDialog(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                            title: Text(
                                "Do you want to add a marker at this place?"),
                            actions: [
                              FlatButton(
                                  onPressed: () => Navigator.pop(dialogContext),
                                  child: Text("Cancel")),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                    Navigator.of(context)
                                        .push(_createAddPlaceRoute(latLng))
                                        .then((value) => bloc(context)
                                            .add(PlaceLoadRequested()));
                                  },
                                  child: Text("Yes"))
                            ],
                          ),
                      barrierDismissible: false));
            })));
  }

  //TODO: This does not work (async dispose)
  // Future<bool> saveShit() async {
  //   super.deactivate();
  //   var controller = await _controller.future;
  //   var latLng = (await controller.getVisibleRegion());
  //   var zoom = await controller.getZoomLevel();

  //   await _sharedPrefs.setString('map_bounds', latLng.toJson());
  //   await _sharedPrefs.setDouble('map_zoom', zoom);

  //   return true;
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  Route _createAddPlaceRoute(LatLng location) {
    return MaterialPageRoute(
        builder: (context) => AddPlaceScreen(location: location));
  }
}
