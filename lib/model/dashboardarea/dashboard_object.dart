
import 'package:json_annotation/json_annotation.dart';
import 'package:orim/model/dashboardarea/services_area.dart';
import 'package:orim/model/dashboardarea/dashboard_area.dart';

part 'dashboard_object.g.dart';
@JsonSerializable()
class DashBoardObjectModel {
  String nameArea;
  String codeArea;
  int sumIssue;
  int processed;
  int processing;
  List<ServicesAreaModel> listService;
  List<DashBoardAreaModel> listDashBoard;

  DashBoardObjectModel({this.nameArea, this.codeArea, this.sumIssue, this.processed, this.processing, this.listService, this.listDashBoard});
  factory DashBoardObjectModel.fromJson(Map<String, dynamic> json) => _$DashBoardObjectModelFromJson(json);
  Map<String, dynamic> toJson() => _$DashBoardObjectModelToJson(this);
}