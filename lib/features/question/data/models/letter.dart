import 'dart:convert';

import 'package:hangman/core/http_service_config/api_result.dart';

class Letter extends APIResult {
  final List<String> letters;
  Letter({
    required this.letters,
    required super.statusCode,
    required super.statusMessage,
  }) : super([
          ...letters,
        ]);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'letters': letters});

    return result;
  }

  factory Letter.fromMap(Map<String, dynamic> map) {
    return Letter(
      letters: List<String>.from(map['letters']),
      statusCode: map['status_code'].toString(),
      statusMessage: map['status_message'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Letter.fromJson(String source) => Letter.fromMap(json.decode(source));
}
