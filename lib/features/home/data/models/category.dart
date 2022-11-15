import 'dart:convert';
import 'package:hangman/core/http_service_config/api_result.dart';

class Category extends APIResult {
  final List<String> categories;
  Category({
    required this.categories,
    required super.statusCode,
    required super.statusMessage,
  }) : super([...categories]);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'categories': categories});

    return result;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categories: List<String>.from(map['categories']),
      statusCode: map['status_code'].toString(),
      statusMessage: map['status_message'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() => 'categories: $categories';
}
