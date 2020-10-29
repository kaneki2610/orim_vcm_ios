import 'package:orim/model/province.dart';

abstract class ProvinceRepo {
  Future<List<ProvinceModel>> getProvinces();
}