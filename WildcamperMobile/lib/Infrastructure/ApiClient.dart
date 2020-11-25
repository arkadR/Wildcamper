import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class ApiClient {
  final Dio _dio = GetIt.instance<Dio>();
  final String _basePath = 'https://192.168.0.103:44310/';

  Future<Response<T>> get<T>(String path) async {
    return await _dio.get<T>("$_basePath$path");
  }

  Future<Response<T>> post<T>(String path, dynamic data) async {
    return await _dio.post<T>("$_basePath$path", data: data);
  }

  Future<Response<T>> delete<T>(String path) async {
    return await _dio.delete<T>("$_basePath$path");
  }

  Future<Response<T>> patch<T>(String path, dynamic data) async {
    return await _dio.patch<T>("$_basePath$path", data: data);
  }
}
