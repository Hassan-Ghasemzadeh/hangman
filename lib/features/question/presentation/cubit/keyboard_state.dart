part of 'keyboard_cubit.dart';

class KeyboardState extends Equatable {
  const KeyboardState(
    this.letters,
    this.wrongLetters,
    this.correctLetters,
  );
  final List<String> letters;

  final List<String> wrongLetters;
  final List<String> correctLetters;
  @override
  List<Object> get props => [
        ...letters,
        ...wrongLetters,
        Random.secure().nextInt(100),
      ];
}
