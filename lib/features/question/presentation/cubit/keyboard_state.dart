part of 'keyboard_cubit.dart';

class KeyboardState extends Equatable {
  const KeyboardState(
    this.letters,
    this.wrongLetters,
  );
  final List<String> letters;

  final List<String> wrongLetters;
  @override
  List<Object> get props => [
        ...letters,
        ...wrongLetters,
        Random.secure().nextInt(100),
      ];
}
