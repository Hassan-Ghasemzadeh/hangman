part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final LoginEntity entity;
  const LoginEvent({
    required this.entity,
  });

  @override
  List<Object> get props => [entity];
}

class NavigateToLoginEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class NavigateToSignUpEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  final LoginEntity entity;
  const SignUpEvent({
    required this.entity,
  });
  @override
  List<Object> get props => [entity];
}
