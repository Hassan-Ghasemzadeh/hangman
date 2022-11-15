import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hangman/core/http_service_config/http_service.dart';
import 'package:hangman/features/home/data/models/category.dart';
import 'package:hemend/crash_handler/crash_handler.dart';

import '../../domain/repositories/home_repository.dart';

class HomeDataSource extends IHomeRepository {
  HttpService get http => GetIt.I.get<HttpService>();
  @override
  Future<Category> getCategories() async {
    final response = await CrashHandler.I.tryAsync<Response>(() async {
      const endPoint = 'http://192.168.1.4:8080/user/getCategories';
      return http.getRequest(endPoint);
    });
    final exception = response.exception;

    if (exception is DioError) {
      return Category(
        categories: const [],
        statusCode: response.data?.statusCode.toString() ??
            exception.response!.statusCode.toString(),
        statusMessage: exception.error ?? response.data!.statusMessage,
      );
    } else {
      return Category.fromMap(
        response.data!.data,
      );
    }
  }
}
