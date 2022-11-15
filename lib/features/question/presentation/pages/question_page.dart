import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman/features/question/presentation/bloc/question_bloc.dart';
import 'package:hangman/features/question/presentation/cubit/keyboard_cubit.dart';
import 'package:hangman/features/question/presentation/widgets/question_keyboard.dart';
import 'package:hangman/features/question/presentation/widgets/word_pin_widget.dart';
import '../../../../core/nav_tools/nav_tools.dart';
import '../../../../core/nav_tools/route_params_models.dart';
import '../widgets/figure.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuestionBloc>(
          create: (context) => QuestionBloc(),
        ),
        BlocProvider<KeyboardCubit>(
          create: (context) => KeyboardCubit(),
        ),
      ],
      child: const Question(),
    );
  }
}

class Question extends StatefulWidget {
  const Question({
    Key? key,
  }) : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  String category = '';

  @override
  void didChangeDependencies() {
    final s = ModalRoute.of(context)!.settings.arguments;
    if (s != null && s is RouteParams<String>) {
      category = s.value;
    }
    context.read<QuestionBloc>().add(
          GetMessedUpQuestionEvent(category: category),
        );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ScaffoldMessenger.of(navigator.context).clearSnackBars();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Question Page'),
        centerTitle: true,
      ),
      bottomNavigationBar: BlocBuilder<QuestionBloc, QuestionState>(
        buildWhen: (previous, current) => current is MessedUpQuestionState,
        builder: (context, state) {
          if (state is MessedUpQuestionState) {
            if (state.status.isSuccess) {
              return QuestionKeyboard(question: state.question!.question.title);
            }
          }
          return Container();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text(
              'دسته بندی ⬅️ $category',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          BlocConsumer<KeyboardCubit, KeyboardState>(
            listener: (context, state) async {
              if (state.wrongLetters.length == 6) {
                await showDialog(
                  context: context,
                  barrierColor: Colors.white.withOpacity(0.2),
                  builder: (ctx) => BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 241, 53, 163),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Text(
                                'Game Over',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
                navigator.pop();
              }
            },
            builder: (context, state) {
              return Center(
                child: Stack(
                  children: [
                    figure(
                      state.wrongLetters.length,
                    ),
                  ],
                ),
              );
            },
          ),
          BlocBuilder<KeyboardCubit, KeyboardState>(
            builder: (context, state) {
              return WordPinWidget(
                chars: state.letters,
              );
            },
          )
        ],
      ),
    );
  }
}
