import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hangman/core/nav_tools/route_info_models.dart';
import 'package:hangman/features/auth/presentation/widgets/login.dart';
import 'package:hangman/features/auth/presentation/widgets/sign_up.dart';
import 'package:hangman/features/question/presentation/pages/question_page.dart';

import '../../features/auth/data/models/user.dart';
import '../../features/auth/presentation/pages/auth.dart';
import '../../features/home/presentation/pages/home.dart';
import '../get_it_config/get_it_config.dart';

BuildContext get _context =>
    GetIt.I.get(instanceName: GetItScopes.navigator.name);

NavigatorState get navigator => Navigator.of(_context);

enum AppRoute {
  landing('/'),
  home('/home'),
  login('/login'),
  signUp('/signUp'),
  question('/question'),
  ;

  const AppRoute(this.path);

  final String path;

  RouteInfo get route => appRoutes.get(this);
}

final Map<AppRoute, RouteInfo> appRoutes = {
  AppRoute.home: RouteInfo<User>(
    AppRoute.home.path,
    (context) => const HomePage(),
  ),
  AppRoute.landing: RouteInfo.noParamsRoute(
    AppRoute.landing.path,
    (context) => const AuthPage(),
  ),
  AppRoute.login: RouteInfo.noParamsRoute(
    AppRoute.login.path,
    (context) => const LoginPage(),
  ),
  AppRoute.signUp: RouteInfo.noParamsRoute(
    AppRoute.signUp.path,
    (context) => const SignUp(),
  ),
  AppRoute.question: RouteInfo<String>(
    AppRoute.question.path,
    (context) => const QuestionPage(),
  ),
};

extension SafeValue<T, R> on Map<T, R> {
  R get(T key, {R? defaultValue}) {
    final result = this[key];
    if (result == null) {
      if (defaultValue != null) {
        return defaultValue;
      } else {
        throw 'map does not have value for $key and no default value provided';
      }
    }
    return result;
  }
}
