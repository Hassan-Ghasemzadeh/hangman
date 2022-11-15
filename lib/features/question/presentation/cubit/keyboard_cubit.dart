import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'keyboard_state.dart';

class KeyboardCubit extends Cubit<KeyboardState> {
  KeyboardCubit() : super(const KeyboardState([], []));
  List<String> letters = <String>[];
  List<String> wrongLetter = <String>[];

  void onCharSelected(String char, String question) {
    if (wrongLetter.length < 6) {
      letters.add(char);
      emit(KeyboardState(letters, wrongLetter));
      if (!question.contains(char)) {
        wrongLetter.add(char);
        emit(KeyboardState(letters, wrongLetter));
      }
    }
  }

  void clearTheLetters() {
    if (letters.isNotEmpty) {
      letters.clear();
    }
  }
}
