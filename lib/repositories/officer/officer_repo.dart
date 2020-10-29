import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/officer.dart';

abstract class OfficerRepo {
  Future<ResponseListNew<OfficerModel>> getOfficer({ String departmentId });
}