import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman/core/http_service_config/response_status.dart';
import 'package:hangman/features/home/presentation/bloc/home_bloc.dart';

import '../../../../core/nav_tools/nav_tools.dart';
import 'list_item.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(GetCategories());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is CategoriesState,
      builder: (context, state) {
        if (state is CategoriesState) {
          if (state.status == ResponseStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ResponseStatus.success) {
            return SizedBox(
              height: MediaQuery.of(navigator.context).size.height,
              child: ListView.builder(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final item = state.categories[index];
                  return ListItem(
                    item: item,
                  );
                },
              ),
            );
          }
        }
        return Container();
      },
    );
  }
}
