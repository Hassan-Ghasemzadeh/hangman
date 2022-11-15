import 'package:equatable/equatable.dart';

abstract class APIResult extends Equatable {
  final String statusCode;
  final String statusMessage;
  bool get isOk => statusCode == '200';
  APIResult(
    List<Object?> props, {
    required this.statusCode,
    required this.statusMessage,
  }) : props = [
          ...props,
          statusCode,
          statusMessage,
        ];
  @override
  final List<Object?> props;
}
