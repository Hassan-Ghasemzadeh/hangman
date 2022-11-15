import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman/core/http_service_config/response_status.dart';
import 'package:hangman/features/question/data/models/letter.dart';
import 'package:hangman/features/question/domain/usecases/get_letters_usecase.dart';

import '../../../../core/nav_tools/nav_tools.dart';
import '../../data/models/messed_up_question.dart';
import '../../domain/usecases/get_messed_up_question_usecase.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  GetMessedUpQuestionUsecase get getQuestion => GetMessedUpQuestionUsecase();
  GetLettersUsecase get getLetters => GetLettersUsecase();
  late String question;
  final overlay = OverlayEntry(
    builder: (context) {
      return Center(
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.7),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ),
      );
    },
  );
  QuestionBloc() : super(QuestionInitial()) {
    on<GetMessedUpQuestionEvent>((event, emit) async {
      question = '';
      emit(
        const MessedUpQuestionState(
          status: ResponseStatus.loading,
        ),
      );
      navigator.overlay?.insert(overlay);
      final result = await getQuestion.invoke(event.category);
      overlay.remove();
      if (result.isOk) {
        question = result.question.title;
        emit(
          MessedUpQuestionState(
            question: result,
            status: ResponseStatus.success,
          ),
        );
      } else {
        emit(
          const MessedUpQuestionState(
            status: ResponseStatus.failed,
          ),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(navigator.context).removeCurrentSnackBar();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(navigator.context).showSnackBar(
          SnackBar(
            content: Text(
              result.statusMessage,
            ),
          ),
        );
      }
    });

    on<GetLettersEvent>((event, emit) async {
      emit(
        const LettersState(
          status: ResponseStatus.loading,
        ),
      );
      navigator.overlay?.insert(overlay);

      final result = await getLetters.invoke(event.category);
      overlay.remove();
      if (result.isOk) {
        emit(
          LettersState(
            letter: result,
            status: ResponseStatus.success,
          ),
        );
      } else {
        emit(
          const LettersState(
            status: ResponseStatus.failed,
          ),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(navigator.context).removeCurrentSnackBar();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(navigator.context).showSnackBar(
          SnackBar(
            content: Text(
              result.statusMessage,
            ),
          ),
        );
      }
    });
  }
}
