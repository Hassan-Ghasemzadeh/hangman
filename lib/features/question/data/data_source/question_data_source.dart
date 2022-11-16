import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hangman/core/http_service_config/http_service.dart';
import 'package:hangman/features/question/data/models/letter.dart';
import 'package:hangman/features/question/data/models/messed_up_question.dart';
import 'package:hemend/crash_handler/crash_handler.dart';

import '../../domain/repositories/question_repository.dart';

class QuestionDataSource extends IQuestionRepository {
  HttpService get http => GetIt.I.get<HttpService>();

  @override
  Future<MessedUpQuestion> getMessedUpQuestion(String category) async {
    final response = await CrashHandler.I.tryAsync<Response>(() async {
      const endPoint = '/user/getMessedUpQuestion';
      return http.post(
        endPoint,
        {
          "category": category,
        },
      );
    });
    final exception = response.exception;

    if (exception is DioError) {
      return MessedUpQuestion(
        statusCode: response.data?.statusCode.toString() ??
            exception.response!.statusCode.toString(),
        statusMessage: exception.error ?? response.data!.statusMessage,
        question: QuestionModel.empty(),
      );
    } else {
      return MessedUpQuestion.fromMap(
        response.data!.data,
      );
    }
  }

  @override
  Future<Letter> getLetter(String category) async {
    final response = await CrashHandler.I.tryAsync<Response>(() async {
      const endPoint = '/user/getLetters';
      return http.post(
        endPoint,
        {
          "category": category,
        },
      );
    });
    final exception = response.exception;

    if (exception is DioError) {
      return Letter(
        statusCode: response.data?.statusCode.toString() ??
            exception.response!.statusCode.toString(),
        statusMessage: exception.error ?? response.data!.statusMessage,
        letters: const [],
      );
    } else {
      return Letter.fromMap(
        response.data!.data,
      );
    }
  }
}
