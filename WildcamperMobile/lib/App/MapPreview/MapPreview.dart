import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'bloc/MapPreviewBloc.dart';

class MapPreview extends StatelessWidget {
  final LatLng location;
  const MapPreview({
    Key key,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapPreviewBloc>(
        create: (context) => MapPreviewBloc(),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: location, zoom: 15),
          compassEnabled: false,
          markers:
              [Marker(markerId: MarkerId("id"), position: location)].toSet(),
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
          myLocationEnabled: true,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          mapType: MapType.satellite,
        ));
  }
}
