part of 'dashboard_area.dart';
DashBoardAreaModel _$DashBoardAreaModelFromJson(Map<String, dynamic> json) {
  return DashBoardAreaModel(
      nameArea: json['areaName'] as String,
      codeArea: json['areaCode'] as String,
      sumIssue: json['sum'] as int,
      processed: json['processed'] as int,
      processing: json['processing'] as int,
      listService: (json['services'] as List).map((e) {
        return  ServicesAreaModel.fromJson(e as Map<String, dynamic>);
      }).toList()
  );
}

Map<String, dynamic> _$DashBoardAreaModelToJson(DashBoardAreaModel instance) =>
    <String, dynamic>{
      'areaName': instance.nameArea,
      'areaCode': instance.codeArea,
      'sum': instance.sumIssue,
      'processed': instance.processed,
      'processing': instance.processing,
      'services': instance.listService
    };
