import 'package:get_it/get_it.dart';
import 'package:hangman/core/usecase_tool/usecase_tool.dart';
import 'package:hangman/features/question/data/models/messed_up_question.dart';

import '../../data/repositories/question_repository_impl.dart';

class GetMessedUpQuestionUsecase extends IUseCase<MessedUpQuestion, String> {
  QuestionRepository get source => GetIt.I.get<QuestionRepository>();
  @override
  Future<MessedUpQuestion> invoke(String params) {
    return source.getMessedUpQuestion(params);
  }
}
