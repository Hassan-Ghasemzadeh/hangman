import 'package:get_it/get_it.dart';
import 'package:hangman/features/question/data/models/letter.dart';

import '../../../../core/usecase_tool/usecase_tool.dart';
import '../../data/repositories/question_repository_impl.dart';

class GetLettersUsecase extends IUseCase<Letter, String> {
  QuestionRepository get source => GetIt.I.get<QuestionRepository>();
  @override
  Future<Letter> invoke(String params) {
    return source.getLetter(params);
  }
}
