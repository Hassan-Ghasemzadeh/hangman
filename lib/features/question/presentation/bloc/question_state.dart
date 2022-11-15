part of 'question_bloc.dart';

abstract class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

class QuestionInitial extends QuestionState {}

class MessedUpQuestionState extends QuestionState {
  final MessedUpQuestion? question;
  final ResponseStatus status;
  const MessedUpQuestionState({
    this.question,
    required this.status,
  });
  @override
  List<Object> get props => [
        if (question != null) question!,
        status,
      ];
}

class LettersState extends QuestionState {
  final Letter? letter;
  final ResponseStatus status;
  const LettersState({
    this.letter,
    required this.status,
  });
  @override
  List<Object> get props => [
        if (letter != null) letter!,
        status,
      ];
}
