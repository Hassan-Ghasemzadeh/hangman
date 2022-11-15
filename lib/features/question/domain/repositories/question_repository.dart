import 'package:hangman/features/question/data/models/letter.dart';

import '../../data/models/messed_up_question.dart';

abstract class IQuestionRepository {
  Future<MessedUpQuestion> getMessedUpQuestion(String category);
  Future<Letter> getLetter(String category);
}
