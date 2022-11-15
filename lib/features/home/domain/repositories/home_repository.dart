import '../../data/models/category.dart';

abstract class IHomeRepository {
  Future<Category> getCategories();
}
