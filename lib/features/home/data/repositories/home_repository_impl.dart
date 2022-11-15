import 'package:hangman/features/home/data/data_source/home_data_source.dart';
import 'package:hangman/features/home/data/models/category.dart';
import 'package:hangman/features/home/domain/repositories/home_repository.dart';

class HomeRepository extends IHomeRepository {
  final HomeDataSource source;
  HomeRepository({
    required this.source,
  });

  @override
  Future<Category> getCategories() {
    return source.getCategories();
  }
}
