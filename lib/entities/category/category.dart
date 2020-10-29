import 'package:json_annotation/json_annotation.dart';
import 'package:orim/config/strings_resource.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryData {
  String areaCode;
  String code;
  String desc;
  int flag;
  String icon;
  String id;
  String name;
  int orders;
  String parentCode;
  int status;
  String type;

  List<CategoryData> subCategories = []; // group

  CategoryData(
      {this.areaCode,
      this.code,
      this.desc,
      this.flag,
      String icon,
      this.id,
      this.name,
      this.orders,
      this.parentCode,
      this.status,
      this.type,
      subCategories}) {
    if (icon != null && icon != '') {
      this.icon = StringResource.getLinkResource(icon);
    }
    if (subCategories != null) {
      this.subCategories = subCategories;
    } else {
      this.subCategories = [];
    }
  }

  int indexOfSub(CategoryData categoryData) {
    for (final cat in subCategories) {
      if (cat.code == categoryData.code && cat.parentCode == categoryData.parentCode) {
        int index = subCategories.indexOf(cat);
        return index;
      }
    }
    return -1;
  }

  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);

  bool isParent() => parentCode == "";
}
