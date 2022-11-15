import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hangman/features/auth/data/data_source/user_data_source.dart';
import 'package:hangman/features/auth/data/repositories/user_repository_impl.dart';
import 'package:hangman/features/home/data/data_source/home_data_source.dart';
import 'package:hangman/features/home/data/repositories/home_repository_impl.dart';
import 'package:hangman/features/question/data/data_source/question_data_source.dart';
import 'package:hangman/features/question/data/repositories/question_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_service_config/http_service.dart';

enum GetItScopes {
  global,
  navigator;

  const GetItScopes();
}

Future<void> getItInitialRegistration() async {
  final globalKey = GlobalKey<NavigatorState>();
  GetIt.I.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  GetIt.I.registerSingleton(
    globalKey,
    instanceName: GetItScopes.navigator.name,
  );
  GetIt.I.registerLazySingleton<BuildContext>(
    () {
      if (globalKey.currentState?.overlay == null) {
        throw Exception('cannot get current state overlay');
      }
      return globalKey.currentState!.overlay!.context;
    },
    instanceName: GetItScopes.navigator.name,
  );
  GetIt.I.registerSingleton<HttpService>(
    await HttpService.authReq(),
  );
  GetIt.I.registerSingleton<UserRepository>(
    UserRepository(
      source: UserDataSource(),
    ),
  );
  GetIt.I.registerSingleton<HomeRepository>(
    HomeRepository(
      source: HomeDataSource(),
    ),
  );
  GetIt.I.registerSingleton<QuestionRepository>(
    QuestionRepository(
      source: QuestionDataSource(),
    ),
  );
}
