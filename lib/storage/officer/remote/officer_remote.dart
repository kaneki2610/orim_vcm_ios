import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/officer.dart';

abstract class OfficerRemote {
  Future<ResponseListNew<OfficerModel>> getOfficers({String departmentId});
}