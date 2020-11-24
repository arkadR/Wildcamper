import 'dart:convert';
import 'dart:typed_data';

import 'package:WildcamperMobile/Data/DataAccess/DTO/ImageDto.dart';

class Image {
  int photoId;
  int placeId;
  String creatorId;
  Uint8List bytes;
  Image({
    this.photoId,
    this.placeId,
    this.creatorId,
    this.bytes,
  });

  factory Image.fromDto(ImageDto dto) {
    return Image(
        photoId: dto.imageId,
        creatorId: dto.creatorId,
        placeId: dto.placeId,
        bytes: base64Decode(dto.bytes));
  }
}
