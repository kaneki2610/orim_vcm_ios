import 'package:orim/entities/category/category.dart';

abstract class CategoriesRepo {
  Future<List<CategoryData>> getCategories({String areaCode});
}
