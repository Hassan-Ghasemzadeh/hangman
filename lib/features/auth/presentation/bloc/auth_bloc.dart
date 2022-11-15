import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman/core/nav_tools/change_route_request.dart';
import 'package:hangman/core/nav_tools/route_params_models.dart';
import 'package:hangman/features/auth/data/entity/login_entity.dart';
import 'package:hangman/features/auth/data/models/user.dart';
import 'package:hangman/features/auth/domain/usecases/login_usecase.dart';

import '../../../../core/nav_tools/nav_tools.dart';
import '../../../../core/nav_tools/route_info_models.dart';
import '../../../home/presentation/pages/home.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase get login => LoginUseCase();
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
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(
      (event, emit) async {
        navigator.overlay?.insert(overlay);
        final result = await login.invoke(event.entity);
        overlay.remove();
        if (result.isOk) {
          ChangeRouteRequest<User>(
            RouteInfo<User>(
              AppRoute.home.path,
              (context) => const HomePage(),
            ),
            RouteParams<User>(result),
          ).dispatch(
            ChangeRouteType.replace,
          );
        } else {
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
      },
    );

    on<NavigateToLoginEvent>(
      (event, emit) {
        ChangeRouteRequest(AppRoute.login.route).dispatch();
      },
    );
    on<NavigateToSignUpEvent>(
      (event, emit) {
        ChangeRouteRequest(AppRoute.signUp.route).dispatch();
      },
    );

    on<SignUpEvent>(
      (event, emit) async {
        navigator.overlay?.insert(overlay);
        final result = await login.invoke(event.entity);
        overlay.remove();
        if (result.isOk) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(navigator.context).removeCurrentSnackBar();
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(navigator.context).showSnackBar(
            const SnackBar(
              content: Text(
                'ثبت نام با موفقیت انجام شد',
              ),
            ),
          );
          ChangeRouteRequest<User>(
            RouteInfo<User>(
              AppRoute.login.path,
              (context) => const HomePage(),
            ),
            RouteParams<User>(result),
          ).dispatch();
        } else {
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
      },
    );
  }
}
