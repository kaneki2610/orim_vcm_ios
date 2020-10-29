part of 'dashboard_resquest.dart';

DashboardRequest _$dashboardRequestFromJson (Map<String, dynamic> json) {
  return DashboardRequest(
    areaCodeStatic: json['areaCodeStatic'] as String,
    kindOfTime: json['kindOfTime'] as String,
  );
}

Map<String, dynamic> _$DashBoardRequestToJson(DashboardRequest instance) =>
    <String, dynamic> {
      'areaCodeStatic': instance.areaCodeStatic,
      'kindOfTime': instance.kindOfTime
    };