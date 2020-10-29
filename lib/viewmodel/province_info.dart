import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/province.dart';
import 'package:orim/repositories/province/province_repo.dart';

class ProvinceInfoViewModel extends BaseViewModel<List<ProvinceModel>> {

  ProvinceRepo provinceRepo;

  Future<List<ProvinceModel>> getProvinces() async {
    data = await provinceRepo.getProvinces()..sort((a,b) => a.name.compareTo(b.name));
    return data;
  }

}