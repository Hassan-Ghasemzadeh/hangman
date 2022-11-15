import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman/core/http_service_config/response_status.dart';
import 'package:hangman/core/nav_tools/change_route_request.dart';
import 'package:hangman/core/nav_tools/route_params_models.dart';
import 'package:hangman/features/home/domain/usecases/categories_usecase.dart';

import '../../../../core/nav_tools/nav_tools.dart';
import '../../../../core/nav_tools/route_info_models.dart';
import '../../../question/presentation/pages/question_page.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  CategoriesUseCase get categories => CategoriesUseCase();
  List<String> categoriesList = [];
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
  HomeBloc() : super(HomeInitial()) {
    on<GetCategories>((event, emit) async {
      emit(
        CategoriesState(
          categories: categoriesList,
          status: ResponseStatus.loading,
        ),
      );
      navigator.overlay?.insert(overlay);
      final result = await categories.invoke();
      categoriesList = result.categories;
      overlay.remove();
      if (result.isOk) {
        emit(
          CategoriesState(
            categories: categoriesList,
            status: ResponseStatus.success,
          ),
        );
      } else {
        emit(
          CategoriesState(
            categories: categoriesList,
            status: ResponseStatus.failed,
          ),
        );
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
    });

    on<NavigateToCategoryPage>((event, emit) async {
      ChangeRouteRequest<String>(
        RouteInfo<String>(
          AppRoute.question.path,
          (context) => const QuestionPage(),
        ),
        RouteParams<String>(event.category),
      ).dispatch();
    });
  }
}
