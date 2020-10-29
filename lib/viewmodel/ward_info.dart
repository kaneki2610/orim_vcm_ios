import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/ward.dart';
import 'package:orim/repositories/ward/ward_repo.dart';

class WardInfoViewModel extends BaseViewModel<List<WardModel>> {

  WardRepo wardRepo;

  Future<List<WardModel>> getWards({ int codeProvince }) async {
    data = await wardRepo.getWardByCodeProvince(codeProvince)..sort((a,b) => a.name.compareTo(b.name));
    return data;
  }

}