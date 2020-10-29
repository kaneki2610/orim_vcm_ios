import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:orim/entities/category/categories_response.dart';
import 'package:orim/entities/category/category.dart';
import 'package:orim/repositories/catergories/categories_repo.dart';
import 'package:orim/utils/api_service.dart';

const String _areaCode = "109_860";

class CategoriesImp implements CategoriesRepo {
  String _subURL = "kong/api/masterdata/v1/service/ListAllServices?areaCode=";

  ApiService apiService;

  @override
  Future<List<CategoryData>> getCategories(
      {String areaCode = _areaCode}) async {
    try {
      final response = await apiService.post('$_subURL$areaCode');
//      print(response);
      if (response.statusCode == 200) {
//        print(json.decode(response.body));
        return CategoriesResponse.fromJson(json.decode(response.body)).list;
      } else {
        throw ('Failed');
      }
    } catch (err) {
      throw err;
    }
  }
}
