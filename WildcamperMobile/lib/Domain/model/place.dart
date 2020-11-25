import 'dart:convert';
import 'dart:typed_data';

import 'package:WildcamperMobile/Data/DataAccess/DTO/ImageDto.dart';
import 'package:WildcamperMobile/Data/DataAccess/DTO/RatingDto.dart';
import 'package:WildcamperMobile/Domain/model/image.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:WildcamperMobile/Data/DataAccess/DTO/PlaceDto.dart';

import 'Rating.dart';

class Place {
  int placeId;
  String creatorId;
  String name;
  String description;
  List<Rating> ratings;
  List<Image> images;
  LatLng location;
  String country;
  String region;
  String city;
  Placemark placemark;
  Uint8List thumbnail;
  int placeTypeId;

  double get averageRating {
    if (ratings?.isEmpty ?? true) return 0;
    return ratings
            .map((r) => r.stars.toDouble())
            .reduce((value, element) => value + element) /
        ratings.length.toDouble();
  }

  Place(
      {this.placeId,
      this.creatorId,
      this.name,
      this.description,
      this.location,
      this.images,
      this.ratings,
      this.placemark,
      this.thumbnail,
      this.placeTypeId,
      this.city,
      this.region,
      this.country});

  factory Place.fromDto(PlaceDto dto,
      {List<ImageDto> imageDtos,
      List<RatingDto> ratingDtos,
      Placemark placemark}) {
    return Place(
        placeId: dto.placeId,
        creatorId: dto.creatorId,
        placeTypeId: dto.placeTypeId,
        name: dto.name,
        description: dto.description,
        location: LatLng(dto.latitude, dto.longitude),
        city: dto.city,
        region: dto.region,
        country: dto.country,
        images: imageDtos?.map((img) => Image.fromDto(img))?.toList(),
        ratings: ratingDtos?.map((rtg) => Rating.fromDto(rtg))?.toList(),
        placemark: placemark,
        thumbnail: base64Decode(dto.thumbnail));
  }
}
