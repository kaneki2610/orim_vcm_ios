import 'package:json_annotation/json_annotation.dart';
import 'package:orim/utils/time_util.dart';
part 'notification.g.dart';

@JsonSerializable(nullable: true)
class Notification {
  String action;
  String title;
  String content;
  String time;
  String url;
  String idIssue;
  Notification({this.action, this.title, this.content, this.url, String time, this.idIssue}){
    if(time == null || time == ''){
      time = TimeUtil.ddMMYYYYHHMMSS( new DateTime.now());
    }
    this.time = time;
  }

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
