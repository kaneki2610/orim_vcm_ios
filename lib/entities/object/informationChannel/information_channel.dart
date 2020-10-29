import 'package:json_annotation/json_annotation.dart';

part 'information_channel.g.dart';

@JsonSerializable(nullable: true)
class InformationChannel {
  String uid;
  String callerid;
  String agent;
  String smsid;
  String msgid;
  String phone;
  String message;
  String username;
  String fromdate;
  String todate;
  String deviceid;
  String typedeviceid;

  InformationChannel(
      {this.uid,
        this.callerid,
        this.agent,
        this.smsid,
        this.phone,
        this.message,
        this.username,
        this.msgid,
        this.fromdate,
        this.todate,
        this.deviceid,
        this.typedeviceid});

  factory InformationChannel.fromJson(Map<String, dynamic> json) =>
      _$InformationChannelFromJson(json);

  Map<String, dynamic> toJson() => _$InformationChannelToJson(this);
}
