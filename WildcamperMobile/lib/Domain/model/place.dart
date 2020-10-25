import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  int placeId;
  int ownerId;
  String name;
  String description;
  LatLng location;
  List<int> reviewIds;
  List<int> photoIds;

  Place(this.placeId, this.ownerId, this.name, this.location);
}
