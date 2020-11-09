import 'package:WildcamperMobile/Data/DataAccess/DTO/ImageDto.dart';
import 'package:WildcamperMobile/Domain/model/image.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:WildcamperMobile/Data/DataAccess/DTO/PlaceDto.dart';

class Place {
  int placeId;
  int creatorId;
  String name;
  String description;
  List<int> reviewIds;
  List<Image> images;
  LatLng location;
  Placemark placemark;

  Place(
      {this.placeId,
      this.creatorId,
      this.name,
      this.description,
      this.reviewIds,
      this.location,
      this.images,
      this.placemark});

  factory Place.fromDto(PlaceDto dto,
      {List<ImageDto> imageDtos, Placemark placemark}) {
    return Place(
        placeId: dto.placeId,
        creatorId: dto.creatorId,
        name: dto.name,
        description: dto.description,
        location: LatLng(dto.latitude, dto.longitude),
        images: imageDtos?.map((img) => Image.fromDto(img))?.toList(),
        placemark: placemark);
  }
}
