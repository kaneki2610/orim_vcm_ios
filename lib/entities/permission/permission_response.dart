import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/permission/permission.dart';

part 'permission_response.g.dart';

@JsonSerializable(nullable: true)
class PermissionResponse extends ResponseListNew<PermissionModel> {
  List<String> errors;
  bool succeed;
  bool failed;
  dynamic data;

  PermissionResponse({int code, String msg, dynamic dataRes , String msgToken}) : super(code: code, msg: msg) {
    if(dataRes != null) {
      if (dataRes is List) {
        this.datas = (dataRes as List)
            .map((issue) => PermissionModel.fromJson(Menu.fromJson(issue)))
            .toList();
      }
    } else {
      if(errors != null) {
        this.msg = errors.first ?? "Error";
      }
    }
  }

  factory PermissionResponse.fromJson(Map<String, dynamic> json) =>
      _$PermissionResponseFromJson(json);
}

@JsonSerializable(nullable: true)
class Menu {
  String code;
  String name;
  String path;
  String iconPath;
  String description;
  Parent parent;
  int order;
  int status;
  String partition;
  String id;
  String createdOn;

  Menu(
      {this.code,
      this.name,
      this.path,
      this.iconPath,
      this.description,
      this.parent,
      this.order,
      this.status,
      this.partition,
      this.id,
      this.createdOn});

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}

@JsonSerializable(nullable: true)
class Parent {
  String partition;
  String id;

  Parent({this.partition, this.id});

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);

  Map<String, dynamic> toJson() => _$ParentToJson(this);
}
