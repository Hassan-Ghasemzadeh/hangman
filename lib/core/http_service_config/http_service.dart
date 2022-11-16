import 'package:dio/dio.dart';
import '../shared_pref_config/shared_pref_config.dart';

abstract class IHttpService {
  Future<Response> postRequest(String endPoint);
  Future<Response> post(String endPoint, FormData data);
  Future<Response> getRequest(String endPoint);
}

class HttpService extends IHttpService {
  late Dio _dio;
  static const baseUrl = 'http://192.168.1.7:8080';
  HttpService() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: 20000,
        receiveTimeout: 20000,
        baseUrl: baseUrl,
      ),
    );
  }

  void updateDio(String token) {
    _dio = Dio(
      BaseOptions(
        connectTimeout: 20000,
        receiveTimeout: 20000,
        baseUrl: baseUrl,
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  HttpService.withDio(this._dio);
  static Future<HttpService> authReq() async {
    final token = getData('token');
    final dio = Dio(
      BaseOptions(
        connectTimeout: 20000,
        receiveTimeout: 20000,
        baseUrl: baseUrl,
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    // initializeInterceptors();
    return HttpService.withDio(dio);
  }

  @override
  Future<Response> postRequest(String endPoint) async {
    late Response response;
    try {
      response = await _dio.post(endPoint);
    } catch (e) {
      rethrow;
    }

    return response;
  }

  @override
  Future<Response> post(String endPoint, [dynamic data]) async {
    late Response response;

    final token = getData('token');
    response = await _dio.post(
      endPoint,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response;
  }

  @override
  Future<Response> getRequest(
    String endPoint,
  ) async {
    late Response response;
    try {
      response = await _dio.get(
        endPoint,
      );
    } catch (e) {
      rethrow;
    }

    return response;
  }
}
