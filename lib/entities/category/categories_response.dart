import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/category/category.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  String msg;
  int error;
  List<CategoryData> list;

  CategoriesResponse({ this.msg, this.error, this.list});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => _$CategoriesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}