import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman/features/home/presentation/bloc/home_bloc.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final String item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<HomeBloc>().add(
              NavigateToCategoryPage(category: item),
            );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 50,
          padding: const EdgeInsets.only(right: 10, top: 10),
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            item,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 30,
              fontFamily: 'Shekari',
            ),
          ),
        ),
      ),
    );
  }
}
