import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hangman/features/question/presentation/bloc/question_bloc.dart';
import 'package:hangman/features/question/presentation/cubit/keyboard_cubit.dart';
import 'package:hangman/features/question/presentation/widgets/dialog.dart';
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
  String answer = '';
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
      backgroundColor: const Color.fromARGB(255, 100, 3, 147),
      bottomNavigationBar: BlocBuilder<QuestionBloc, QuestionState>(
        buildWhen: (previous, current) => current is MessedUpQuestionState,
        builder: (context, state) {
          if (state is MessedUpQuestionState) {
            if (state.status.isSuccess) {
              answer = state.question!.question.title;
              return QuestionKeyboard(question: answer);
            }
          }
          return Container();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 50,
              ),
              Text(
                'دسته بندی ⬅️ $category',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontFamily: 'Shekari',
                ),
              ),
              Row(
                children: [
                  const Text(
                    '1400 ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontFamily: 'Shekari',
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/dollar_coin.svg',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ],
          ),
          BlocConsumer<KeyboardCubit, KeyboardState>(
            listener: (context, state) async {
              if (state.wrongLetters.length == 6) {
                await showAlertDialog(title: 'Game Over');
                navigator.pop();
              }
              if (state.correctLetters.length == answer.length) {
                await showAlertDialog(title: 'You Win');
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
