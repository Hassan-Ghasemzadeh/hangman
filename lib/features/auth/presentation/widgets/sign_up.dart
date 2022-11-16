import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman/core/nav_tools/nav_tools.dart';
import 'package:hangman/features/auth/presentation/widgets/app_button.dart';
import 'package:hangman/features/auth/presentation/widgets/app_text_field.dart';

import '../../data/entity/login_entity.dart';
import '../bloc/auth_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: const SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'User Authentication',
            style: TextStyle(
              fontFamily: 'Swagstie',
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SignUp',
              style: TextStyle(
                fontSize: 35.0,
                fontFamily: 'Swagstie',
              ),
            ),
            AppTextField(
              hintText: 'your username',
              prefixIcon: const Icon(
                Icons.person,
              ),
              keyboardType: TextInputType.name,
              controller: _controllers['username'],
            ),
            AppTextField(
              hintText: 'your password',
              prefixIcon: const Icon(
                Icons.password,
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: _controllers['password'],
            ),
            AppButton(
              data: 'Sign Up',
              onPressed: () {
                context.read<AuthBloc>().add(
                      SignUpEvent(
                        entity: LoginEntity(
                          username: _controllers['username']!.text,
                          password: _controllers['password']!.text,
                        ),
                      ),
                    );
              },
            ),
            TextButton(
              onPressed: () {
                navigator.pop();
              },
              child: const Text(
                'back to login',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Swagstie',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Map<String, TextEditingController> _controllers = {
  'username': TextEditingController(),
  'password': TextEditingController(),
};
