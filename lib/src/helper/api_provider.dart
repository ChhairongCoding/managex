import 'package:dio/dio.dart';

enum MethodType { post, get, put, delete }

class ApiProvider {
  final Dio _dio = Dio();

  Future<Response> request(
    String url,
    MethodType method, {
    dynamic data,
  }) async {
    switch (method) {
      case MethodType.post:
        return await _dio.post(url, data: data);
      case MethodType.get:
        return await _dio.get(url, data: data);
      case MethodType.put:
        return await _dio.put(url, data: data);
      case MethodType.delete:
        return await _dio.delete(url, data: data);
    }
  }

  Future<Response> get(String url) async {
    try {
      return await _dio.get(url);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.put(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> delete(String url, {Map<String, dynamic>? headers}) async {
    try {
      return await _dio.delete(url, options: Options(headers: headers));
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> uploadImage(String url, String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });
      return await _dio.post(url, data: formData);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
