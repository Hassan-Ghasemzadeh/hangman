import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman/features/auth/data/entity/login_entity.dart';
import 'package:hangman/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hangman/features/auth/presentation/widgets/app_button.dart';
import 'package:hangman/features/auth/presentation/widgets/app_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: const Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'Authentication User',
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 35.0,
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
              data: 'Login',
              onPressed: () {
                context.read<AuthBloc>().add(
                      LoginEvent(
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
                context.read<AuthBloc>().add(NavigateToSignUpEvent());
              },
              child: const Text('sign up for free'),
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
