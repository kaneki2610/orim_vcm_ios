import 'package:json_annotation/json_annotation.dart';
import 'package:orim/model/dashboardarea/services_area.dart';

part 'dashboard_area.g.dart';

@JsonSerializable()
class DashBoardAreaModel {
  String nameArea;
  String codeArea;
  int sumIssue;
  int processed;
  int processing;
  List<ServicesAreaModel> listService;

  DashBoardAreaModel({this.nameArea, this.codeArea, this.sumIssue, this.processed, this.processing, this.listService});
  factory DashBoardAreaModel.fromJson(Map<String, dynamic> json) => _$DashBoardAreaModelFromJson(json);
  Map<String, dynamic> toJson() => _$DashBoardAreaModelToJson(this);
}