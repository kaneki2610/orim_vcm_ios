import 'package:flutter/cupertino.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/entities/category/category.dart';
import 'package:orim/repositories/catergories/categories_repo.dart';

class CategoryViewModel extends BaseViewModel<List<CategoryData>> {

  CategoriesRepo categoriesRepo;

  Future<List<CategoryData>> loadData() async {
    data = [];
    var categoriesServer = await categoriesRepo.getCategories();
    for (var i = 0; i < categoriesServer.length; i++) {
      if (categoriesServer[i].isParent()) {
        data.add(categoriesServer[i]);
        for (var z = 0; z < categoriesServer.length; z++) {
          if (i != z &&
              data[data.length - 1].code == categoriesServer[z].parentCode &&
              categoriesServer[z].parentCode != '') {
            data[data.length - 1].subCategories.add(categoriesServer[z]);
          }
        }
      }
    }
    dataObserver.value = data;
    return data;
  }

  Future<CategoryData> getCategoryByCodeAndParentCode(String parentCode, String code) async {
    if (data.isNotEmpty) {
      for (final categoryParent in data) {
        if (categoryParent.code == parentCode) {
          CategoryData categoryParentRes = CategoryData.fromJson(categoryParent.toJson());
          categoryParentRes.subCategories = categoryParent.subCategories.map((category) => category).toList();
//          print('categoryParentRes.subCategories ${categoryParentRes.subCategories == categoryParent.subCategories}');
          for (final category in categoryParentRes.subCategories) {
            if (category.code == code && category.parentCode == parentCode) {
              CategoryData categoryParentChild = CategoryData.fromJson(category.toJson());
              categoryParentRes.subCategories.clear();
              categoryParentRes.subCategories.add(categoryParentChild);
//              print('categoryParentlength ${categoryParent.subCategories.length}');
              return categoryParentRes;
            }
          }
        }
      }
    }
    return null;
  }
}
