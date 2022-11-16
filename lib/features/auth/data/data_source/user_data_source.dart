import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hangman/features/auth/domain/repositories/user_repository.dart';
import 'package:hemend/crash_handler/crash_handler.dart';

import '../../../../core/http_service_config/http_service.dart';
import '../models/user.dart';

class UserDataSource extends IUserRepository {
  HttpService get http => GetIt.I.get<HttpService>();
  @override
  Future<User> loginUser(String name, String password) async {
    final response = await CrashHandler.I.tryAsync<Response>(
      () async {
        const endPoint = '/auth/login';
        return http.post(
          endPoint,
          {
            'user_name': name,
            'password': password,
          },
        );
      },
    );

    final exception = response.exception;
    if (exception is DioError) {
      return User(
        statusCode: response.data?.statusCode.toString() ??
            exception.response!.statusCode.toString(),
        statusMessage: exception.error ?? response.data!.statusMessage,
        token: '',
      );
    } else {
      return User.fromMap(
        response.data!.data,
      );
    }
  }

  @override
  Future<User> signUp(String name, String password) async {
    final response = await CrashHandler.I.tryAsync<Response>(
      () async {
        const endPoint = '/auth/signUp';
        return http.post(
          endPoint,
          {
            'user_name': name,
            'password': password,
          },
        );
      },
    );

    final exception = response.exception;
    if (exception is DioError) {
      return User(
        statusCode: response.data?.statusCode.toString() ??
            exception.response!.statusCode.toString(),
        statusMessage: exception.error ?? response.data!.statusMessage,
        token: '',
      );
    } else {
      return User.fromMap(
        response.data!.data,
      );
    }
  }
}
