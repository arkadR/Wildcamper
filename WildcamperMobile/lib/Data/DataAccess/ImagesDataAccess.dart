import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'DTO/ImageDto.dart';

class ImagesDataAccess {
  final Dio _dio = GetIt.instance<Dio>();
  final String _basePath = 'https://192.168.0.104:44310/';

  Future<List<ImageDto>> getAllImages() async {
    var response = await _dio.get("${_basePath}odata/images");
    var images = (response.data as List).map((obj) => ImageDto.fromMap(obj));
    return images;
  }

  Future<ImageDto> getImageById(int id) async {
    var response = await _dio.get("${_basePath}odata/images/$id");
    var image = ImageDto.fromMap(response.data);
    return image;
  }

  Future<int> addImage(ImageDto dto) async {
    var body = jsonDecode(jsonEncode(dto));
    var response = await _dio.post("${_basePath}odata/images", data: body);
    return response.data['ImageId'];
  }
}
