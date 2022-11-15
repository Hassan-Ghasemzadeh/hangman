part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class GetMessedUpQuestionEvent extends QuestionEvent {
  final String category;
  const GetMessedUpQuestionEvent({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}

class GetLettersEvent extends QuestionEvent {
  final String category;
  const GetLettersEvent({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}
