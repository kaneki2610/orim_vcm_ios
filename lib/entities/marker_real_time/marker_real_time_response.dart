import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/object/marker/marker.dart';
import 'package:orim/model/marker.dart';

part 'marker_real_time_response.g.dart';

@JsonSerializable(nullable: true)
class MarkerRealTimeResponse extends ResponseListNew<MarkerModel> {
  MarkerRealTimeResponse({int code, String msg, dynamic data, String msgToken})
      : super(code: code, msg: msg, msgToken: msgToken) {
    if (data is List) {
      this.datas = (data as List)
          .map((m) => MarkerModel.from(Marker.fromJson(m)))
          .toList();
    } else if (data is Map<String, dynamic>) {
      Map<String, dynamic> map = data;
      this.datas = (map["data"] as List)
          .map((m) => MarkerModel.from(Marker.fromJson(m)))
          .toList();
    }
  }

  factory MarkerRealTimeResponse.fromJson(Map<String, dynamic> json) =>
      _$MarkerRealTimeReponseFromJson(json);

/*  Map<String, dynamic> toJson() => _$MarkerRealTimeReponseToJson(this);*/
}
