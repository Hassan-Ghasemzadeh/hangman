import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hangman/features/question/presentation/bloc/question_bloc.dart';

class WordPinWidget extends StatelessWidget {
  const WordPinWidget({
    Key? key,
    required this.chars,
  }) : super(key: key);
  final List<String> chars;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      buildWhen: (previous, current) => current is MessedUpQuestionState,
      builder: (context, state) {
        if (state is MessedUpQuestionState) {
          if (state.status.isSuccess) {
            final answer = state.question!.question.title;
            return SizedBox(
              height: 50,
              child: Center(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  reverse: true,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: answer.length,
                  itemBuilder: (context, index) {
                    final currentAnswerChar = answer[index];
                    String? item;
                    for (var i = 0; i < chars.length; i++) {
                      if (chars.contains(currentAnswerChar) &&
                          currentAnswerChar == chars[i]) {
                        item = chars[i];
                      }
                    }

                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Text(
                            item ?? '',
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        }
        return Container();
      },
    );
  }
}
