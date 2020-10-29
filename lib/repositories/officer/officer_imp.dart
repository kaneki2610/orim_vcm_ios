import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/repositories/officer/officer_repo.dart';
import 'package:orim/storage/officer/remote/officer_remote.dart';

class OfficerImp implements OfficerRepo {

  OfficerRemote officerRemote;

  @override
  Future<ResponseListNew<OfficerModel>> getOfficer({ String departmentId }) async {
    ResponseListNew<OfficerModel> res = await officerRemote.getOfficers(departmentId: departmentId);
    return res;
  }
}
