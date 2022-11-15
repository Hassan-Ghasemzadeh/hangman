import 'package:flutter/material.dart';
import 'package:hemend/debug/error_handler.dart';

import 'nav_tools.dart';
import 'route_info_models.dart';
import 'route_params_models.dart';

class ChangeRouteRequest<T> {
  final RouteInfo<T?> requestedRoute;
  final RouteParams<T?> routeParams;
  late final bool isValid =
      requestedRoute.paramsType == routeParams.value.runtimeType;
  Future<R?> dispatch<R>(
      [ChangeRouteType changeRouteType = ChangeRouteType.push]) async {
    //   if (!isValid) {
    //     throw ErrorHandler(
    //       '''given params is not valid for requested route params type,
    // expected : ${requestedRoute.paramsType},
    // actual : ${routeParams.value.runtimeType}''',
    //       {
    //         ErrorType.typeError,
    //       },
    //     );
    //   }
    R? result;
    switch (changeRouteType) {
      case ChangeRouteType.push:
        result = await navigator.pushNamed(
          requestedRoute.route,
          arguments: routeParams,
        );
        break;
      case ChangeRouteType.replace:
        result = await navigator.pushReplacementNamed(
          requestedRoute.route,
          arguments: routeParams,
        );
        break;

      default:
        throw const ErrorHandler(
          'given change route type is not valid',
          {
            ErrorType.paramsError,
          },
        );
    }
    if (result is! R) {
      throw ErrorHandler('''result of route ${requestedRoute.route} is not valid
  expected : $R
  actual : ${result.runtimeType}''', {
        ErrorType.typeError,
      });
    }
    return result;
  }

  ChangeRouteRequest(
    this.requestedRoute, [
    RouteParams<T>? params,
  ]) : routeParams = params ?? RouteParams.empty();
}

enum ChangeRouteType {
  push,
  replace,
  // pop,
  // popToRoot,
}

class ShowDialogRequest<R> {
  final Widget child;
  final BuildContext? context;
  ShowDialogRequest({
    this.context,
    required this.child,
  });
  Future<R> dispatch({
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) async {
    final result = await showDialog(
      context: context ?? navigator.context,
      builder: (context) => child,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
    );
    if (result is! R) {
      throw ErrorHandler('''result of dialog is not valid
  expected : $R
  actual : ${result.runtimeType}''', {
        ErrorType.typeError,
      });
    }
    return result;
  }

  // ignore: prefer_void_to_null
  static ShowDialogRequest<Null> noResponseDialog({
    BuildContext? context,
    required Widget child,
  }) =>
      // ignore: prefer_void_to_null
      ShowDialogRequest<Null>(
        child: child,
        context: context,
      );
}
