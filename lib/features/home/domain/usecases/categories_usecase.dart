import 'package:get_it/get_it.dart';
import 'package:hangman/core/usecase_tool/usecase_tool.dart';
import 'package:hangman/features/home/data/models/category.dart';
import 'package:hangman/features/home/data/repositories/home_repository_impl.dart';

class CategoriesUseCase extends INoParamUseCase<Category> {
  HomeRepository get repository => GetIt.I.get<HomeRepository>();
  @override
  Future<Category> invoke() {
    return repository.getCategories();
  }
}
