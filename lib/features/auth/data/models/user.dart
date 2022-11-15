import 'dart:convert';

import 'package:hangman/core/http_service_config/api_result.dart';

class User extends APIResult {
  final String token;

  User({
    required super.statusCode,
    required super.statusMessage,
    required this.token,
  }) : super([
          token,
        ]);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user_name': token});
    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['user_name'].toString(),
      statusCode: map['status_code'].toString(),
      statusMessage: map['status_message'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'user_name: $token,';
}
