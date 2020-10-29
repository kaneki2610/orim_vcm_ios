import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/get_officer/officer_entity.dart';
import 'package:orim/model/officer.dart';

part 'officer_response.g.dart';

@JsonSerializable(nullable: true)
class OfficerResponse extends ResponseListNew<OfficerModel> {
  OfficerResponse({String msg, int code, dynamic data})
      : super(code: code, msg: msg) {
    if (data is List) {
      final List<OfficerEntity> list =
          data.map((e) => OfficerEntity.fromJson(e)).toList();
      this.datas = list
          .map((item) => OfficerModel(
              id: item.id,
              fullname: item.fullname,
              departmentId:
                  item.isNotHaveDepartment() ? item.departments[0].id : "",
              departmentName:
                  item.isNotHaveDepartment() ? item.departments[0].name : ""))
          .toList();
    }
  }

  factory OfficerResponse.fromJson(dynamic json) =>
      _$OfficerResponseFromJson(json);
}
