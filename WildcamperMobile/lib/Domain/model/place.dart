import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  int placeId;
  int ownerId;
  String name;
  String description;
  LatLng location;
  List<int> reviewIds;
  List<int> photoIds;
  List<String> photoPathsDev;

  Place(this.placeId, this.ownerId, this.name, this.location,
      {this.description, this.photoPathsDev});
}
