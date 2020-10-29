part of 'dashboard_object.dart';

DashBoardObjectModel _$DashBoardObjectModelFromJson (Map<String, dynamic> json) {
  return DashBoardObjectModel(
      nameArea: json['areaName'] as String,
      codeArea: json['areaCode'] as String,
      sumIssue: json['sum'] as int,
      processed: json['processed'] as int,
      processing: json['processing'] as int,
      listService: (json['services'] as List).map((e) {
        return  ServicesAreaModel.fromJson(e as Map<String, dynamic>);
      }).toList(),
      listDashBoard: (json['children'] as List).map((d){
        return DashBoardAreaModel.fromJson(d as Map<String, dynamic>);
      }).toList()

  );
}

Map<String, dynamic> _$DashBoardObjectModelToJson(DashBoardObjectModel instance) =>
    <String, dynamic>{
      'areaName': instance.nameArea,
      'areaCode': instance.codeArea,
      'sum': instance.sumIssue,
      'processed': instance.processed,
      'processing': instance.processing,
      'services': instance.listService,
      'children': instance.listDashBoard
    };
