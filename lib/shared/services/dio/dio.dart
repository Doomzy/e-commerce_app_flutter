import 'package:dio/dio.dart';

class DioHelper {
  static var dio = Dio();

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queries,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
      'lang': 'en'
    };
    return await dio.get(
      url,
      queryParameters: queries,
    );
  }

  static Future<Response> postData({
    required String url,
    required data,
    Map<String, dynamic>? queries,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
      'lang': 'en'
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: queries,
    );
  }

  static Future<Response> putData({
    required String url,
    required data,
    Map<String, dynamic>? queries,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
      'lang': 'en'
    };
    return await dio.put(
      url,
      data: data,
      queryParameters: queries,
    );
  }
}
