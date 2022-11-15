// ignore_for_file: prefer_void_to_null

import 'package:hemend/extensions/equalizer/equalizer.dart';

class RouteParams<T> with EqualizerMixin {
  final T value;

  const RouteParams(this.value);

  @override
  List get equalCheckItems => [
        value,
      ];
  static RouteParams<Null> empty() => EmptyRouteParams();
}

class EmptyRouteParams extends RouteParams<Null> {
  EmptyRouteParams() : super(null);
}
