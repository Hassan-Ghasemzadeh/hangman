// ignore_for_file: prefer_void_to_null

import 'package:flutter/material.dart';
import 'package:hemend/extensions/equalizer/equalizer.dart';

class RouteInfo<T> with EqualizerMixin {
  final String route;
  final WidgetBuilder builder;
  final Type paramsType = T;
  late final bool hasParams = paramsType != Null;
  RouteInfo(
    this.route,
    this.builder,
  );

  @override
  List get equalCheckItems => [
        route,
        builder,
        paramsType,
      ];

  static RouteInfo<Null> noParamsRoute(
    String route,
    WidgetBuilder builder,
  ) =>
      RouteInfo<Null>(route, builder);
}
