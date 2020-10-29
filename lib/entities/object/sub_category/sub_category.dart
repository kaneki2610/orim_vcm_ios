import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/category/category.dart';

part 'sub_category.g.dart';

@JsonSerializable(nullable: true)
class SubCategory extends Category {
  dynamic categoryCode;

  SubCategory({String code, String name, this.categoryCode})
      : super(code: code, name: name);

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
    _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}
