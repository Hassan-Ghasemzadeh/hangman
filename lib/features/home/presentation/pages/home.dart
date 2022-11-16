import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman/features/home/presentation/bloc/home_bloc.dart';
import 'package:hangman/features/home/presentation/widgets/category_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(),
      child: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'فهرست دسته بندی',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontFamily: 'Shekari',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CategoryList(),
        ],
      ),
    );
  }
}
