import 'dart:convert';

import 'package:hangman/core/http_service_config/api_result.dart';
import 'package:hemend/extensions/equalizer/equalizer.dart';

class MessedUpQuestion extends APIResult {
  final QuestionModel question;
  MessedUpQuestion({
    required this.question,
    required super.statusCode,
    required super.statusMessage,
  }) : super([
          question,
        ]);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'question': question.toMap()});

    return result;
  }

  factory MessedUpQuestion.fromMap(Map<String, dynamic> map) {
    return MessedUpQuestion(
      question: QuestionModel.fromMap(map['question']),
      statusCode: map['status_code'].toString(),
      statusMessage: map['status_message'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessedUpQuestion.fromJson(String source) =>
      MessedUpQuestion.fromMap(json.decode(source));

  @override
  String toString() => 'question: $question';
}

class QuestionModel with EqualizerMixin {
  final String title;
  final String category;
  QuestionModel({
    required this.title,
    required this.category,
  });

  QuestionModel copyWith({
    String? title,
    String? category,
  }) {
    return QuestionModel(
      title: title ?? this.title,
      category: category ?? this.category,
    );
  }

  static QuestionModel empty() => QuestionModel(category: '', title: '');
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'category': category});

    return result;
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      title: map['title'].toString(),
      category: map['category'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source));

  @override
  String toString() => 'title: $title, category: $category';

  @override
  List get equalCheckItems => [
        title,
        category,
      ];
}
