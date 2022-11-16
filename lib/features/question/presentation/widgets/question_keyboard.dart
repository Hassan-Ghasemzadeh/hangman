import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman/features/question/presentation/cubit/keyboard_cubit.dart';
import '../bloc/question_bloc.dart';

class QuestionKeyboard extends StatefulWidget {
  const QuestionKeyboard({
    Key? key,
    required this.question,
  }) : super(key: key);
  final String question;
  @override
  State<QuestionKeyboard> createState() => _QuestionKeyboardState();
}

class _QuestionKeyboardState extends State<QuestionKeyboard> {
  @override
  void didChangeDependencies() {
    context.read<KeyboardCubit>().clearTheLetters();
    context.read<QuestionBloc>().add(
          GetLettersEvent(category: widget.question),
        );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      buildWhen: (previous, current) => current is LettersState,
      builder: (context, questionState) {
        if (questionState is LettersState) {
          if (questionState.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (questionState.status.isSuccess) {
            return Wrap(
              children: questionState.letter!.letters
                  .map(
                    (char) => GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        margin: const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 64, 196, 255),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10.0,
                            ),
                          ),
                        ),
                        child: Text(
                          char,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Shekari',
                          ),
                        ),
                      ),
                      onTap: () {
                        context
                            .read<KeyboardCubit>()
                            .onCharSelected(char, widget.question);
                      },
                    ),
                  )
                  .toList(),
            );
          }
        }
        return Container();
      },
    );
  }
}
