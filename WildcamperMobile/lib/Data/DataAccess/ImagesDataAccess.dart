import 'dart:convert';

import 'package:WildcamperMobile/Infrastructure/ApiClient.dart';
import 'package:get_it/get_it.dart';

import 'DTO/ImageDto.dart';

class ImagesDataAccess {
  final ApiClient _apiClient = GetIt.instance<ApiClient>();

  Future<List<ImageDto>> getAllImages() async {
    var response = await _apiClient.get("odata/images");
    var images = (response.data as List).map((obj) => ImageDto.fromMap(obj));
    return images;
  }

  Future<ImageDto> getImageById(int id) async {
    var response = await _apiClient.get("odata/images/$id");
    var image = ImageDto.fromMap(response.data);
    return image;
  }

  Future<int> addImage(ImageDto dto) async {
    var body = jsonDecode(jsonEncode(dto));
    var response = await _apiClient.post("odata/images", body);
    return response.data['ImageId'];
  }
}
