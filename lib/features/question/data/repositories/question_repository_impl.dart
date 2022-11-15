import 'package:hangman/features/question/data/data_source/question_data_source.dart';
import 'package:hangman/features/question/data/models/letter.dart';
import 'package:hangman/features/question/data/models/messed_up_question.dart';

import '../../domain/repositories/question_repository.dart';

class QuestionRepository extends IQuestionRepository {
  final QuestionDataSource source;
  QuestionRepository({
    required this.source,
  });

  @override
  Future<MessedUpQuestion> getMessedUpQuestion(String category) {
    return source.getMessedUpQuestion(category);
  }

  @override
  Future<Letter> getLetter(String category) {
    return source.getLetter(category);
  }
}
